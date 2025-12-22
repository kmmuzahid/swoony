// lib/services/dio_service.dart
// ignore_for_file: avoid_annotating_with_dynamic

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/storage/storage_service.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:dio/dio.dart' as dio; // Alias Dio as dio to avoid conflict with FormData
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import '../dependency/dependency_injection.dart';
import 'dio_request_builder.dart';
import 'request_input.dart'; // Import the updated RequestInput
import 'response_state.dart';
import 'package:http/http.dart' as http;

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Dio service for the app
// Callback for request state changes
typedef OnRequestStateChange<T> = void Function(ResponseState<T> state);

class DioService {
  DioService._(this._dio, this._storageService, {required this.onLogout})
    : _debugMode = AppLogger.enableLogs;
  AuthCubit? authCubit;
  static final String _baseUrl = ApiEndPoint.instance.baseUrl;
  final Dio _dio;
  final StorageService _storageService;
  final bool _debugMode;
  Completer<void>? _refreshCompleter; // Manages the single refresh operation
  final Function()? onLogout;
  final List<_QueuedRequest> _queue = []; // Stores requests waiting for token refresh
  bool _isServerOff = false;
  bool _isNetworkOff = false;
  bool _hasShownNetworkError = false;
  DateTime? _lastServerShutodown;

  bool get isServerOff => _isServerOff;
  bool get isNetworkOff => _isNetworkOff;

  String? getAccessToken() => authCubit?.state.userLoginInfoModel.accessToken;
  String? getRefreshToken() => authCubit?.state.userLoginInfoModel.refreshToken;

  Future<bool> _isNetworkAvailable() async {
    try {
      final response = await http
          .get(Uri.parse('https://clients3.google.com/generate_204'))
          .timeout(const Duration(seconds: 3));

      return response.statusCode == 204;
    } catch (_) {
      return false;
    }
  }

  Future<void> _checkAndHandleNetworkStatus() async {
    final hasNetwork = await _isNetworkAvailable();

    if (!hasNetwork) {
      if (!_isNetworkOff) {
        _isNetworkOff = true;
        if (!_hasShownNetworkError) {
          _hasShownNetworkError = true;
          if (appRouter.navigatorKey.currentContext != null) {
            showSnackBar('No internet connection', type: SnackBarType.error);
          }
        }
      }
      return;
    }

    // If we have network but server was down, reset the flags
    if (_isServerOff) {
      _isServerOff = false;
    }
    if (_isNetworkOff) {
      _isNetworkOff = false;
      _hasShownNetworkError = false;
    }
  }

  static Future<DioService> create({Function()? onLogout}) async {
    await getIt.isReady<StorageService>();
    final StorageService storageService = getIt.get();
    AppLogger.debug('Dio has been created', tag: 'dio');
    final dioInstance = Dio(
      dio.BaseOptions(
        baseUrl: _baseUrl, // Replace with your actual base URL
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    final instance = DioService._(dioInstance, storageService, onLogout: onLogout);

    // Add interceptor here after Dio instance is created
    instance._addInterceptors();
    return instance;
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          authCubit ??= appRouter.navigatorKey.currentContext?.read<AuthCubit>();
          final requestId = DateTime.now().millisecondsSinceEpoch;
          options.extra['requestId'] = requestId;

          if (options.extra['requiresToken'] ?? true) {
            await _injectToken(options);
          }

          if (_debugMode) {
            final headers = Map<String, dynamic>.from(options.headers)
              ..removeWhere((key, _) => key == 'authorization');

            AppLogger.apiDebug(
              '🚀 [REQ:${options.method} ${options.path}] ID: $requestId\n'
              '🔹 Headers: $headers\n'
              '🔹 Query: ${options.queryParameters}\n'
              '🔹 Data:  ${options.data is FormData ? options.data.fields : options.data?.toString().substring(0, options.data.toString().length > 200 ? 200 : null)}',

              tag: options.path,
            );
          }
          handler.next(options); // Fix: Pass options instead of response
        },
        onResponse: (response, handler) {
          if (_debugMode) {
            final requestId = response.requestOptions.extra['requestId'];
            AppLogger.apiDebug(
              '✅ [RES:${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}] ID: $requestId\n'
              '🔹 Status: ${response.statusCode} ${response.statusMessage}\n'
              '🔹 Data: ${response.data.toString().substring(0, response.data.toString().length > 200 ? 200 : null)}'
              '${response.data.toString().length > 200 ? '...' : ''}',
              tag: response.requestOptions.path,
            );
          }
          handler.next(response);
        },
        onError: (DioException error, handler) async {
          final requestId = error.requestOptions.extra['requestId'] as int? ?? 0;
          final statusCode = error.response?.statusCode;
          final path = error.requestOptions.path;

          if (_debugMode) {
            AppLogger.apiError(
              '❌ [ERR:$statusCode ${error.requestOptions.method} $path] ID: $requestId\n'
              '🔹 Error: ${error.message}\n'
              '🔹 Type: ${error.type}\n'
              '🔹 Response: ${error.response?.data?.toString() ?? 'No response data'}',

              tag: path,
            );
            AppLogger.apiError(
              'Error Data: ${error.response?.data}',
              tag: error.requestOptions.path,
            );
          }

          // First check network status
          await _checkAndHandleNetworkStatus();

          if (statusCode == 401 && path != ApiEndPoint.instance.refreshToken) {
            if (_refreshCompleter == null) {
              _refreshCompleter = Completer<void>();
              AppLogger.apiDebug(
                '🔄 [AUTH] Token expired. Attempting to refresh...\n'
                '🔹 Request ID: $requestId',
                tag: 'Auth',
              );

              try {
                await _refreshTokenIfNeeded();
                AppLogger.apiDebug(
                  '🔄 [AUTH] Token refresh successful\n'
                  '🔹 Request ID: $requestId',
                  tag: 'Auth',
                );
                final response = await _dio.fetch(error.requestOptions);
                handler.resolve(response);
              } catch (e) {
                AppLogger.apiError(
                  '❌ [AUTH] Token refresh failed\n'
                  '🔹 Request ID: $requestId\n'
                  '🔹 Error: $e',
                  tag: 'Auth',
                );
                await clearTokens();
                onLogout?.call(); // Trigger logout
                handler.reject(error); // Reject the original request with the error
              } finally {
                _refreshCompleter?.complete();
                _refreshCompleter = null;
                _processQueue(); // Process any queued requests
              }
            } else {
              final responseCompleter = Completer<dio.Response>();
              _queue.add(_QueuedRequest(error.requestOptions, responseCompleter));
              return responseCompleter.future.then(handler.resolve).catchError((
                Object err,
                StackTrace stackTrace,
              ) {
                if (err is DioException) {
                  handler.reject(err);
                } else {
                  handler.reject(
                    DioException(
                      requestOptions: error.requestOptions,
                      error: err,
                      stackTrace: stackTrace,
                      message: err.toString(),
                    ),
                  );
                }
              });
            }
          } else if (statusCode == 401 && path == ApiEndPoint.instance.refreshToken) {
            AppLogger.apiError(
              '401 received from refresh token endpoint. Logging out.',
              tag: 'Auth',
            );
            await clearTokens();
            onLogout?.call();
            handler.reject(error);
          } else if (error.response?.statusCode == 404) {
            handler.next(error);
          } else {
            handler.next(error);
          }
        },
      ),
    );
  }

  Future<void> _injectToken(RequestOptions options) async {
    final accessToken = authCubit?.state.userLoginInfoModel.accessToken;
    if (accessToken?.isNotEmpty == true) {
      options.headers['Authorization'] =
          'Bearer ${authCubit?.state.userLoginInfoModel.accessToken}';
    }
  }

  Future<void> _saveTokens(String access, String refresh) async {
    await authCubit?.updateToken(accessToken: access, refreshToken: refresh);
  }

  Future<void> clearTokens() async {
    await _storageService.deleteAll();
    AppLogger.apiDebug('Tokens cleared.', tag: 'Auth');
  }

  Future<ResponseState<T?>> request<T>({
    required RequestInput input,
    required T? Function(dynamic data) responseBuilder,
    int retryCount = 0,
    int maxRetry = 2,
    bool showMessage = false,
    bool debug = false,
    bool isRetry = false,
  }) async {
    final cancelToken = CancelToken();

    if (debug) {
      return await _requestBuilder(
        input: input,
        responseBuilder: responseBuilder,
        cancelToken: cancelToken,
        showMessage: showMessage,
      );
    }

    try {
      return await _requestBuilder(
        showMessage: showMessage,
        input: input,
        responseBuilder: responseBuilder,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        AppLogger.apiDebug('Request cancelled: ${e.message}', tag: input.endpoint);
        if (showMessage) {
          showSnackBar(e.message ?? '', type: SnackBarType.error);
        }
        return ResponseState(
          data: null,
          message: e.message,
          isSuccess: false,
          cancelToken: cancelToken,
          statusCode: e.response?.statusCode,
        );
      }

      if (e.response?.statusCode != null && e.response!.statusCode! >= 500) {
        if (retryCount < maxRetry) {
          await Future.delayed(Duration(seconds: 1 * (retryCount + 1)));

          return request<T>(
            input: input,
            responseBuilder: responseBuilder,
            retryCount: retryCount + 1,
            maxRetry: maxRetry,
            showMessage: showMessage,
            isRetry: true,
          );
        }
      }

      if (e.response?.data != null) {
        try {
          final parsed = e.response?.data['data'] != null
              ? responseBuilder(e.response?.data['data'])
              : null;
          final bool isSuccess = e.response?.data['success'] ?? false;
          // Extract message from JSON response, fallback to statusMessage if not present
          final message = e.response!.data is Map && e.response!.data['message'] != null
              ? e.response!.data['message'].toString()
              : e.response!.statusMessage;
          if (showMessage) {
            showSnackBar(message ?? '', type: SnackBarType.error);
          }
          return ResponseState(
            data: parsed,
            isSuccess: isSuccess,
            message: message,
            cancelToken: cancelToken,
            statusCode: e.response!.statusCode,
          );
        } catch (parseError) {
          AppLogger.apiError('Failed to parse error response: $parseError', tag: input.endpoint);
        }
      }

      if (_shouldRetry(e) && retryCount < maxRetry) {
        AppLogger.apiDebug('Retrying request (attempt ${retryCount + 1})...', tag: input.endpoint);
        await Future.delayed(const Duration(milliseconds: 300));
        return request(
          // Recursive call to retry
          input: input,
          responseBuilder: responseBuilder,
          retryCount: retryCount + 1,
          maxRetry: maxRetry,
        );
      } else if (retryCount == maxRetry &&
          !_isServerOff &&
          (_lastServerShutodown == null ||
              _lastServerShutodown?.isBefore(DateTime.now().subtract(const Duration(minutes: 1))) ==
                  true)) {
        _lastServerShutodown = DateTime.now();
        // Only show error message on the last retry attempt
        if (appRouter.navigatorKey.currentContext != null) {
          showSnackBar(
            'Server is currently unavailable. Please try again later.',
            type: SnackBarType.error,
          );
        }
        _isServerOff = true;
      }

      final err = _parseError(e);
      AppLogger.apiError('Request failed: $err', tag: input.endpoint);
      return ResponseState(
        data: null,
        message: e.message,
        isSuccess: false,
        cancelToken: cancelToken,
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      final err = e.toString();
      AppLogger.apiError('Unknown error occurred: $err', tag: input.endpoint);
      return ResponseState(
        data: null,
        isSuccess: false,
        message: e.toString(),
        cancelToken: cancelToken,
        statusCode: 0,
      );
    }
  }

  Future<ResponseState<T?>> _requestBuilder<T>({
    required RequestInput input,
    required T? Function(dynamic data) responseBuilder,
    required CancelToken cancelToken,
    required bool showMessage,
  }) async {
    final requestOptions = await DioRequestBuilder.instance.build(
      input: input,
      accessToken: getAccessToken(),
    );

    dio.Response response;
    response = await _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: requestOptions.options,
      cancelToken: cancelToken,
      onSendProgress: input.onSendProgress,
      onReceiveProgress: input.onReceiveProgress,
    );

    if (kDebugMode) {
      AppLogger.apiDebug(response.data.toString(), tag: input.endpoint);
    }

    final parsed = response.data['data'] != null ? responseBuilder(response.data['data']) : null;

    final message = response.data is Map && response.data['message'] != null
        ? response.data['message'].toString()
        : response.statusMessage;
    if (showMessage && (response.statusCode == 200 || response.statusCode == 201)) {
      showSnackBar(message ?? '', type: SnackBarType.success);
    }

    return ResponseState(
      data: parsed,
      message: message,
      isSuccess: response.data['success'],
      cancelToken: cancelToken,
      statusCode: response.statusCode,
    );
  }

  Future<void> _refreshTokenIfNeeded() async {
    final refreshToken = authCubit?.state.userLoginInfoModel.refreshToken;

    if (refreshToken?.isEmpty == true || refreshToken == null) {
      AppLogger.debug('No refresh token available.', tag: 'DIO service');
      return;
    }
    try {
      final response = await http.post(
        Uri.parse('${ApiEndPoint.instance.baseUrl}${ApiEndPoint.instance.refreshToken}'),
        headers: {'refreshtoken': refreshToken},
      );

      if (response.body.isNotEmpty && (response.statusCode == 200 || response.statusCode == 201)) {
        final data = jsonDecode(response.body);
        final access = data['data']['access_token'];
        final refresh = data['data']['refresh_token'];
        await _saveTokens(access, refresh);
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        showSnackBar(data['message'] ?? '', type: SnackBarType.error);
        await clearTokens();
        onLogout?.call();
        return;
      } else {
        throw Exception('Refresh token failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      AppLogger.apiError('DioException during token refresh: ${e.message}', tag: 'Auth');
      throw Exception('Refresh token failed: ${e.message}');
    } catch (e) {
      AppLogger.apiError('Error during token refresh: $e', tag: 'Auth');
      throw Exception('Refresh token failed: $e');
    }
  }

  void _processQueue() {
    while (_queue.isNotEmpty) {
      final req = _queue.removeAt(0);
      _dio
          .fetch(req.requestOptions)
          .then(req.completer.complete)
          .catchError(req.completer.completeError);
    }
  }

  bool _shouldRetry(DioException e) =>
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.unknown;

  // Future<_RequestOptionsData> _buildRequestOptions(RequestInput input) async {
  //   final accessToken = authCubit?.state.userLoginInfoModel.accessToken;

  //   String url = input.endpoint;
  //   input.pathParams?.forEach(
  //     (k, v) => url = url.replaceAll('{$k}', Uri.encodeComponent(v.toString())),
  //   );

  //   final headers = {
  //     if (input.requiresToken && accessToken?.isNotEmpty == true)
  //       'Authorization': 'Bearer $accessToken',
  //     ...?input.headers,
  //   };

  //   dynamic body;
  //   String contentType = 'application/json'; // Default content type

  //   if ((input.files != null && input.files!.isNotEmpty || input.formFields != null) ||
  //       ((input.files != null && input.files!.isNotEmpty) &&
  //           (input.jsonBody != null || input.listBody != null))) {
  //     final formData = dio.FormData();

  //     if (input.formFields != null) {
  //       formData.fields.addAll(input.formFields!.entries.map((e) => MapEntry(e.key, e.value)));
  //     }

  //     if (input.jsonBody != null) {
  //       formData.files.add(
  //         MapEntry(
  //           'data',
  //           dio.MultipartFile.fromString(
  //             jsonEncode(input.jsonBody),
  //             contentType: dio.DioMediaType('application', 'json'),
  //           ),
  //         ),
  //       );
  //     }
  //     if (input.listBody != null) {
  //       formData.files.add(
  //         MapEntry(
  //           'data',
  //           dio.MultipartFile.fromString(
  //             jsonEncode(input.listBody),
  //             contentType: dio.DioMediaType('application', 'json'),
  //           ),
  //         ),
  //       );
  //     }

  //     if (input.files != null && input.files!.isNotEmpty) {
  //       for (final entry in input.files!.entries) {
  //         final key = entry.key;
  //         final file = entry.value;

  //         final multipartFile = await file.toMultipart();
  //         formData.files.add(MapEntry(key, multipartFile));
  //       }
  //     }

  //     body = formData;
  //     contentType = 'multipart/form-data';
  //   } else if (input.jsonBody != null) {
  //     body = input.jsonBody;
  //     contentType = 'application/json';
  //   } else if (input.listBody != null) {
  //     body = jsonEncode(input.listBody);

  //   }

  //   return _RequestOptionsData(
  //     path: url,
  //     data: body,
  //     queryParameters: input.queryParams,
  //     options: dio.Options(
  //       method: input.method.toString().split('.').last.toUpperCase(),
  //       headers: headers,
  //       contentType: contentType,
  //       sendTimeout: input.timeout,
  //       receiveTimeout: input.timeout,
  //       extra: {'requiresToken': input.requiresToken},
  //     ),
  //   );
  // }

  String _parseError(DioException e) {
    if (e.response?.data != null && e.response!.data is Map) {
      final data = e.response!.data as Map<String, dynamic>;
      if (data.containsKey('message')) {
        return data['message'].toString();
      } else if (data.containsKey('error')) {
        return data['error'].toString();
      } else if (data.containsKey('detail')) {
        return data['detail'].toString();
      }
    }
    return e.message ?? 'An unknown error occurred.';
  }
}

class _QueuedRequest {
  _QueuedRequest(this.requestOptions, this.completer);

  final RequestOptions requestOptions;
  final Completer<dio.Response> completer;
}

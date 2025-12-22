// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Response state for the app
class ResponseState<T> {
  ResponseState({
    required this.data,
    required this.statusCode,
    required this.isSuccess,
    this.isRequesting = false,
    this.message,
    this.cancelToken,
  });

  final T data;
  final bool isRequesting;
  final bool isSuccess;
  final String? message;
  final CancelToken? cancelToken;
  final int? statusCode;

  ResponseState<T> copyWith({
    T? data,
    bool? isSuccess,
    bool? isRequesting,
    String? error,
    CancelToken? cancelToken,
    int? responseCode,
  }) {
    return ResponseState<T>(
      data: data ?? this.data,
      isRequesting: isRequesting ?? this.isRequesting,
      message: error ?? this.message,
      cancelToken: cancelToken ?? this.cancelToken,
      isSuccess: isSuccess ?? this.isSuccess,
      statusCode: responseCode ?? this.statusCode,
    );
  }
}

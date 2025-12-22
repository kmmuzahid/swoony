import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/auth/model/profile_model.dart';
import 'package:swoony/common/auth/model/sign_up_model.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/auth/repository/auth_repository.dart';
import 'package:swoony/common/auth/widgets/otp_verify_widget.dart';
import 'package:swoony/common/auth/widgets/terms_and_conditions.dart';
import 'package:swoony/core/component/other_widgets/common_dialog.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/config/socket/socket_service.dart';
import 'package:swoony/core/config/storage/storage_service.dart';
import 'package:swoony/core/utils/helpers/other_helper.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/main.dart';

import 'auth_state.dart';

class AuthCubit extends SafeCubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final AuthRepository _repository = getIt();
  final StorageService _storageService = getIt();
  final DioService _dioService = getIt();
  final String _loginInfo = 'login_info_key';
  final String _profileInfo = 'profile_info_key';
  Role _role = Role.ATTENDEE;

  Future<void> deleteAccount({required String password, required String reason}) async {
    final result = await _repository.deleteAccount(password: password, reason: reason);
    if (result.isSuccess) {
      clear();
    }
  }

  Future<void> updateProfile({
    ProfileModel? profileModel,
    XFile? image,
    bool isDeleteImage = false,
  }) async {
    if ((profileModel == null && image == null) || state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final response = await _repository.updateUser(
      profileModel: profileModel,
      image: image,
      isDeleteImage: isDeleteImage,
    );
    emit(state.copyWith(profileModel: response.data, isLoading: false));
  }

  void switchRole() async {
    _role = state.userLoginInfoModel.role == Role.ATTENDEE ? Role.ORGANIZER : Role.ATTENDEE;
    final model = state.userLoginInfoModel.copyWith(role: _role);
    emit(state.copyWith(userLoginInfoModel: model));
    await _saveUserInfo(model);
    appRouter.replaceAll([const SplashRoute()]);
  }

  void resetPassword({required String verificationToken, required String newPassword}) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final responce = await _repository.resetPassword(
      verificationToken: verificationToken,
      newPassword: newPassword,
    );
    emit(state.copyWith(isLoading: false));
    if (responce.statusCode == 200) {
      appRouter.popUntilRouteWithName(SignInRoute.name);
    }
  }

  void getPolicy() async {
    if (state.termsAndConditions == null || state.termsAndConditions?.isEmpty == true) {
      _repository.getTermsAndConditions().then((value) {
        emit(state.copyWith(termsAndConditions: value.data));
      });
    }

    if (state.privacyPolicy == null || state.privacyPolicy?.isEmpty == true) {
      _repository.getPrivacyPolicy().then((value) {
        emit(state.copyWith(privacyPolicy: value.data));
      });
    }
  }

  void updateTermsConditonsStatus(bool value) async {
    emit(state.copyWith(isTermsAndConditonsAccepted: value));
  }

  void acceptTermsAndConditions() async {
    //need to login if there is no access token to accept terms and conditions
    if (state.userLoginInfoModel.accessToken.isEmpty) {
      final login = await _repository.signIn(
        username: state.signUpModel.email,
        password: state.signUpModel.password,
        role: _role,
      );
      if (login.data != null) {
        await _saveUserInfo(login.data!);
        getCurrentUser();
      }
    }
    //update terms and conditions
    final responce = await _dioService.request<dynamic>(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.profile,
        jsonBody: {'terAndCondition': state.isTermsAndConditonsAccepted},
        method: RequestMethod.PATCH,
      ),
      responseBuilder: (data) => data,
    );

    if (responce.statusCode == 200) {
      await getCurrentUser();
      appRouter.replaceAll([const SplashRoute()]);
    } else {
      showSnackBar(responce.message ?? '', type: SnackBarType.error);
    }
  }

  void onChangeUserRole(Role role) {
    _role = role;
  }

  Future<void> _saveUserInfo(UserLoginInfoModel userInfo) async {
    emit(state.copyWith(userLoginInfoModel: userInfo));
    _storageService.write(_loginInfo, userInfo.toJson());
  }

  Future<void> onChangeSignUpModel(SignUpModel? signUpModel) async {
    if (signUpModel == null) return;
    emit(state.copyWith(signUpModel: signUpModel));
  }

  Future<void> init() async {
    try {
      final String? data = await _storageService.read(_loginInfo);
      final String? profileData = await _storageService.read(_profileInfo);
      if (data != null) {
        _saveUserInfo(UserLoginInfoModel.fromJson(data));
      } else {
        emit(const AuthState());
      }
      if (profileData != null) {
        emit(state.copyWith(profileModel: ProfileModel.fromJson(jsonDecode(profileData))));
      }
      if (state.userLoginInfoModel.accessToken.isNotEmpty) {
        appRouter.replaceAll([const HomeRoute()]);
        SocketService.instance.connect(id: state.userLoginInfoModel.id);
        getCurrentUser();
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          appRouter.replace(const OnboardingRoute());
        });
      }
    } catch (e) {
      AppLogger.error(e.toString(), tag: 'Storage Service');
      AppLogger.error(
        'Now Deleting everything from secure storage to resume, Restart The app',
        tag: 'Storage Service',
      );
      _storageService.deleteAll();
    }
  }

  Future<void> signIn(String username, String password) async {
    if (state.isLoading) return;
    emit(const AuthState(isLoading: true));
    final responce = await _repository.signIn(username: username, password: password, role: _role);
    if (responce.statusCode == 200 && responce.data != null) {
      await _saveUserInfo(responce.data!);
      await getCurrentUser();
      await _saveUserInfo(responce.data!.copyWith(id: state.profileModel?.id));
      emit(state.copyWith(isLoading: false));
      SocketService.instance.connect(id: state.userLoginInfoModel.id);
      appRouter.replaceAll([const HomeRoute()]);
    } else {
      emit(state.copyWith(isLoading: false));
      showSnackBar(responce.message ?? '', type: SnackBarType.error);
      if (responce.message?.contains('verify') ?? false) {
        _verify(username, password);
      }
    }
  }

  Future<void> _verify(String email, String password) async {
    commonDialog(
      context: appRouter.navigatorKey.currentState!.context,
      child: OtpVerifyWidget(
        email: email,
        onSuccess: (verificationToken) {
          signIn(email, password);
        },
      ),
    );
  }

  Future<void> signUp(SignUpModel signUpModel) async {
    getPolicy();
    emit(state.copyWith(isLoading: true));
    final response = await _repository.signUp(signUpModel: signUpModel);
    emit(state.copyWith(isLoading: false));
    if (response.statusCode == 200) {
      _verify(signUpModel.email, signUpModel.password);
    } else {
      showSnackBar(response.message ?? '', type: SnackBarType.error);
    }
  }

  Future<void> signInWithGoogle() async {}

  Future<void> signInWithFacebook() async {}

  Future<void> getCurrentUser() async {
    if (state.userLoginInfoModel.accessToken.isEmpty) return;
    final response = await _repository.getCurrentUser();

    if (response.statusCode == 200 && response.data != null) {
      emit(state.copyWith(profileModel: response.data));
      await _storageService.write(_profileInfo, jsonEncode(response.data!.toJson()));
      if (state.userLoginInfoModel.role == null) {
        await _saveUserInfo(state.userLoginInfoModel.copyWith(role: response.data?.role));
      }
      if (state.profileModel?.termsAndCondition == false) {
        getPolicy();
        TermsAndConditions.instance.show(this);
      }
    }
  }

  Future<void> forgetPassword(String username, String otp) async {}

  Future<void> changePassword({required String newPassword, required String oldPassword}) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final result = await _repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    if (result.isSuccess) {
      _role = Role.ATTENDEE;
      await _storageService.deleteAll();
      appRouter.replaceAll([
        SignInRoute(ctrUsername: TextEditingController(), ctrPassword: TextEditingController()),
      ]);
      emit(const AuthState());
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> updateToken({required String? accessToken, required String? refreshToken}) async {
    _saveUserInfo(
      state.userLoginInfoModel.copyWith(accessToken: accessToken, refreshToken: refreshToken),
    );
  }

  Future<void> logout() async {
    _role = Role.ATTENDEE;
    SocketService.instance.disconnect();
    await _repository.signOut();
    await _storageService.deleteAll();
    appRouter.replaceAll([
      SignInRoute(ctrUsername: TextEditingController(), ctrPassword: TextEditingController()),
    ]);
    emit(const AuthState());
  }

  Future<void> clear() async {
    AppLogger.debug('heeeeeeeeeeeeeeeeeeeeeeeeeeee', tag: 'AuthCubit');
    _role = Role.ATTENDEE;
    SocketService.instance.disconnect();
    await _storageService.deleteAll();
    appRouter.replaceAll([
      SignInRoute(ctrUsername: TextEditingController(), ctrPassword: TextEditingController()),
    ]);
    emit(const AuthState());
  }

  Future<void> calculateAge(DateTime? date) async {
    if (date == null) {
      emit(state.copyWith(age: 0));
      return;
    }

    final now = DateTime.now();
    int age = now.year - date.year;
    if (now.month < date.month || (now.month == date.month && now.day < date.day)) {
      age--;
    }
    if (age < 0) age = 0; // Ensure age is not negative
    emit(state.copyWith(age: age));
  }

  bool isPicking = false;
  Future<void> pickImage() async {
    if (isPicking) return;
    isPicking = true;
    final result = await OtherHelper.openGallery();
    isPicking = false;
    if (result != null) {
      emit(state.copyWith(pickedImage: result));
    }
  }

  Future<void> clearImage() async {
    emit(state.copyWith());
  }
}

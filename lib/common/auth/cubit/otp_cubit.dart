import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swoony/common/auth/repository/auth_repository.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/main.dart';

import 'otp_state.dart';

class OtpCubit extends SafeCubit<OtpState> {
  OtpCubit() : super(const OtpState());
  final AuthRepository _repository = getIt();
  Timer? _timer;

  Future<void> resetState() async {
    emit(const OtpState());
  }

  void changeState(OtpState state) {
    emit(state);
  }

  Future<void> sendOtp(String username) async {
    if (_timer?.isActive == true || state.isLoading) {
      showSnackBar(
        '${AppString.resendCodeIn} ${state.count} ${AppString.seconds}',
        type: SnackBarType.warning,
      );
      return;
    } 


    emit(state.copyWith(isLoading: true));
    final response = await _repository.sendOtp(username: username);
      emit(state.copyWith(isLoading: false));
    if (response.statusCode == 200) {
      _startTimer();
    }
    
  }

  Future<void> verifyOtp({
    required String otp,
    required String email,
    required Function(String verificationToken) onSuccess,
  }) async {
    if (state.isLoading || email.isEmpty || otp.length < 6) return;
    final isVerified = await _repository.verifyOtp(verificationId: email, otp: otp);
    emit(
      state.copyWith(isVerified: isVerified.statusCode == 200, verificationToken: isVerified.data),
    );
    if (isVerified.statusCode == 200) {
      onSuccess(isVerified.data ?? ''); // successfully verified
    } else {
      showSnackBar(isVerified.message ?? '', type: SnackBarType.error);
    }
  }

  void _startTimer() {
    emit(state.copyWith(count: state.maxCount, isLoading: false));
    _timer = null;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(count: state.count - 1));
      if (state.count == 0) {
        _timer?.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

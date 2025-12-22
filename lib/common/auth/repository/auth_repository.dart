import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/auth/model/profile_model.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/auth/model/sign_up_model.dart';
import 'package:swoony/core/config/network/response_state.dart';

abstract class AuthRepository {
  ///email or phone
  Future<ResponseState<UserLoginInfoModel?>> signIn({
    required String username,
    required String password,
    required Role role,
  });

  Future<ResponseState<dynamic>> signUp({required SignUpModel signUpModel});

  Future<ResponseState<dynamic>> sendOtp({required String username});

  Future<ResponseState<dynamic>> verifyOtp({required String verificationId, required String otp});

  Future<ResponseState<dynamic>> changePassword({ 
    required String oldPassword,
    required String newPassword,
  });

  Future<ResponseState<dynamic>> resetPassword({
    required String verificationToken,
    required String newPassword,
  });

  Future<ResponseState<ProfileModel?>> getCurrentUser();

  Future<ResponseState<ProfileModel?>> updateUser({
    ProfileModel? profileModel,
    XFile? image,
    required bool isDeleteImage,
  });

  Future<String> signInWithGoogle();

  Future<String> signInWithFacebook();

  Future<ResponseState<bool>> signOut();

  Future<ResponseState<dynamic>> deleteAccount({required String password, required String reason});

  Future<ResponseState<String?>> getPrivacyPolicy();

  Future<ResponseState<String?>> getTermsAndConditions();
}

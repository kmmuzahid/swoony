// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/auth/model/profile_model.dart';
import 'package:swoony/common/auth/model/sign_up_model.dart';

import '../model/user_login_info_model.dart';

class AuthState extends Equatable {
  const AuthState({
    this.about =
        '<html><body>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem </body></html>',
    this.faqHelp =
        '<html><body>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem </body></html>',

    this.userLoginInfoModel = const UserLoginInfoModel(
      accessToken: '',
      refreshToken: '', 
      role: Role.ATTENDEE,
      id: ''
    ),
    
    this.isLoading = false,
    this.errMessage = '',
    this.signUpModel = const SignUpModel(
      verificationId: '',
      otp: '',
      password: '',
      fullName: '',
      email: '',
      phone: '',
      registrationType: '',
      country: '',
      city: '',
      state: '',
    ),
    this.isTermsAndConditonsAccepted = false,
    this.age = 0,
    this.privacyPolicy,
    this.pickedImage,
    this.termsAndConditions,
    this.profileModel,
  });

  final String? privacyPolicy;
  final String? termsAndConditions;
  final String faqHelp;
  // Fields
  final String about;
  final bool isLoading;
  final String errMessage;
  final UserLoginInfoModel userLoginInfoModel;

  final SignUpModel signUpModel;
  final bool isTermsAndConditonsAccepted;
  final int age;
  final ProfileModel? profileModel;
  final XFile? pickedImage;

  AuthState copyWith({
    bool? isLoading,
    String? errMessage,
    UserLoginInfoModel? userLoginInfoModel,
    SignUpModel? signUpModel,
    String? about,
    String? faqHelp,
    bool? isTermsAndConditonsAccepted,
    String? privacyPolicy,
    String? termsAndConditions,
    int? age,
    ProfileModel? profileModel,
    XFile? pickedImage
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errMessage: errMessage ?? this.errMessage,
      userLoginInfoModel: userLoginInfoModel ?? this.userLoginInfoModel,
      signUpModel: signUpModel ?? this.signUpModel,
      about: about ?? this.about,
      faqHelp: faqHelp ?? this.faqHelp,
      isTermsAndConditonsAccepted: isTermsAndConditonsAccepted ?? this.isTermsAndConditonsAccepted,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      age: age ?? this.age,
      pickedImage: pickedImage,
      profileModel: profileModel ?? this.profileModel,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    errMessage,
    userLoginInfoModel.hashCode,
    signUpModel.hashCode,
    about,
    faqHelp,
    isTermsAndConditonsAccepted,
    privacyPolicy ?? '',
    pickedImage?.path ?? '',
    termsAndConditions ?? '',
    age,
    profileModel ?? '',
  ];
}

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i28;
import 'package:collection/collection.dart' as _i37;
import 'package:flutter/foundation.dart' as _i34;
import 'package:flutter/material.dart' as _i29;
import 'package:swoony/common/auth/screen/change_password_screen.dart' as _i2;
import 'package:swoony/common/auth/screen/forget_password_screen.dart' as _i12;
import 'package:swoony/common/auth/screen/otp_screen.dart' as _i17;
import 'package:swoony/common/auth/screen/profile_info_screen.dart' as _i20;
import 'package:swoony/common/auth/screen/sign_in_screen.dart' as _i23;
import 'package:swoony/common/auth/screen/sign_up_screen.dart' as _i24;
import 'package:swoony/common/chat/model/chat_list_item_model.dart' as _i31;
import 'package:swoony/common/chat/screens/chat_list_screen.dart' as _i3;
import 'package:swoony/common/chat/screens/chat_screen.dart' as _i4;
import 'package:swoony/common/custom_google_map/model/place_details.dart'
    as _i32;
import 'package:swoony/common/custom_google_map/screen/custom_map_screen.dart'
    as _i7;
import 'package:swoony/common/event/screens/all_event_screen.dart' as _i1;
import 'package:swoony/common/event/screens/event_details_screen.dart' as _i9;
import 'package:swoony/common/home/screens/home_screen.dart' as _i13;
import 'package:swoony/common/notifications/screen/notifications_screen.dart'
    as _i15;
import 'package:swoony/common/onboarding_screen/onboarding_screen.dart' as _i16;
import 'package:swoony/common/payment/screen/payment_webview.dart' as _i18;
import 'package:swoony/common/setting/cubit/faq_cubit.dart' as _i33;
import 'package:swoony/common/setting/screens/contact_us_screen.dart' as _i5;
import 'package:swoony/common/setting/screens/email_preference_screen.dart'
    as _i8;
import 'package:swoony/common/setting/screens/event_notification_enable_screen.dart'
    as _i10;
import 'package:swoony/common/setting/screens/faq_screen.dart' as _i11;
import 'package:swoony/common/setting/screens/location_screen.dart' as _i14;
import 'package:swoony/common/setting/screens/privacy_policy_screen.dart'
    as _i19;
import 'package:swoony/common/setting/screens/setting_screen.dart' as _i21;
import 'package:swoony/common/setting/screens/terms_condition_screen.dart'
    as _i26;
import 'package:swoony/common/show_info/cubit/info_state.dart' as _i35;
import 'package:swoony/common/show_info/screen/show_info_screen.dart' as _i22;
import 'package:swoony/common/splash/splash_screen.dart' as _i25;
import 'package:swoony/common/tickets/model/ticket_model.dart' as _i30;
import 'package:swoony/common/tickets/screens/tickets_screen.dart' as _i27;
import 'package:swoony/core/app_bar/common_app_bar.dart' as _i36;
import 'package:swoony/organizer/createTicket/screens/create_event_screen.dart'
    as _i6;

/// generated route for
/// [_i1.AllEventScreen]
class AllEventRoute extends _i28.PageRouteInfo<AllEventRouteArgs> {
  AllEventRoute({
    _i29.Key? key,
    required String title,
    _i30.TicketFilter? ticketFilter,
    dynamic Function(String, String)? onTap,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         AllEventRoute.name,
         args: AllEventRouteArgs(
           key: key,
           title: title,
           ticketFilter: ticketFilter,
           onTap: onTap,
         ),
         initialChildren: children,
       );

  static const String name = 'AllEventRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllEventRouteArgs>();
      return _i1.AllEventScreen(
        key: args.key,
        title: args.title,
        ticketFilter: args.ticketFilter,
        onTap: args.onTap,
      );
    },
  );
}

class AllEventRouteArgs {
  const AllEventRouteArgs({
    this.key,
    required this.title,
    this.ticketFilter,
    this.onTap,
  });

  final _i29.Key? key;

  final String title;

  final _i30.TicketFilter? ticketFilter;

  final dynamic Function(String, String)? onTap;

  @override
  String toString() {
    return 'AllEventRouteArgs{key: $key, title: $title, ticketFilter: $ticketFilter, onTap: $onTap}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AllEventRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        ticketFilter == other.ticketFilter;
  }

  @override
  int get hashCode => key.hashCode ^ title.hashCode ^ ticketFilter.hashCode;
}

/// generated route for
/// [_i2.ChangePasswordScreen]
class ChangePasswordRoute extends _i28.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i28.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i3.ChatListScreen]
class ChatListRoute extends _i28.PageRouteInfo<void> {
  const ChatListRoute({List<_i28.PageRouteInfo>? children})
    : super(ChatListRoute.name, initialChildren: children);

  static const String name = 'ChatListRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChatListScreen();
    },
  );
}

/// generated route for
/// [_i4.ChatScreen]
class ChatRoute extends _i28.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required _i31.ChatListItemModel chatListItemModel,
    _i29.Key? key,
    _i29.Widget? action,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         ChatRoute.name,
         args: ChatRouteArgs(
           chatListItemModel: chatListItemModel,
           key: key,
           action: action,
         ),
         initialChildren: children,
       );

  static const String name = 'ChatRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return _i4.ChatScreen(
        chatListItemModel: args.chatListItemModel,
        key: args.key,
        action: args.action,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({required this.chatListItemModel, this.key, this.action});

  final _i31.ChatListItemModel chatListItemModel;

  final _i29.Key? key;

  final _i29.Widget? action;

  @override
  String toString() {
    return 'ChatRouteArgs{chatListItemModel: $chatListItemModel, key: $key, action: $action}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return chatListItemModel == other.chatListItemModel &&
        key == other.key &&
        action == other.action;
  }

  @override
  int get hashCode =>
      chatListItemModel.hashCode ^ key.hashCode ^ action.hashCode;
}

/// generated route for
/// [_i5.ContactUsScreen]
class ContactUsRoute extends _i28.PageRouteInfo<void> {
  const ContactUsRoute({List<_i28.PageRouteInfo>? children})
    : super(ContactUsRoute.name, initialChildren: children);

  static const String name = 'ContactUsRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i5.ContactUsScreen();
    },
  );
}

/// generated route for
/// [_i6.CreateEventScreen]
class CreateEventRoute extends _i28.PageRouteInfo<CreateEventRouteArgs> {
  CreateEventRoute({
    _i29.Key? key,
    String? draftId,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         CreateEventRoute.name,
         args: CreateEventRouteArgs(key: key, draftId: draftId),
         initialChildren: children,
       );

  static const String name = 'CreateEventRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEventRouteArgs>(
        orElse: () => const CreateEventRouteArgs(),
      );
      return _i6.CreateEventScreen(key: args.key, draftId: args.draftId);
    },
  );
}

class CreateEventRouteArgs {
  const CreateEventRouteArgs({this.key, this.draftId});

  final _i29.Key? key;

  final String? draftId;

  @override
  String toString() {
    return 'CreateEventRouteArgs{key: $key, draftId: $draftId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateEventRouteArgs) return false;
    return key == other.key && draftId == other.draftId;
  }

  @override
  int get hashCode => key.hashCode ^ draftId.hashCode;
}

/// generated route for
/// [_i7.CustomMapScreen]
class CustomMapRoute extends _i28.PageRouteInfo<CustomMapRouteArgs> {
  CustomMapRoute({
    _i29.Key? key,
    void Function(_i32.PlaceDetails)? onPositionChange,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         CustomMapRoute.name,
         args: CustomMapRouteArgs(key: key, onPositionChange: onPositionChange),
         initialChildren: children,
       );

  static const String name = 'CustomMapRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomMapRouteArgs>(
        orElse: () => const CustomMapRouteArgs(),
      );
      return _i7.CustomMapScreen(
        key: args.key,
        onPositionChange: args.onPositionChange,
      );
    },
  );
}

class CustomMapRouteArgs {
  const CustomMapRouteArgs({this.key, this.onPositionChange});

  final _i29.Key? key;

  final void Function(_i32.PlaceDetails)? onPositionChange;

  @override
  String toString() {
    return 'CustomMapRouteArgs{key: $key, onPositionChange: $onPositionChange}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomMapRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i8.EmailPreferenceScreen]
class EmailPreferenceRoute extends _i28.PageRouteInfo<void> {
  const EmailPreferenceRoute({List<_i28.PageRouteInfo>? children})
    : super(EmailPreferenceRoute.name, initialChildren: children);

  static const String name = 'EmailPreferenceRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i8.EmailPreferenceScreen();
    },
  );
}

/// generated route for
/// [_i9.EventDetailsScreen]
class EventDetailsRoute extends _i28.PageRouteInfo<EventDetailsRouteArgs> {
  EventDetailsRoute({
    required String eventId,
    _i29.Key? key,
    bool showEventActions = true,
    bool isEventAvailable = true,
    bool isEventUnderReview = false,
    String? details,
    String? image,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         EventDetailsRoute.name,
         args: EventDetailsRouteArgs(
           eventId: eventId,
           key: key,
           showEventActions: showEventActions,
           isEventAvailable: isEventAvailable,
           isEventUnderReview: isEventUnderReview,
           details: details,
           image: image,
         ),
         initialChildren: children,
       );

  static const String name = 'EventDetailsRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventDetailsRouteArgs>();
      return _i9.EventDetailsScreen(
        eventId: args.eventId,
        key: args.key,
        showEventActions: args.showEventActions,
        isEventAvailable: args.isEventAvailable,
        isEventUnderReview: args.isEventUnderReview,
        details: args.details,
        image: args.image,
      );
    },
  );
}

class EventDetailsRouteArgs {
  const EventDetailsRouteArgs({
    required this.eventId,
    this.key,
    this.showEventActions = true,
    this.isEventAvailable = true,
    this.isEventUnderReview = false,
    this.details,
    this.image,
  });

  final String eventId;

  final _i29.Key? key;

  final bool showEventActions;

  final bool isEventAvailable;

  final bool isEventUnderReview;

  final String? details;

  final String? image;

  @override
  String toString() {
    return 'EventDetailsRouteArgs{eventId: $eventId, key: $key, showEventActions: $showEventActions, isEventAvailable: $isEventAvailable, isEventUnderReview: $isEventUnderReview, details: $details, image: $image}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventDetailsRouteArgs) return false;
    return eventId == other.eventId &&
        key == other.key &&
        showEventActions == other.showEventActions &&
        isEventAvailable == other.isEventAvailable &&
        isEventUnderReview == other.isEventUnderReview &&
        details == other.details &&
        image == other.image;
  }

  @override
  int get hashCode =>
      eventId.hashCode ^
      key.hashCode ^
      showEventActions.hashCode ^
      isEventAvailable.hashCode ^
      isEventUnderReview.hashCode ^
      details.hashCode ^
      image.hashCode;
}

/// generated route for
/// [_i10.EventNotificationEnableScreen]
class EventNotificationEnableRoute
    extends _i28.PageRouteInfo<EventNotificationEnableRouteArgs> {
  EventNotificationEnableRoute({
    required String id,
    required String title,
    _i29.Key? key,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         EventNotificationEnableRoute.name,
         args: EventNotificationEnableRouteArgs(id: id, title: title, key: key),
         initialChildren: children,
       );

  static const String name = 'EventNotificationEnableRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventNotificationEnableRouteArgs>();
      return _i10.EventNotificationEnableScreen(
        id: args.id,
        title: args.title,
        key: args.key,
      );
    },
  );
}

class EventNotificationEnableRouteArgs {
  const EventNotificationEnableRouteArgs({
    required this.id,
    required this.title,
    this.key,
  });

  final String id;

  final String title;

  final _i29.Key? key;

  @override
  String toString() {
    return 'EventNotificationEnableRouteArgs{id: $id, title: $title, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventNotificationEnableRouteArgs) return false;
    return id == other.id && title == other.title && key == other.key;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i11.FaqScreen]
class FaqRoute extends _i28.PageRouteInfo<FaqRouteArgs> {
  FaqRoute({
    required _i33.FaqType faqType,
    _i29.Key? key,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         FaqRoute.name,
         args: FaqRouteArgs(faqType: faqType, key: key),
         initialChildren: children,
       );

  static const String name = 'FaqRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FaqRouteArgs>();
      return _i11.FaqScreen(faqType: args.faqType, key: args.key);
    },
  );
}

class FaqRouteArgs {
  const FaqRouteArgs({required this.faqType, this.key});

  final _i33.FaqType faqType;

  final _i29.Key? key;

  @override
  String toString() {
    return 'FaqRouteArgs{faqType: $faqType, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FaqRouteArgs) return false;
    return faqType == other.faqType && key == other.key;
  }

  @override
  int get hashCode => faqType.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i12.ForgetPasswordScreen]
class ForgetPasswordRoute extends _i28.PageRouteInfo<ForgetPasswordRouteArgs> {
  ForgetPasswordRoute({
    required _i29.TextEditingController newPasswordController,
    required String verificationToken,
    _i29.Key? key,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         ForgetPasswordRoute.name,
         args: ForgetPasswordRouteArgs(
           newPasswordController: newPasswordController,
           verificationToken: verificationToken,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ForgetPasswordRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgetPasswordRouteArgs>();
      return _i12.ForgetPasswordScreen(
        newPasswordController: args.newPasswordController,
        verificationToken: args.verificationToken,
        key: args.key,
      );
    },
  );
}

class ForgetPasswordRouteArgs {
  const ForgetPasswordRouteArgs({
    required this.newPasswordController,
    required this.verificationToken,
    this.key,
  });

  final _i29.TextEditingController newPasswordController;

  final String verificationToken;

  final _i29.Key? key;

  @override
  String toString() {
    return 'ForgetPasswordRouteArgs{newPasswordController: $newPasswordController, verificationToken: $verificationToken, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ForgetPasswordRouteArgs) return false;
    return newPasswordController == other.newPasswordController &&
        verificationToken == other.verificationToken &&
        key == other.key;
  }

  @override
  int get hashCode =>
      newPasswordController.hashCode ^
      verificationToken.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i13.HomeScreen]
class HomeRoute extends _i28.PageRouteInfo<void> {
  const HomeRoute({List<_i28.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i13.HomeScreen();
    },
  );
}

/// generated route for
/// [_i14.LocationScreen]
class LocationRoute extends _i28.PageRouteInfo<void> {
  const LocationRoute({List<_i28.PageRouteInfo>? children})
    : super(LocationRoute.name, initialChildren: children);

  static const String name = 'LocationRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i14.LocationScreen();
    },
  );
}

/// generated route for
/// [_i15.NotificationScreen]
class NotificationRoute extends _i28.PageRouteInfo<void> {
  const NotificationRoute({List<_i28.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i15.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i16.OnboardingScreen]
class OnboardingRoute extends _i28.PageRouteInfo<void> {
  const OnboardingRoute({List<_i28.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i16.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i17.OtpScreen]
class OtpRoute extends _i28.PageRouteInfo<void> {
  const OtpRoute({List<_i28.PageRouteInfo>? children})
    : super(OtpRoute.name, initialChildren: children);

  static const String name = 'OtpRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i17.OtpScreen();
    },
  );
}

/// generated route for
/// [_i18.PaymentWebView]
class PaymentWebView extends _i28.PageRouteInfo<PaymentWebViewArgs> {
  PaymentWebView({
    required String checkoutUrl,
    required Function onCancel,
    required Function onSuccess,
    _i34.Key? key,
    void Function(String)? onFailed,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         PaymentWebView.name,
         args: PaymentWebViewArgs(
           checkoutUrl: checkoutUrl,
           onCancel: onCancel,
           onSuccess: onSuccess,
           key: key,
           onFailed: onFailed,
         ),
         initialChildren: children,
       );

  static const String name = 'PaymentWebView';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentWebViewArgs>();
      return _i18.PaymentWebView(
        checkoutUrl: args.checkoutUrl,
        onCancel: args.onCancel,
        onSuccess: args.onSuccess,
        key: args.key,
        onFailed: args.onFailed,
      );
    },
  );
}

class PaymentWebViewArgs {
  const PaymentWebViewArgs({
    required this.checkoutUrl,
    required this.onCancel,
    required this.onSuccess,
    this.key,
    this.onFailed,
  });

  final String checkoutUrl;

  final Function onCancel;

  final Function onSuccess;

  final _i34.Key? key;

  final void Function(String)? onFailed;

  @override
  String toString() {
    return 'PaymentWebViewArgs{checkoutUrl: $checkoutUrl, onCancel: $onCancel, onSuccess: $onSuccess, key: $key, onFailed: $onFailed}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentWebViewArgs) return false;
    return checkoutUrl == other.checkoutUrl &&
        onCancel == other.onCancel &&
        onSuccess == other.onSuccess &&
        key == other.key;
  }

  @override
  int get hashCode =>
      checkoutUrl.hashCode ^
      onCancel.hashCode ^
      onSuccess.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i19.PrivacyPolicyScreen]
class PrivacyPolicyRoute extends _i28.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i28.PageRouteInfo>? children})
    : super(PrivacyPolicyRoute.name, initialChildren: children);

  static const String name = 'PrivacyPolicyRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i19.PrivacyPolicyScreen();
    },
  );
}

/// generated route for
/// [_i20.ProfileInfoScreen]
class ProfileInfoRoute extends _i28.PageRouteInfo<void> {
  const ProfileInfoRoute({List<_i28.PageRouteInfo>? children})
    : super(ProfileInfoRoute.name, initialChildren: children);

  static const String name = 'ProfileInfoRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i20.ProfileInfoScreen();
    },
  );
}

/// generated route for
/// [_i21.SettingScreen]
class SettingRoute extends _i28.PageRouteInfo<SettingRouteArgs> {
  SettingRoute({
    _i29.Key? key,
    bool showBackButton = false,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         SettingRoute.name,
         args: SettingRouteArgs(key: key, showBackButton: showBackButton),
         initialChildren: children,
       );

  static const String name = 'SettingRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SettingRouteArgs>(
        orElse: () => const SettingRouteArgs(),
      );
      return _i21.SettingScreen(
        key: args.key,
        showBackButton: args.showBackButton,
      );
    },
  );
}

class SettingRouteArgs {
  const SettingRouteArgs({this.key, this.showBackButton = false});

  final _i29.Key? key;

  final bool showBackButton;

  @override
  String toString() {
    return 'SettingRouteArgs{key: $key, showBackButton: $showBackButton}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SettingRouteArgs) return false;
    return key == other.key && showBackButton == other.showBackButton;
  }

  @override
  int get hashCode => key.hashCode ^ showBackButton.hashCode;
}

/// generated route for
/// [_i22.ShowInfoScreen]
class ShowInfoRoute extends _i28.PageRouteInfo<ShowInfoRouteArgs> {
  ShowInfoRoute({
    _i29.Key? key,
    required String title,
    required _i35.InfoType infoType,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         ShowInfoRoute.name,
         args: ShowInfoRouteArgs(key: key, title: title, infoType: infoType),
         initialChildren: children,
       );

  static const String name = 'ShowInfoRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowInfoRouteArgs>();
      return _i22.ShowInfoScreen(
        key: args.key,
        title: args.title,
        infoType: args.infoType,
      );
    },
  );
}

class ShowInfoRouteArgs {
  const ShowInfoRouteArgs({
    this.key,
    required this.title,
    required this.infoType,
  });

  final _i29.Key? key;

  final String title;

  final _i35.InfoType infoType;

  @override
  String toString() {
    return 'ShowInfoRouteArgs{key: $key, title: $title, infoType: $infoType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShowInfoRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        infoType == other.infoType;
  }

  @override
  int get hashCode => key.hashCode ^ title.hashCode ^ infoType.hashCode;
}

/// generated route for
/// [_i23.SignInScreen]
class SignInRoute extends _i28.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    required _i29.TextEditingController ctrUsername,
    required _i29.TextEditingController ctrPassword,
    _i29.Key? key,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         SignInRoute.name,
         args: SignInRouteArgs(
           ctrUsername: ctrUsername,
           ctrPassword: ctrPassword,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'SignInRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>();
      return _i23.SignInScreen(
        ctrUsername: args.ctrUsername,
        ctrPassword: args.ctrPassword,
        key: args.key,
      );
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({
    required this.ctrUsername,
    required this.ctrPassword,
    this.key,
  });

  final _i29.TextEditingController ctrUsername;

  final _i29.TextEditingController ctrPassword;

  final _i29.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{ctrUsername: $ctrUsername, ctrPassword: $ctrPassword, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignInRouteArgs) return false;
    return ctrUsername == other.ctrUsername &&
        ctrPassword == other.ctrPassword &&
        key == other.key;
  }

  @override
  int get hashCode =>
      ctrUsername.hashCode ^ ctrPassword.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i24.SignUpScreen]
class SignUpRoute extends _i28.PageRouteInfo<void> {
  const SignUpRoute({List<_i28.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i24.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i25.SplashScreen]
class SplashRoute extends _i28.PageRouteInfo<void> {
  const SplashRoute({List<_i28.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i25.SplashScreen();
    },
  );
}

/// generated route for
/// [_i26.TermsConditionScreen]
class TermsConditionRoute extends _i28.PageRouteInfo<void> {
  const TermsConditionRoute({List<_i28.PageRouteInfo>? children})
    : super(TermsConditionRoute.name, initialChildren: children);

  static const String name = 'TermsConditionRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      return const _i26.TermsConditionScreen();
    },
  );
}

/// generated route for
/// [_i27.TicketsScreen]
class TicketsRoute extends _i28.PageRouteInfo<TicketsRouteArgs> {
  TicketsRoute({
    _i29.Key? key,
    required dynamic Function(_i30.TicketModel, _i30.TicketFilter) onTap,
    required List<_i30.TicketFilter> filters,
    String? subTitle,
    String? title,
    double? titleSize,
    _i36.CommonAppBar? appBar,
    List<_i28.PageRouteInfo>? children,
  }) : super(
         TicketsRoute.name,
         args: TicketsRouteArgs(
           key: key,
           onTap: onTap,
           filters: filters,
           subTitle: subTitle,
           title: title,
           titleSize: titleSize,
           appBar: appBar,
         ),
         initialChildren: children,
       );

  static const String name = 'TicketsRoute';

  static _i28.PageInfo page = _i28.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TicketsRouteArgs>();
      return _i27.TicketsScreen(
        key: args.key,
        onTap: args.onTap,
        filters: args.filters,
        subTitle: args.subTitle,
        title: args.title,
        titleSize: args.titleSize,
        appBar: args.appBar,
      );
    },
  );
}

class TicketsRouteArgs {
  const TicketsRouteArgs({
    this.key,
    required this.onTap,
    required this.filters,
    this.subTitle,
    this.title,
    this.titleSize,
    this.appBar,
  });

  final _i29.Key? key;

  final dynamic Function(_i30.TicketModel, _i30.TicketFilter) onTap;

  final List<_i30.TicketFilter> filters;

  final String? subTitle;

  final String? title;

  final double? titleSize;

  final _i36.CommonAppBar? appBar;

  @override
  String toString() {
    return 'TicketsRouteArgs{key: $key, onTap: $onTap, filters: $filters, subTitle: $subTitle, title: $title, titleSize: $titleSize, appBar: $appBar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TicketsRouteArgs) return false;
    return key == other.key &&
        const _i37.ListEquality<_i30.TicketFilter>().equals(
          filters,
          other.filters,
        ) &&
        subTitle == other.subTitle &&
        title == other.title &&
        titleSize == other.titleSize &&
        appBar == other.appBar;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i37.ListEquality<_i30.TicketFilter>().hash(filters) ^
      subTitle.hashCode ^
      title.hashCode ^
      titleSize.hashCode ^
      appBar.hashCode;
}

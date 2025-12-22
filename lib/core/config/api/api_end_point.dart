class ApiEndPoint {
  ApiEndPoint._();
  static final ApiEndPoint instance = ApiEndPoint._();

  // final String domain = 'http://10.10.7.102:4000';
  // final String baseUrl = 'http://10.10.7.102:4000/api/v1';
  // final String soketUrl = 'http://10.10.7.102:4000/api/v1';

  final String domain = 'https://ismail4000.binarybards.online';
  final String baseUrl = 'https://ismail4000.binarybards.online/api/v1';
  final String soketUrl = 'https://ismail4000.binarybards.online/api/v1';

  //auth
  final String refreshToken = '/auth/refresh-token';
  final String signUp = '/user/create';
  final String signIn = '/auth/login';
  final String verifyEmail = '/auth/verify-email';
  final String forgetPassword = '/auth/forget-password';
  final String changePassword = '/auth/change-password';
  final String resetPassword = '/auth/reset-password';
  final String resendOtp = '/auth/resend-otp';
  final String signOut = '/auth/sign-out';

  //user
  final String profile = '/user/profile';
  final String deleteAccount = '/user/remove-account';

  //basic
  final String privacyPolicy = '/settings/privacy_policy';
  final String termsAndConditions = '/settings/terms_and_conditions';
  final String about_us = '/settings/about_us';
  final String contact_us = '/settings/contact';
  final String faqUser = '/settings/faq/user';
  final String faqVenue = '/settings/faq/vanue';
  final String notification = '/notification';
  final String unreadCount = '/notification/unread-count';

  //event
  final String createEvent = '/event';
  String updateEvent(String id) => '/event/$id';

  //category + subcategory
  final String category = '/event/allCategory';
  final String categoryWithSubCategory = '/event/allCategory?includeSelectedSubcategory';
  String subCategory(String id) => '/event/Subcategory?categoryId=$id';

  //event
  final String orgEvent = '/event'; //only self event
  final String orgEventClosed = '/event/closed';
  String eventDetails({required String id}) => '/event/$id';

  //organization
  String orgLiveEventDetails({required String id}) => '/event/event-ticket-history/$id';

  //user
  final String userLiveEvent = '/ticket/unique-event';
  final String userExpiredEvent = '/ticket/expired-ticket';
  final String userSoldEvent = '/ticket/sold-event';
  final String userFavourite = '/favourite';
  final String userNewlyAdded = '/event/all-live-event';
  final String userPopularEvent = '/event/popular-event';

  //user ticket history
  String userLiveDetails({required String id}) => '/ticket/sellHistory/$id?status=onsell';
  String userAvailableDetails({required String id}) => '/ticket/sellHistory/$id?status=available';
  String userOnSellTicket({required String id}) => '/ticket/resellTicket/$id';
  String withdrawTickets({required String id}) => '/ticket/withdraw-pro/$id';
  String ticketHistoryDetails({required String id, required bool isExpired}) =>
      '/ticket/sold-view-history/$id${isExpired ? '?expired=$isExpired' : ''}';

  //user purchase tickets
  String getAvailableTicketFromOrg({required String id}) =>
      '/ticket/event-summary?sellerType=organizer&eventId=$id';

  String getAvailableTicketFromUser({required String id}) =>
      '/ticket/sell-history-onsell/$id?status=onsell';

  String checkPromoCode(String id) => '/ticket/promocode/$id';

  String purchaseFromOrganizer({required String id}) => '/event/payment/$id';
  String purchaseFromUser({required String id}) => '/ticket/ticketPurchase/$id';
  String attendeeTicketAvailability(String id) => '/ticket/available-type-history/$id';

  //venue
  String perticipentCount(String code) => '/event/perticipent-count/$code';
  String tikcetUse({required String eventId, required String ownerId, required bool isUpdate}) =>
      '/event/bar-code-check/$eventId?ownerId=$ownerId&isUpdate=$isUpdate';
  String checkEventCode(String eventCode) => '/ticket/check-event/$eventCode';

  //chat
  String chat = '/chat';
  String getMessages({required String chatId}) => '/message/$chatId';
  String sentMessage = '/message';
  String deleteMessage({required String messageId}) => '/message/delete-message/$messageId';
  String editMessage({required String messageId}) => '/message/update-message/$messageId';
  String reportChat({required String chatId}) => '/chat/report/$chatId';

  //stripe
  String stripeLoginLink = '/stripe-account/connected-user/login-link';
  String stripeConnectAccount = '/stripe-account/create-connected-account';
}

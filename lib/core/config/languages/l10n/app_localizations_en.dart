// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Swoony';

  @override
  String get requiredField => 'This field is required';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get invalidPhone => 'Please enter a valid phone number';

  @override
  String get invalidPassword =>
      'Password must be at least 8 characters long, contain an uppercase letter, and a digit';

  @override
  String get invalidDate => 'Please enter a valid date (YYYY-MM-DD)';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get invalidURL => 'Please enter a valid URL';

  @override
  String get invalidNumber => 'Please enter a valid number';

  @override
  String get invalidCreditCard =>
      'Please enter a valid credit card number (16 digits)';

  @override
  String get invalidPostalCode => 'Please enter a valid postal code';

  @override
  String minLengthError(Object minLength) {
    return 'Input must be at least $minLength characters';
  }

  @override
  String maxLengthError(Object maxLength) {
    return 'Input must be no more than $maxLength characters';
  }

  @override
  String get invalidPattern => 'Input does not match the required pattern';

  @override
  String invalidDateRange(Object endDate, Object startDate) {
    return 'Date must be between $startDate and $endDate';
  }

  @override
  String otpEntrySubtitle(Object username) {
    return 'Otp has been sent to $username';
  }

  @override
  String get alphaNumericError => 'Only alphanumeric characters are allowed';

  @override
  String get usernameError =>
      'Username must be between 3 to 15 characters and can only contain letters, numbers, and underscores';

  @override
  String get invalidTime => 'Please enter a valid time in HH:mm format';

  @override
  String get invalidOTP => 'Please enter a valid 6-digit OTP';

  @override
  String get invalidCurrency => 'Please enter a valid amount (e.g., 1234.56)';

  @override
  String get invalidIP => 'Please enter a valid IPv4 address';

  @override
  String get allDataLoaded => 'All data loaded';

  @override
  String get nidRequired => 'National ID is required.';

  @override
  String get nidInvalid => 'Please enter a valid National ID (12 digits).';

  @override
  String get fullNameRequired => 'Full name is required.';

  @override
  String get fullNameInvalid =>
      'Please enter a valid full name (e.g., John Doe, O\'Connor, Mary-Jane).';

  @override
  String get seconds => 'Seconds';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get resendCodeIn => 'Resend in';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm New Password';

  @override
  String get save => 'Save';

  @override
  String get enterVerifyCode => 'Verify Code';

  @override
  String get otpTitleSignup => 'OTP Verification';

  @override
  String get profileInfo => 'Profile Info';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changePassword => 'Change Password';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get password => 'Password';

  @override
  String get forgotThePassword => 'Forgot Password?';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get fullName => 'Full Name';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get doNotHaveAccount => 'Don’t have an account?';

  @override
  String get accountDeleteMessage =>
      'Please note that once you delete your account, you will not be able to recover it. Kindly let us know why you want to delete your account.';

  @override
  String get otpSendButton => 'Send Code';

  @override
  String get didntReciveCode => 'Didn\'t receive code?';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get deleteUser => 'Delete User';

  @override
  String get blockUser => 'Block User';

  @override
  String get verify => 'Verify';

  @override
  String get message => 'Message';

  @override
  String get notifications => 'Notifications';

  @override
  String get privacyNotice => 'Privacy Notice';

  @override
  String get termsOfuse => 'Term of Use';

  @override
  String get account => 'Account';

  @override
  String get codeHasBeenSentTo => 'A Code has been sent to your Email Address';

  @override
  String get yes => 'Yes';

  @override
  String get noDetailsAvailableForThisNotification =>
      'No details available for this notification';

  @override
  String get no => 'No';

  @override
  String get send => 'Send';

  @override
  String get writeYourMessageHere => 'Write your message here';

  @override
  String get areYouSureYouWantToDeleteYourAccount =>
      'Are you sure you want to delete your account?';

  @override
  String get oldPassword => 'Old Password';

  @override
  String get myBalance => 'My Balance';

  @override
  String get withdraw => 'Withdraw';

  @override
  String
  get forTheBestSupportExperiencePleaseDescribeYourIssueClearlyInASingleDetailedMessageOurTeamWillReviewItAndGetInTouchWithYouViaEmail =>
      'For the best support experience, please describe your issue clearly in a single, detailed message. Our team will review it and get in touch with you via email.';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get buySellKeepFavoriteTickets =>
      'Buy, Sell, and Keep your Favorite Tickets';

  @override
  String get copyright => '©2025 Essence Software. All rights reserved.';

  @override
  String get letsSignYouIn => 'Let’s sign you in';

  @override
  String get welcomeBack => 'Welcome back.';

  @override
  String get youHaveBeenMissed => 'You have been missed!';

  @override
  String get pleaseSelectARoleBeforeContinuing =>
      'Please select a role before continuing';

  @override
  String get attendee => 'Attendee';

  @override
  String get organizer => 'Organizer';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get state => 'State';

  @override
  String get city => 'City';

  @override
  String get confim => 'Confirm';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get selectYourPreference => 'Select Your Preference';

  @override
  String get eventsWillBeShownBasedOnYourPreferences =>
      'Events will be shown based on your preferences';

  @override
  String get newlyAddedEvents => 'Newly Added Events';

  @override
  String get seeMore => 'See more';

  @override
  String get morePlus => 'More+';

  @override
  String get popularEvents => 'Popular Events';

  @override
  String get categories => 'Categories';

  @override
  String get searchEventsHere => 'Search events here';

  @override
  String get searchMessageHere => 'Search Message here';

  @override
  String get messages => 'Messages';

  @override
  String get report => 'Report';

  @override
  String get privacyConcerns => 'Privacy concerns';

  @override
  String get eroticContent => 'Erotic content';

  @override
  String get copyrightViolations => 'Copyright violations';

  @override
  String get defamation => 'Defamation';

  @override
  String get obscene => 'Obscene';

  @override
  String get others => 'Others';

  @override
  String get submit => 'Submit';

  @override
  String get selectReasons => 'Select Reasons';

  @override
  String get otherDetails => 'Other/ Details';

  @override
  String get typeYourMessage => 'Type your message';

  @override
  String maximumFileSelection(Object count) {
    return 'Maximum $count files/Images can be selected';
  }

  @override
  String get moreMinus => 'More-';

  @override
  String get getOrganizerTicket => 'Get Organizer Ticket';

  @override
  String get viewAttendeeTickets => 'View Attendee Tickets';

  @override
  String get messageOrganizer => 'Message Organizer';

  @override
  String get attendeeInformation => 'Attendee Information';

  @override
  String get tickets => 'Tickets';

  @override
  String get price => 'Price';

  @override
  String get quantity => 'Quantity';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get summary => 'Summary';

  @override
  String get apply => 'Apply';

  @override
  String get cancel => 'Cancel';

  @override
  String get next => 'Next';

  @override
  String get mainlandFee => 'Mainland Fee';

  @override
  String get discount => 'Discount';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get promoCode => 'Promo code';

  @override
  String get availableTickets => 'Available Tickets';

  @override
  String get availableunits => 'Available Units(s)';

  @override
  String get soldOut => 'Sold Out';

  @override
  String get fanClub => 'Fan Club';

  @override
  String get showingYourFavoriteEvent => 'Showing your favorite event';

  @override
  String get chooseYourFavorites => 'Choose your favorites';

  @override
  String get favorites => 'Favorites';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get confirmDeleteMessage =>
      'Are you sure you want to delete this favorite?';

  @override
  String get confirm => 'Confirm';

  @override
  String get viewPlus => 'View+';

  @override
  String get liveAvailableForSaleSoldAndExpired =>
      'Live, Available for Sale, Sold, and Expired';

  @override
  String get allAvailableTickets => 'All Available Tickets';

  @override
  String get liveUnderReviewDraftAndClosedTickets =>
      'Live, Under Review, Draft and Closed Tickets';

  @override
  String get yourEventIsUnderReview =>
      'Your Event is under review. We’ll reach out if we need more details and notify you once it’s approved to go live on Mainland';

  @override
  String get aNewTicketEvent => 'A new Event Ticket';

  @override
  String get create => 'Create';

  @override
  String get venue => 'Venue';

  @override
  String get upcomingEvents => 'Upcoming Events';

  @override
  String get ticketDetails => 'Ticket Details';

  @override
  String get withdrawTicket => 'Withdraw Ticket';

  @override
  String get sellTicket => 'Sell Ticket';

  @override
  String get viewDetails => 'View Details';

  @override
  String get sellNow => 'Sell Now';

  @override
  String get viewLess => 'View Less';

  @override
  String get withdrawnTicketsMustBeRelistedToSellAgain =>
      'Withdrawn Tickets must be relisted to sell again';

  @override
  String get confirmWithdraw => 'Confirm Withdraw';

  @override
  String get purchasedPrice => 'Purchased Price';

  @override
  String get totalSoldPrice => 'Total Sold Price';

  @override
  String get yourPayout => 'Your Payout';

  @override
  String get logOut => 'Log Out';

  @override
  String get validate => 'Validate';

  @override
  String get insertEventCode => 'Insert Event Code';

  @override
  String get history => 'History';

  @override
  String get scanner => 'Scanner';

  @override
  String get settings => 'Settings';

  @override
  String get browseDevice => 'Browse Device';

  @override
  String get insertNewEventCode => 'Insert New Event Code';

  @override
  String get eventCode => 'Event Code';

  @override
  String get faqHelp => 'FAQ/Help';

  @override
  String get about => 'About';

  @override
  String get vibrate => 'Vibrate';

  @override
  String get sound => 'Sound';

  @override
  String get myAccount => 'My Account';

  @override
  String get aboutUs => 'About Us';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get linkYourBankAccount => 'Link your (Bank) Account';

  @override
  String get emailPreferences => 'Email Preferences';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get locations => 'Location';

  @override
  String get sendNotificationAboutAnEvent => 'Send Notification About an Event';

  @override
  String get uploadImage => 'Upload Image';

  @override
  String get removeImage => 'Remove Image';

  @override
  String get receiveEmailNotificationsFor => 'Receive email notifications for';

  @override
  String get whenYouSellYourTicket => 'When you Sell your Ticket';

  @override
  String get whenYouReceiveAMessage => 'When you receive a Message';

  @override
  String get whenAFavoritePublishAnEvent => 'When a Favorite publish an Event';

  @override
  String get whenYouCanWithdrawFromYourWallet =>
      'When you can Withdraw from your Wallet';

  @override
  String get enterYourReason => 'Enter your reason';

  @override
  String
  get whenYouWithdrawYourPayoutFromWalletPayoutsAreSentToYourLinkedAccount14DaysAfterTheEvent =>
      'When you Withdraw your Payout from Wallet, Payouts are sent to your linked account 14 days after the event. ';

  @override
  String
  mainlandCharges10CommissionOnAllSaleYourTicketWillBecomeAvailableUnderAttendeeTicketSaleIfSoldItWillBeInvalidatedAndReissuedToTheBuyer(
    Object mainlandFee,
  ) {
    return 'Mainland charges $mainlandFee% Commission on all sale. Your Ticket will become available under Attendee Ticket sale. If sold, it will be invalidated, and reissued to the Buyer';
  }
}

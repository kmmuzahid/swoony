import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:swoony/core/utils/log/app_log.dart';

import '../cubit/notification_cubit.dart';

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FirebaseNotificationHandler {
  static FirebaseNotificationHandler instance = FirebaseNotificationHandler();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationCubit? notificationCubit;

  void setNotificationCubit(NotificationCubit cubit) {
    notificationCubit = cubit;
  }

  /// Initialize FCM and notification handlers
  Future<void> init() async {
    // Request notification permissions for iOS
    await _firebaseMessaging.requestPermission();

    const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');
    const initSettings = InitializationSettings(android: androidInit);

    await _flutterLocalNotificationsPlugin.initialize(initSettings);

    // Set foreground message handler 
    // FirebaseMessaging.onMessage.listen(_onMessageReceived);

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Set when the app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification tap if needed
    });

    // Get the FCM token
    final String? token = await _firebaseMessaging.getToken();
    AppLogger.debug(
      'FCM Token: $token',
      tag: 'Firebase Handler',
    ); // You may want to save this token for later use
  }

  /// Foreground message handler (App is in foreground)
  // Future<void> _onMessageReceived(RemoteMessage message) async {
  //   // Parse the notification data and show it using local notifications
  //   if (message.notification != null) {
  //     // Insert the notification into Cubit state (if app is in foreground)
  //     // notificationCubit?.addNotification(notification: message);

  //     // Show the notification in the system tray using FlutterLocalNotifications
  //     _showLocalNotification(message.notification);
  //   }
  // }

  /// Background message handler (App is in background or terminated)
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    AppLogger.debug('Handling a background message: ${message.messageId}');
    FirebaseNotificationHandler.instance.showLocalNotification(message.notification);
    // You can perform tasks when the app is in the background or terminated
  }

  /// Show notification in the system tray using FlutterLocalNotifications
  Future<void> showLocalNotification(RemoteNotification? notification) async {
    if (notification == null) return;

    final androidDetails = const AndroidNotificationDetails(
      'your_channel_id', // Channel ID
      'your_channel_name', // Channel name
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    // Show the notification
    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      notification.title,
      notification.body,
      platformDetails,
      payload: 'item x', // Optional payload data you may want to pass
    );
  }
}

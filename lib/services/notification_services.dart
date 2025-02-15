// import 'dart:convert';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:qolbu/services/hive_service.dart';

// class NotificationServices extends GetxService {
//   static final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static bool isFlutterLocalNotificationsInitialized = false;
//   static Future<void> initialize() async {
//     if (isFlutterLocalNotificationsInitialized) {
//       return;
//     }
//     if (Platform.isIOS) {
//       await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     }
//     _configureLocalTimeZone();
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('ic_logo');

//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(onDidReceiveLocalNotification: (_, __, ___, ____) {});

//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'default_notification_channel_id',
//       'default_notification_channel_name',
//       description: 'default_notification_channel_desc',
//       importance: Importance.max,
//     );

//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//     );

//     await notificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     await notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
//       onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
//     );
//     isFlutterLocalNotificationsInitialized = true;

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       onMessageHandler(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       HiveService.initialize();
//     });

//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   }

//   static Future<void> onMessageHandler(RemoteMessage message) async {
//     notificationsPlugin.show(
//       DateTime.now().millisecond,
//       message.notification?.title ?? '',
//       message.notification?.body ?? '',
//       notificationDetails(),
//       payload: jsonEncode(message.data),
//     );
//   }

//   @pragma('vm:entry-point')
//   static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//     await initialize();
//     onMessageHandler(message);
//   }

//   static notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'Notification ID',
//         'Notification Config',
//         importance: Importance.max,
//         priority: Priority.max,
//         enableLights: true,
//         visibility: NotificationVisibility.public,
//       ),
//       iOS: DarwinNotificationDetails(threadIdentifier: 'thread_id'),
//     );
//   }

//   static Future<void> _configureLocalTimeZone() async {
//     // tz.initializeTimeZones();
//     // final String timeZone = await FlutterTimezone.getLocalTimezone();
//     // tz.setLocalLocation(tz.getLocation(timeZone));
//   }

//   static void _onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
//     "_onDidReceiveBackgroundNotificationResponse".printInfo(info: "NOTIFICATION");
//   }

//   static void _onDidReceiveNotificationResponse(NotificationResponse details) {
//     "_onDidReceiveNotificationResponse".printInfo(info: "NOTIFICATION");
//   }
// }

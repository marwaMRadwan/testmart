import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:martizoom/data_layer/models/firebase_notification_model.dart';
import 'package:martizoom/data_layer/services/flutter_local_notifications_service.dart';

import '../../shared/network/remote/firebase_helper.dart';

class FirebaseMessagingService {
  // Singleton pattern
  static final FirebaseMessagingService _notificationService =
      FirebaseMessagingService._internal();

  factory FirebaseMessagingService() {
    return _notificationService;
  }

  FirebaseMessagingService._internal();

  initNotifications() async {
    NotificationSettings settings =
        await FirebaseHelper.firebaseMsgInstance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      await FlutterLocalNotificationsService()
          .initFlutterLocalNotificationsPlugin();
      await FlutterLocalNotificationsService()
          .requestFlutterLocalNotificationsIOSPermissions();

      ///gives you the message on which user taps
      ///and opened the app from terminated state
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        print('getInitialMessage');
        print(message);
        if (message != null) {
          // final notification = FirebaseNotificationModel.fromJson(message.data);
          // navigateToScreen(notification, context);
        }
      }).catchError((error) {
        throw error;
      });

      ///foreground work
      FirebaseMessaging.onMessage.listen((message) async {
        if (message.data != null) {
          print(message.data['body']);
          print(message.data['title']);

          await FlutterLocalNotificationsService().showNotification(
            message.data['body'],
          );


        }
        print('onMessage');
        print(message.data);

      });

      /// when the app is in background and user taps
      /// on the notification
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print(message.notification!.body);
        print(message.notification!.title);
        print('onMessageOpenedApp');

      });

      /// receive message when app is background
      FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    } else {
      print('User declined or has not accepted permission');
    }
  }
}

/// receive message when app is background
Future<void> _backgroundHandler(RemoteMessage message) async {
  // print(message.data.toString());
  // print(message.notification!.title);
  print('backgroundHandler');


  await FlutterLocalNotificationsService().showNotification(
    message.data['body'],
  );
}

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:general_app/config/helpers/logging_helper.dart';
import 'package:general_app/screens/messages/controller/messages_binding.dart';
import 'package:general_app/screens/messages/messages_screen.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../../screens/messages/controller/messages_controller.dart';

class NotificationsService {
  static final _instance = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _instance.requestPermission(announcement: true);

    // /// This means that FCM will automatically initialize and
    // /// retrieve a device token when the app starts.
    // await _instance.setAutoInitEnabled(true);

    await _instance.getToken().then(
          (token) => AppLogger.log('FIREBASE TOKEN : : $token'),
        );

    /// ==========================Handle Background Notifications=======================================

    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      if (remoteMessage != null) {
        RemoteNotification? notification = remoteMessage.notification;
        AndroidNotification? android = remoteMessage.notification?.android;
        if (notification != null && android != null) {
          AppLogger.log(
            'Initial Notification : : ${remoteMessage.notification?.title}',
          );
          _handleRemoteMessage(remoteMessage);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          AppLogger.log('Background Notification Tapped.');
          _handleRemoteMessage(remoteMessage);
        }
      },
    );

    /// ==========================Handle Foreground Notifications=======================================
    await _initializeLocalNotifications();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        AppLogger.log('Got a Foreground Notification.');
        if (remoteMessage.notification != null) {
          _handleRemoteMessage(remoteMessage);
        }
      },
    );
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {
        // showSimpleNotification(
        //   title: title!,
        //   body: body!,
        //   payload: payload!,
        // );
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  String? _getImageUrl(RemoteNotification notification) {
    if (Platform.isIOS && notification.apple != null) {
      return notification.apple?.imageUrl;
    }
    if (Platform.isAndroid && notification.android != null) {
      return notification.android?.imageUrl;
    }
    return null;
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    ).get(url);
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }

  Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
    String? imageUrl,
  }) async {
    BigPictureStyleInformation? bigPictureStyleInformation;
    if (imageUrl != null) {
      String imagePath = await _downloadAndSaveFile(imageUrl, 'image');
      bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(imagePath),
        hideExpandedLargeIcon: true,
        contentTitle: 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: 'summary <i>text</i>',
        htmlFormatSummaryText: true,
      );
    }

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      visibility: NotificationVisibility.public,
      styleInformation: bigPictureStyleInformation,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(),
    );
    await _flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000),
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  void _handleRemoteMessage(RemoteMessage remoteMessage) async {
    String payload = jsonEncode(remoteMessage.data);

    if (remoteMessage.data['allow_notifications'] == '1') {
      String? imageUrl = _getImageUrl(remoteMessage.notification!);

      showSimpleNotification(
        title: remoteMessage.notification!.title!,
        body: remoteMessage.notification!.body!,
        payload: payload,
        imageUrl: imageUrl,
      );
    } else {
      // handle foreground notification data
      // update view or go to screen

      if (Get.isRegistered<MessagesController>()) {
        // MessagesController messagesController = Get.find<MessagesController>();
        // messagesController.addMessage(
        //   remoteMessage.notification!.title!,
        // );
      } else {
        Get.to(
          () => const MessagesScreen(),
          binding: MessagesBinding(),
        );
      }
    }
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    AppLogger.log('Foreground Notification Tapped.');
    if (notificationResponse.payload != null) {
      Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
      AppLogger.log(data.toString());

      /// just navigate to the screen and handle loading data their
      Get.to(() => const MessagesScreen(), binding: MessagesBinding());
    }
  }
}

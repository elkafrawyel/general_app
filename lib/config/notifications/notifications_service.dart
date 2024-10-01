import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:general_app/config/helpers/logging_helper.dart';
import 'package:path_provider/path_provider.dart';

class NotificationsService {
  static const String _channelId = 'com.general.app';
  static const String _channelName = 'GeneralApp';
  static const String _channelDescription = '';

  static final _instance = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await _instance.requestPermission(announcement: true);

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
          _handleBackgroundRemoteMessage(remoteMessage);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          AppLogger.log('Background Notification Tapped.');
          _handleBackgroundRemoteMessage(remoteMessage);
        }
      },
    );

    /// ==========================Handle Foreground Notifications=======================================
    await _initializeLocalNotifications();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        AppLogger.log('Got a Foreground Notification.');
        if (remoteMessage.notification != null) {
          _handleForegroundRemoteMessage(remoteMessage);
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
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
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
        contentTitle: '<b>$title</b>',
        htmlFormatContentTitle: true,
        summaryText: body,
        htmlFormatSummaryText: true,
      );
    }

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
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

  void _handleBackgroundRemoteMessage(RemoteMessage remoteMessage) async {
    String payload = jsonEncode(remoteMessage.data);

    AppLogger.log(payload);
  }

  void _handleForegroundRemoteMessage(RemoteMessage remoteMessage) async {
    String payload = jsonEncode(remoteMessage.data);

    // handle foreground notification data
    // update ui or go to screen

    // ? todo : chack if the user is opening the screen to just
    // ? update the ui or data

    // if (Get.isRegistered<NotificationsController>()) {
    // Get.find<NotificationsController>().refreshApiCall();
    // } else {
    // ? here the user is not opening the screen
    // ? show a simple notification.
    String? imageUrl = _getImageUrl(remoteMessage.notification!);
    showSimpleNotification(
      title: remoteMessage.notification!.title!,
      body: remoteMessage.notification!.body!,
      payload: payload,
      imageUrl: imageUrl,
    );
    // }
  }

  static void _onNotificationTap(NotificationResponse notificationResponse) {
    // ? handles the click of the notification
    // ? opened from _handleForegroundRemoteMessage()
    AppLogger.log('Foreground Notification Tapped.');
    if (notificationResponse.payload != null) {
      Map<String, dynamic> data = jsonDecode(notificationResponse.payload!);
      AppLogger.log(data.toString());

      /// just navigate to the screen and handle loading data their
      // Get.to(() => const NotificationsScreen());
    }
  }
}

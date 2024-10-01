import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:general_app/config/clients/storage/storage_client.dart';
import 'package:general_app/config/helpers/logging_helper.dart';
import 'package:general_app/config/language/language_model.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/screens/home_screen.dart';
import 'package:general_app/widgets/app_widgets/app_focus_remover.dart';
import 'package:general_app/widgets/app_widgets/app_offline_handler.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'config/constants.dart';
import 'config/environment.dart';
import 'config/language/translation.dart';
import 'config/notifications/notifications_service.dart';
import 'config/theme/theme_controller.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}

Future _firebaseBackgroundMessage(RemoteMessage remoteMessage) async {
  if (remoteMessage.notification != null) {
    AppLogger.log('Background Notification Received.');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await StorageClient().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationsService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    // OfflineHandler.handle();
  }

  @override
  Widget build(BuildContext context) {
    String appLanguage = StorageClient().getAppLanguage();

    return Obx(
      () => AppFocusRemover(
        child: OKToast(
          child: GetMaterialApp(
            title: 'app_name'.tr,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: Constants.fontFamily,
              extensions: [themeController.appColors.value],
            ),
            debugShowCheckedModeBanner:
                Environment.appMode == AppMode.staging ||
                    Environment.appMode == AppMode.testing,
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
            supportedLocales: LanguageData.supportedLocales,
            translations: Translation(),
            locale: Locale(appLanguage),
            fallbackLocale: Locale(appLanguage),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const HomeScreen(),
            builder: (context, child) {
              child = EasyLoading.init()(context, child);
              EasyLoading.instance
                ..displayDuration = const Duration(milliseconds: 2000)

                ///loading circular view
                ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                ..loadingStyle = EasyLoadingStyle.custom
                ..maskType = EasyLoadingMaskType.black
                ..indicatorSize = 50.0
                ..radius = 10.0
                ..progressWidth = 3
                ..progressColor = context.kPrimaryColor
                ..textColor = context.kTextColor
                ..backgroundColor = context.kBackgroundColor
                ..indicatorColor = context.kPrimaryColor
                // ..maskColor = Colors.blue.withOpacity(0.5)
                ..textStyle = const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )
                ..userInteractions = true
                ..dismissOnTap = false;
              child = MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child,
              );
              return child;
            },
          ),
        ),
      ),
    );
  }
}

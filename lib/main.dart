import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stylish_app/app_module/authentication/login.dart';
import 'package:stylish_app/app_module/splash/splash_view.dart';
import 'package:stylish_app/app_module/user_home/controller/user_controller.dart';
import 'package:stylish_app/services/api_constants.dart';
import 'package:stylish_app/services/fcm/local_notification.dart';


late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await NotificationService().init();
  await NotificationService().requestIOSPermissions();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCOCg6o0dFxLkl3BT2HzPbskHbK9yclht0",
            appId: "1:74375109450:ios:4473a8088533494ec97fb3",
            messagingSenderId: "74375109450",
            projectId: "topdeals-42e87"));
    FirebaseMessaging.instance.requestPermission();
  } else {
    await Firebase.initializeApp();
  }
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  Stripe.publishableKey = "pk_test_51NZdiJLC6LiTjdzuf5C9caPwP8zf96081C4k1pHW3fUAoAIEvyeFu8Bbil0DrqphMzY0l2b0RmPimE0fYDT2l33k00m6qXyu5l";
  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/.env");
  runApp(const Application());
}

int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(

      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return  GetMaterialApp(
//       locale: const Locale('ar', 'AE'),
//       translations: LocaleString(),
//       fallbackLocale: const Locale('en', 'US'),
//       title: Strings.appName,
//       debugShowCheckedModeBanner: false,
//       home: SplashView(),
//     );
//   }
// }

/// Renders the example application.
class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  String? _token;

  late Stream<String> _tokenStream;

  void setToken(String? token) {
    debugPrint('FCM Token: $token');
    setState(() {
      _token = token;
      ApiConstants.FCM_TOKEN = token!;
    });
    debugPrint('******************************************');
    debugPrint('FCM Token: ${ApiConstants.FCM_TOKEN}');
    debugPrint('******************************************');
  }

  void messagePop() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('A new onMessageOpenedApp event was published!     $message');
    });
  }

  @override
  void initState() {
    super.initState();
    messagePop();
    FirebaseMessaging.instance
        .getToken(
        vapidKey:
        'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Received...");
      log(message.data.toString());
      log(message.toString());
      log(message.data.toString());
      Get.put(UserController()).getOrderData();


      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        NotificationService().showNotifications(
            id: 1,
            title: message.notification!.title,
            body: message.notification!.body);
        setState(() {
          ApiConstants.isNotification = true;
          //ApiConstants.bidSlug = message.data["bid"].toString();
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

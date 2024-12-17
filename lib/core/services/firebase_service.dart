import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../global_data.dart';
import '../utils/debug_utils.dart';

class FirebaseService {
  FirebaseService._();
  static FirebaseService? _instance;
  static FirebaseService get instance {
    if (_instance == null) {
      throw Exception("FirebaseService has not been properly initialized, "
          "please call await FirebaseService.init in main");
    }
    return _instance!;
  }

  static Future<FirebaseService> init() async {
    if (_instance != null) {
      return _instance!;
    }

    _instance = FirebaseService._();
    await Firebase.initializeApp();

    ///
    /// Firebase Messaging
    ///
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    messaging.onTokenRefresh.listen((token) {
      InnoGlobalData.deviceToken = token;
    });
    if (token != null) {
      InnoGlobalData.deviceToken = token;
    }

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    DebugManager.log('User granted permission: ${settings.authorizationStatus}');

    // Foreground Messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Background Messages
    FirebaseMessaging.onBackgroundMessage(_instance!._firebaseMessagingBackgroundHandler);

    return _instance!;
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    // await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }
}

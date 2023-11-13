import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final fcm = FirebaseMessaging.instance;

  Future<void> initNotifiaction() async {
    await fcm.requestPermission();

    final fcmToken = await fcm.getToken();

    print('fcm Token : $fcmToken');
  }
}

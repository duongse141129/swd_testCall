import 'package:firebase_messaging/firebase_messaging.dart';

class HandleMessagingFirebase {

  static Future<void> receiveMessagingFromServer(String uid) async {
    await FirebaseMessaging.instance.subscribeToTopic(uid);
    print('subscribeToTopic '+ uid);

  }
}
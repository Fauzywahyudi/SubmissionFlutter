import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_database/firebase_database.dart';

class Notifikasi extends StatefulWidget {
  @override
  _NotifikasiState createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  String teks = "";
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
//deklarasi lokal notifikasi
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var mymap = {};
  var title = '';
  var body = {};
  var mytoken = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    //konfigurasi firebase messaging
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      //jadikan mymap == message
      mymap = message;
      //tampilkan notifikasi
      displayNotifikasi(message);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
    });
    //request notifikasi
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.getToken().then((token) {
      updateToken(token);
      print(token);
    });
  }

  displayNotifikasi(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
        "1", "channelName", "channelDescription");
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    message.forEach((nTitle, nBody) {
      title = nTitle;
      body = nBody;
      setState(() {});
    });
    await flutterLocalNotificationsPlugin.show(
        0,
        message['notification']['title'],
        message['notification']['body'],
        platform);
  }

  updateToken(String token) {
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/$token').set({"token": token});
    mytoken = token;
    teks = mytoken;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FCM Notife'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('$teks')],
        ),
      ),
    );
  }
}

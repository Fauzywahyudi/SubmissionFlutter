import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sekolah_googlemaps/views/login.dart';
// import 'package:sekolah_googlemaps/bloc_pattern/bloc_main.dart';
import 'package:sekolah_googlemaps/views/root.dart';
import 'package:sekolah_googlemaps/service/authentication.dart';
// import 'package:sekolah_googlemaps/maps/page_maps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Sekolah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String teks = "";
//declarate firebase messaging
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
//declarate local notifications
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var myMap = {};
  var title = '';
  var body = {};
  var myToken = '';
  @override
  void initState() {
    // TODO: implement initState
    var android = AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = IOSInitializationSettings();
    var platform = InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    //konfigurasi FCM Firebase Cloud Messaging
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("on message $message");
        //jadikan mymap message
        myMap = message;
        //tampilkan notifikasi
        displayNotifications(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("on Resume $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("on Resume $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.getToken().then((token) {
      //updateToken Notifications
      updateToken(token);
      print(token);
    });
  }

  displayNotifications(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
        "1", "channelName", "channelDescription");
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    message.forEach((nTitle, nBody) {
      title = nTitle;
      body = nBody;
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
    myToken = token;
    teks = myToken;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("TOKEN = $teks"),
            // RaisedButton(
            //   child: Text("Bloc Pattern"),
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => BlocPage()));
            //   },
            // ),
            // RaisedButton(
            //   child: Text("Button Maps"),
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => PageMaps()));
            //   },
            // ),
            RaisedButton(
              child: Text("Button Login"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RootPage(
                              auth: new Auth(),
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}

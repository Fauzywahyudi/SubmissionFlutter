import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:form_login_register_mahasiswa/views/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Form Mahasiswa Client Server',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          BotToastNavigatorObserver()
        ], //Register route observer
        builder: BotToastInit(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen());
  }
}

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/views/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        BotToastNavigatorObserver()
      ], //Register route observer
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

import 'package:aplikasi_notes/utils/assets.dart';
import 'package:aplikasi_notes/views/splashscreen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      navigatorObservers: [
        BotToastNavigatorObserver()
      ], //Register route observer
      builder: BotToastInit(),
      theme: ThemeData(
        primarySwatch: colPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

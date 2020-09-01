import 'package:bot_toast/bot_toast.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/views/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
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

import 'package:bot_toast/bot_toast.dart';
import 'package:crud_sqflite/views/add_mahasiswa.dart';
import 'package:crud_sqflite/views/home.dart';
import 'package:crud_sqflite/views/register.dart';

import 'views/login.dart';
import 'views/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD SQFlite Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      routes: {
        Login.routeName: (context) => Login(),
        Register.routeName: (context) => Register(),
        HomePage.routeName: (context) => HomePage(),
        TambahMahasiswa.routeName: (context) => TambahMahasiswa(),
      },
      home: SplashScreen(),
    );
  }
}

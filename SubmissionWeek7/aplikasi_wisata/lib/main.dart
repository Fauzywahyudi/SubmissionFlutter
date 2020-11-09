import 'package:aplikasi_wisata/views/add_wisata.dart';
import 'package:aplikasi_wisata/views/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Wisata',
      debugShowCheckedModeBanner: false,
      routes: {
        AddWisata.routeName: (context) => AddWisata(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

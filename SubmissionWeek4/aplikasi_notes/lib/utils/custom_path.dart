import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:aplikasi_notes/utils/assets.dart';

class CustomClip extends StatelessWidget {
  final asset = "assets/images/";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            color: colPrimary,
            height: 200,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: 175,
          child: Hero(tag: "logo", child: Image.asset(asset + "logo.png")),
        ),
      ],
    );
  }
}

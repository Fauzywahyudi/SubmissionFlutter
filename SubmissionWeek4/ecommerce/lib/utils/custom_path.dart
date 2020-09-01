import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:ecommerce/utils/assets.dart';

class CustomClip extends StatelessWidget {
  final asset = "assets/images/";
  final double height;

  const CustomClip({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            color: colPrimary,
            height: height,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: height - 50,
          child: Hero(tag: "logo", child: Image.asset(asset + "logo.png")),
        ),
      ],
    );
  }
}

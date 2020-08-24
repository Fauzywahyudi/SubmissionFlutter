import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_login_register_mahasiswa/utils/assets.dart';

class CustomClip extends StatelessWidget {
  var asset = "assets/images/";

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
          padding: EdgeInsets.all(10),
          height: 175,
          child: Hero(tag: "logo", child: SvgPicture.asset(asset + "logo.svg")),
        ),
      ],
    );
  }
}

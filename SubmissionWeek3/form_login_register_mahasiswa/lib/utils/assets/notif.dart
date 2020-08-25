import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:form_login_register_mahasiswa/utils/assets.dart';

void messageStatus(BuildContext context, int responseCode) {
  if (responseCode == 200) {
    BotToast.showSimpleNotification(
      title: "Sukses",
      closeIcon: Icon(
        Icons.check,
        color: colSuccess,
      ),
    );
    Navigator.pop(context);
  } else {
    BotToast.showSimpleNotification(
      title: "Gagal",
      closeIcon: Icon(
        Icons.close,
        color: colDanger,
      ),
    );
  }
}

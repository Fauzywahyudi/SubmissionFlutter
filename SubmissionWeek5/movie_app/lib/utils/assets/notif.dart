import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/assets.dart';

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

void messageInfo(BuildContext context, String notif) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.info,
      color: colInfo,
    ),
  );
}

void messageSuccess(BuildContext context, String notif) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.check,
      color: colSuccess,
    ),
  );
}

void messageDanger(BuildContext context, String notif) {
  BotToast.showSimpleNotification(
    title: notif,
    closeIcon: Icon(
      Icons.warning,
      color: colDanger,
    ),
  );
}

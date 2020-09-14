import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

messageSuccess(String pesan) {
  BotToast.showSimpleNotification(
    title: pesan,
    closeIcon: Icon(
      Icons.check,
      color: Colors.green,
    ),
  );
}

messageInfo(String pesan) {
  BotToast.showSimpleNotification(
    title: pesan,
    closeIcon: Icon(
      Icons.info,
      color: Colors.blue,
    ),
  );
}

messageFailed(String pesan) {
  BotToast.showSimpleNotification(
    title: pesan,
    closeIcon: Icon(
      Icons.close,
      color: Colors.red,
    ),
  );
}

pushPage(BuildContext context, Widget widget) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ));
}

pushNamePage(BuildContext context, String route) {
  return Navigator.pushNamed(context, route);
}

pushReplaceNamePage(BuildContext context, String route) {
  return Navigator.pushReplacementNamed(context, route);
}

pushReplacePage(BuildContext context, Widget widget) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
      ));
}

popPage(BuildContext context) {
  return Navigator.pop(context);
}

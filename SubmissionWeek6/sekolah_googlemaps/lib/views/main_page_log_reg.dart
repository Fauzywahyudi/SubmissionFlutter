import 'package:flutter/material.dart';
import 'package:sekolah_googlemaps/service/authentication.dart';

class MainPageLogReg extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignOut;
  final String userid;
  MainPageLogReg({this.auth, this.onSignOut, this.userid});
  @override
  _MainPageLogRegState createState() => _MainPageLogRegState();
}

class _MainPageLogRegState extends State<MainPageLogReg> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEmailVerified = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkEmailVerification();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Apps"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: Text(
              "Log Out",
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  void _checkEmailVerification() async {
    isEmailVerified = await widget.auth.isEmailVerified();
    if (!isEmailVerified) {
      _showDialogKonfirmasi();
    }
  }

  void _showDialogKonfirmasi() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Verify Your Acoount"),
            content: Text("Please Verify account in link sent to your email"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  _resendEmailVerifications;
                },
                child: Text("Resent Link"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }

  void _resendEmailVerifications() {
    widget.auth.sendEmailVerification();
    _showDialogEmailVerification();
  }

  void _showDialogEmailVerification() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Verify Your Acoount"),
            content: Text("Please Verify account i link sent to your email"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Dismiss"),
              )
            ],
          );
        });
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }
}

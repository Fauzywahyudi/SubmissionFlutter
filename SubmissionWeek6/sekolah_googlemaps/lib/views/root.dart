import 'package:flutter/material.dart';
import 'package:sekolah_googlemaps/service/authentication.dart';
import 'package:sekolah_googlemaps/views/home.dart';
import 'package:sekolah_googlemaps/views/login.dart';
import '../models/signin_and_signup.dart';
// import '../service/home.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { NOT_DETERMINED, NOT_LOGGED_IN, LOGGED_IN }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userID = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        //cek kalau usernya tidak kosong
        if (user != null) {
          _userID = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

//methode untuk logged in
  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userID = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

//methode untuk sign out
  void _onSignOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userID = "";
    });
  }

//method untuk loading
  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      // case AuthStatus.NOT_LOGGED_IN:
      //   return new LoginPage(
      //     auth: widget.auth,
      //     onLoggedIn: _onLoggedIn,
      //   );
      //   break;
      case AuthStatus.LOGGED_IN:
        if (_userID.length > 0 && _userID != null) {
          return new HomePage(
            userId: _userID,
            auth: widget.auth,
            onSignOut: _onSignOut,
          );
        } else
          return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
    return Container();
  }
}

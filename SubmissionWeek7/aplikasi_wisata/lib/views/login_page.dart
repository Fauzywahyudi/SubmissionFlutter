import 'package:aplikasi_wisata/views/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 'icon',
                child: Container(
                  height: 200,
                  child: SafeArea(
                    child: Image.asset('assets/images/icon.png'),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Aplikasi Wisata\nSumbar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 30, fontFamily: 'McLaren'),
              ),
              SizedBox(height: 100),
              Text(
                'Login with Google',
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Roboto'),
              ),
              SizedBox(height: 40),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    color: Colors.red,
                    onPressed: () => _handleGoogleSign(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Google',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'McLaren'),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSign() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    AuthResult result = await _auth.signInWithCredential(credential);
    final FirebaseUser user = result.user;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
      print('signInWithGoogle succeeded: ${user.displayName}');
    }
  }
}

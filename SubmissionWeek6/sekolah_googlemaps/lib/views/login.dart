import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sekolah_googlemaps/service/authentication.dart';
import 'package:sekolah_googlemaps/views/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FToast fToast;

  Future<void> _handleGoogleSignin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    AuthResult result = await _auth.signInWithCredential(credential);
    final FirebaseUser user = result.user;
    _showToast();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
    // _alertDialog(user);
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
  }

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
                child: Image.asset(
                  "assets/images/bg.png",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Aplikasi Profil Sekolah",
                style: GoogleFonts.mcLaren(color: Colors.blue, fontSize: 30),
              ),
              SizedBox(height: 80),
              RaisedButton.icon(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: Colors.red,
                onPressed: () => _handleGoogleSignin(),
                icon: Icon(
                  LineIcons.google,
                  color: Colors.white,
                ),
                label: Text("google",
                    style: GoogleFonts.mcLaren(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
              // SizedBox(height: 40),
              // RaisedButton.icon(
              //   padding: EdgeInsets.all(20),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(50)),
              //   color: Colors.red,
              //   onPressed: () => _signOut(),
              //   icon: Icon(
              //     LineIcons.power_off,
              //     color: Colors.white,
              //   ),
              //   label: Text("Logout",
              //       style: GoogleFonts.mcLaren(
              //         fontSize: 20,
              //         color: Colors.white,
              //       )),
              // )

              // RaisedButton(
              //     onPressed: () => _handleGoogleSignin(),
              //     child: Text("Login with Google Account")),
              // RaisedButton(onPressed: () => _signOut(), child: Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }

  void _alertDialog(FirebaseUser user) {
    AlertDialog dialog = AlertDialog(
      content: Container(
        height: 230,
        child: Column(
          children: [
            Text(
              "Sudah Login",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Divider(),
            ClipOval(
              child: Image.network(user.photoUrl),
            ),
            SizedBox(height: 15),
            Text("Anda login sebagai ${user.displayName}"),
            Expanded(child: Container()),
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.pop(context),
              color: Colors.green,
            )
          ],
        ),
      ),
    );

    showDialog(context: context, child: dialog);
  }

  void _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Login berhasil"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}

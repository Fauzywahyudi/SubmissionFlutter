// import 'dart:convert';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:ecommerce/models/shared_preferenced.dart';
// import 'package:ecommerce/models/user.dart';
// import 'package:ecommerce/utils/assets.dart';
// import 'package:ecommerce/utils/custom_path.dart';
// import 'package:ecommerce/views/login.dart';
// import 'package:ecommerce/views/register.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:ecommerce/utils/link.dart' as link;
// import 'package:movie_app/utils/assets.dart';

// class BuildLogin extends StatefulWidget {
//   @override
//   _BuildLoginState createState() => _BuildLoginState();
// }

// class _BuildLoginState extends State<BuildLogin> {
//   var _tecEmail = TextEditingController();
//   var _tecPassword = TextEditingController();
//   var _focuEmail = FocusNode();
//   var _focPassword = FocusNode();
//   final _keyForm = GlobalKey<FormState>();

//   User _user;
//   DataShared _dataShared = DataShared();
//   // KategoriProvider _kategoriProvider = KategoriProvider();
//   // StatusLogin _statusLogin = StatusLogin.notSignIn;

//   Future<bool> _onWillPop() async {
//     return _dialogExit();
//   }

//   void _tapRegister() => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Register(),
//         ),
//       );

//   void _cekForm() {
//     final form = _keyForm.currentState;
//     if (form.validate() && _validEmail()) {
//       form.save();
//       _login();
//     } else {
//       if (!_validEmail()) {
//         messageInfo(context, "Email tidak valid");
//       }
//     }
//   }

//   void _login() async {
//     final result = await http.post(link.Link.server + "login.php", body: {
//       "email": _tecEmail.text,
//       "password": _tecPassword.text,
//     });
//     final response = await json.decode(result.body);
//     int value = response['value'];
//     String pesan = response['message'];
//     print(pesan);

//     if (value == 1) {
//       final data = await json.decode(response['data']);
//       _user = User(int.parse(data['id_user']), data['email'], data['nama'],
//           data['nohp'], data['alamat'], data['tgl_daftar']);
//       setState(() {
//         _saveDataPref(value, _user);
//         _tecEmail.text = "";
//         _tecPassword.text = "";
//         pushReplacePage(context, Login());
//       });
//     } else if (value == 2) {
//       messageInfo(context, pesan);
//     } else {
//       messageInfo(context, pesan + "\nUsername atau Password Salah!");
//     }
//   }

//   Future _saveDataPref(int value, User user) async {
//     await _dataShared.saveDataPref(value, user);
//   }

//   bool _validEmail() {
//     if (_tecEmail.text.contains(" ")) return false;
//     if (_tecEmail.text.contains("@")) return true;
//     return false;
//   }

//   Future _dialogExit() async {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.INFO,
//       animType: AnimType.BOTTOMSLIDE,
//       title: 'Exit',
//       desc: 'Yakin Keluar Aplikasi',
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {
//         SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//       },
//     )..show();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colPrimary,
//       body: SafeArea(
//         child: WillPopScope(
//           onWillPop: _onWillPop,
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             color: colSecondary,
//             child: Container(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // CustomClip(height: 300.0),
//                     Text(
//                       "Login",
//                       style: GoogleFonts.mcLaren(
//                         color: colPrimary,
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     _buildFormInput(),
//                     SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("No have account? "),
//                         InkWell(
//                           onTap: () => _tapRegister(),
//                           child: Text(
//                             "create here!",
//                             style: GoogleFonts.mcLaren(
//                               color: colPrimary,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFormInput() {
//     return Form(
//       key: _keyForm,
//       child: Column(
//         children: [
//           buildTextField(
//             context: context,
//             hint: "Email",
//             controller: _tecEmail,
//             focus: _focuEmail,
//             nextFocus: _focPassword,
//             icon: Icons.person,
//           ),
//           buildTextField(
//             context: context,
//             hint: "Password",
//             controller: _tecPassword,
//             focus: _focPassword,
//             icon: Icons.lock,
//             obscure: true,
//           ),
//           SizedBox(height: 20),
//           _buildButton(),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Center _buildButton() {
//     return Center(
//       child: InkWell(
//         onTap: () {
//           _cekForm();
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: colPrimary, width: 2),
//           ),
//           child: Text(
//             "Login",
//             style: GoogleFonts.mcLaren(
//                 color: colPrimary, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }

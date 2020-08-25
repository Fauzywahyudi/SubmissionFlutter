import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:form_login_register_mahasiswa/utils/assets.dart';
import 'package:form_login_register_mahasiswa/utils/custom_path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:form_login_register_mahasiswa/utils/link.dart' as link;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var tecNIM = TextEditingController();
  var tecPassword = TextEditingController();
  var tecNama = TextEditingController();
  var tecAlamat = TextEditingController();

  var focNIM = FocusNode();
  var focPassword = FocusNode();
  var focNama = FocusNode();
  var focAlamat = FocusNode();

  final _keyForm = GlobalKey<FormState>();

  String jenisKelamin = "";
  List _jurusan = [
    "Teknik Informatika",
    "Sistem Komputer",
    "Sistem Informasi",
    "Manajemen Informatika"
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentJurusan;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentJurusan = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String jurusan in _jurusan) {
      items.add(new DropdownMenuItem(value: jurusan, child: new Text(jurusan)));
    }
    return items;
  }

  void changedDropDownItem(String selectedJurusan) {
    setState(() {
      _currentJurusan = selectedJurusan;
    });
  }

  void _register() async {
    final result = await http.post(link.Link.main + "register.php", body: {
      "nim": tecNIM.text,
      "pass": tecPassword.text,
      "nama": tecNama.text,
      "alamat": tecAlamat.text,
      "jk": jenisKelamin,
      "jurusan": _currentJurusan,
    });
    final response = await json.decode(result.body);
    int value = response['value'];
    String pesan = response['message'];
    print(pesan);
    if (value == 1) {
      message(context, pesan, Icons.check, colSuccess);
      Navigator.pop(context);
    } else if (value == 2) {
      message(context, pesan, Icons.info, colInfo);
    } else {
      message(context, pesan, Icons.close, colDanger);
    }

    // messageStatus(context, result.statusCode);
  }

  void _cekForm() {
    final form = _keyForm.currentState;
    if (form.validate() && jenisKelamin.isNotEmpty) {
      form.save();
      _register();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: colSecondary,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomClip(),
                  Text(
                    "Register",
                    style: GoogleFonts.mcLaren(
                      color: colPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildFormInput(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormInput() {
    return Form(
      key: _keyForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            hint: "NIM",
            controller: tecNIM,
            focus: focNIM,
            nextFocus: focPassword,
            inputType: TextInputType.number,
            icon: Icons.person,
          ),
          _buildTextField(
            hint: "Password",
            controller: tecPassword,
            focus: focPassword,
            nextFocus: focNama,
            icon: Icons.lock,
            obscure: true,
          ),
          _buildTextField(
            hint: "Nama Lengkap",
            controller: tecNama,
            focus: focNama,
            icon: Icons.person,
            textCapital: TextCapitalization.words,
          ),
          _buildRadio(),
          _buildDropDown(),
          _buildTextField(
            hint: "Alamat",
            controller: tecAlamat,
            focus: focAlamat,
            icon: Icons.home,
            inputAction: TextInputAction.done,
            minLines: 3,
          ),
          SizedBox(height: 20),
          _buildButton(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    String hint,
    TextEditingController controller,
    FocusNode focus,
    FocusNode nextFocus,
    bool obscure,
    int minLines,
    TextInputType inputType,
    TextInputAction inputAction,
    IconData icon,
    TextCapitalization textCapital,
  }) {
    bool _obscure = obscure;
    TextInputType _inputType = inputType;
    TextInputAction _inputAction = inputAction;
    IconData _icon = icon;
    int _minLines = minLines;
    TextCapitalization _textCapital = textCapital;

    if (obscure == null) _obscure = false;
    if (inputType == null) _inputType = TextInputType.text;
    if (inputAction == null) _inputAction = TextInputAction.next;
    if (icon == null) _icon = Icons.text_fields;
    if (minLines == null) _minLines = 1;
    if (textCapital == null) _textCapital = TextCapitalization.none;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: colPrimary,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focus,
        style: textLabel,
        obscureText: _obscure,
        keyboardType: _inputType,
        textInputAction: _inputAction,
        minLines: _minLines,
        maxLines: _minLines,
        textCapitalization: _textCapital,
        decoration: InputDecoration(
          prefixIcon: Icon(_icon),
          border: InputBorder.none,
          hintText: hint,
        ),
        onEditingComplete: () {
          if (nextFocus == null) {
            focus.unfocus();
          } else {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please Input $hint';
          }
          return null;
        },
      ),
    );
  }

  Center _buildButton() {
    return Center(
      child: InkWell(
        onTap: () => _cekForm(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colPrimary, width: 2),
          ),
          child: Text(
            "Register",
            style: GoogleFonts.mcLaren(
                color: colPrimary, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Container _buildDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(
        left: 17,
        right: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colPrimary, width: 3),
      ),
      child: Row(
        children: [
          Icon(
            Icons.school,
            color: colLabel,
          ),
          SizedBox(width: 10),
          Text(
            "Jurusan",
            style: textLabel,
          ),
          Expanded(child: Container()),
          DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _currentJurusan,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            ),
          )
        ],
      ),
    );
  }

  Container _buildRadio() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colPrimary, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 17,
              top: 10,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.wc,
                  color: colLabel,
                ),
                SizedBox(width: 10),
                Text(
                  "Jenis Kelamin",
                  style: textLabel,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Radio(
                  value: "Laki-laki",
                  groupValue: jenisKelamin,
                  onChanged: (v) {
                    setState(() {
                      jenisKelamin = v;
                    });
                  }),
              InkWell(
                child: Text("Laki-laki"),
                onTap: () {
                  setState(() {
                    jenisKelamin = "Laki-laki";
                  });
                },
              ),
              SizedBox(width: 20),
              Radio(
                  value: "Perempuan",
                  groupValue: jenisKelamin,
                  onChanged: (v) {
                    setState(() {
                      jenisKelamin = v;
                    });
                  }),
              InkWell(
                child: Text("Perempuan"),
                onTap: () {
                  setState(() {
                    jenisKelamin = "Perempuan";
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

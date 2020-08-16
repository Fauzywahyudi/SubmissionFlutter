import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:slider_button/slider_button.dart';

class Home extends StatefulWidget {
  static const routeName = '/Home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController tecBB = TextEditingController();
  TextEditingController tecTB = TextEditingController();

  final String _dirImage = "assets/images/";
  bool isMale = true;
  bool isShowForm = false;

  Color get themeColor => isMale ? Colors.purple : Colors.pinkAccent;
  Color get colorSecondaryMale => isMale ? Colors.white : Colors.purple;
  Color get colorSecondaryFemale => !isMale ? Colors.white : Colors.pink;
  Color get colorSelectedMale => isMale ? Colors.purple : Colors.white;
  Color get colorSelectedFemale => !isMale ? Colors.pinkAccent : Colors.white;

  String get _fabText => isShowForm ? "Proses" : "Pilih";
  Icon get _fabIcon => isShowForm ? Icon(Icons.play_arrow) : Icon(Icons.check);

  double get _fontSizeTitle => isShowForm ? 0 : 25;
  double get _fontSizeGender => isShowForm ? 10 : 20;
  double get _opacityForm => isShowForm ? 1 : 0;

  void _onPressFAB() {
    if (!isShowForm) {
      setState(() {
        isShowForm = !isShowForm;
      });
    } else {}
  }

  _selectMale() {
    setState(() {
      if (!isMale) isMale = !isMale;
    });
  }

  _selectFemale() {
    setState(() {
      if (isMale) isMale = !isMale;
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: themeColor,
      floatingActionButton: _buildFAB(),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: media.size.height,
          width: media.size.width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AnimatedDefaultTextStyle(
                  style: GoogleFonts.mcLaren(
                      fontSize: _fontSizeTitle, color: Colors.purple),
                  duration: Duration(milliseconds: 500),
                  child: Text("Select Gender"),
                ),
                _buildSelectGender(),
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _onPressFAB(),
      backgroundColor: themeColor,
      label: AnimatedDefaultTextStyle(
          style: TextStyle(),
          duration: Duration(milliseconds: 500),
          child: Text(_fabText)),
      icon: _fabIcon,
    );
  }

  Widget _buildSelectGender() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isShowForm
          ? MediaQuery.of(context).size.height * 0.3
          : MediaQuery.of(context).size.height * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildGender(_selectMale(),"man.svg", colorSelectedMale, colorSecondaryMale),
          _buildGender(_selectFemale(),"woman.svg", colorSelectedFemale, colorSecondaryFemale),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      child: Column(
        children: <Widget>[
          AnimatedOpacity(
            opacity: _opacityForm,
            duration: Duration(milliseconds: 600),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  AnimatedContainer(
                    decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    duration: Duration(milliseconds: 500),
                    child: Row(
                      children: <Widget>[
                        _label("Berat Badan"),
                        _textField("kg", tecBB),
                        _label("Tinggi Badan"),
                        _textField("cm", tecTB),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String label) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.mcLaren(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixText: label,
          ),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
      ),
    );
  }

  Widget _buildGender(Function onTap, String fileName, Color colorSelected, Color colorSecondary){
    return  Expanded(
      child: InkWell(
        onTap: ()=>onTap,
        child: AnimatedContainer(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: colorSelected,
                borderRadius: BorderRadius.circular(20)),
            duration: Duration(milliseconds: 500),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: SvgPicture.asset(_dirImage + fileName,
                        color: colorSecondary)),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 500),
                    style: GoogleFonts.mcLaren(
                        fontSize: _fontSizeGender,
                        color: colorSecondary),
                    child: Text(
                      "Male",
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

import 'package:calculator_bmi/views/result.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:slider_button/slider_button.dart';
import 'package:swipedetector/swipedetector.dart';

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
  double get _bb => double.parse(tecBB.text);
  double get _tb => double.parse(tecTB.text);

  bool get validasi => tecBB.text.isNotEmpty && tecTB.text.isNotEmpty;

  void _onPressFAB() {
    if (isShowForm) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Result(
                    isMale: isMale,
                    bb: _bb,
                    tb: _tb,
                  )));
    } else {
      setState(() {
        isShowForm = !isShowForm;
      });
    }
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: themeColor,
      floatingActionButton: !isShowForm || validasi ?  _buildFAB() : null,
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
    return SwipeDetector(
      onSwipeDown: () {
        setState(() {
          isShowForm = false;
        });
      },
      onSwipeUp: () {
        setState(() {
          isShowForm = true;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: isShowForm
            ? MediaQuery.of(context).size.height * 0.3
            : MediaQuery.of(context).size.height * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildGender("man.svg", colorSelectedMale, colorSecondaryMale),
            _buildGender(
                "woman.svg", colorSelectedFemale, colorSecondaryFemale),
          ],
        ),
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

  Widget _buildGender(
      String fileName, Color colorSelected, Color colorSecondary) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (fileName == "man.svg") {
            _selectMale();
          } else {
            _selectFemale();
          }
        },
        child: AnimatedContainer(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: colorSelected, borderRadius: BorderRadius.circular(20)),
            duration: Duration(milliseconds: 500),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Hero(
                  tag: fileName,
                  child: SvgPicture.asset(_dirImage + fileName,
                      color: colorSecondary),
                )),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 500),
                    style: GoogleFonts.mcLaren(
                        fontSize: _fontSizeGender, color: colorSecondary),
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

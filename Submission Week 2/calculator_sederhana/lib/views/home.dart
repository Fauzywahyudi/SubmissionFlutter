import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _styleButton(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    );
  }

  var _styleTextPerhitungan = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  var _styleTextButton = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  var _perhitungan = "";
  var _hasilPerhitungan = "";
  var _parameter = 0;
  var _dataParameter = List();
  bool _equal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5 - 10,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                ),
                color: const Color(0xffff0045),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Column(
                      children: <Widget>[
                        Text(
                          _perhitungan,
                          style: _styleTextPerhitungan,
                        ),
                        Text(
                          "${_hasilPerhitungan.toString().length > 0 ? "= $_hasilPerhitungan" : ""} ",
                          style: _styleTextPerhitungan,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: <Widget>[
                            _buildButton("C", Color(0xffff0045)),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            SizedBox(width: 10),
                            _buildButton("DEL", Color(0xffff0045)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: <Widget>[
                            _buildButton(
                              "7",
                              Color(0xffff0045).withOpacity(0.5),
                            ),
                            SizedBox(width: 10),
                            _buildButton(
                                "8", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton(
                                "9", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton("/", Color(0xffff0045)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: <Widget>[
                            _buildButton(
                                "4", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton(
                                "5", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton(
                                "6", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton("*", Color(0xffff0045)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: <Widget>[
                            _buildButton(
                                "1", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton(
                                "2", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton(
                                "3", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton("-", Color(0xffff0045)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: <Widget>[
                            _buildButton(
                                "0", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton(
                                ".", Color(0xffff0045).withOpacity(0.5)),
                            SizedBox(width: 10),
                            _buildButton("=", Color(0xffff0045)),
                            SizedBox(width: 10),
                            _buildButton("+", Color(0xffff0045)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String title, Color color) {
    bool angka;
    try {
      if (int.parse(title) is num) angka = true;
    } catch (e) {
      angka = false;
    }
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (angka) {
            _tapAngka(title);
          } else if (title == "C") {
            _tapClear();
          } else if (title == ".") {
            _tapAngka(title);
          } else if (title == "DEL") {
            _tapDel();
          } else if (title == "=") {
            _tapEqual();
          } else {
            _tapParameter(title);
          }
        },
        child: Container(
          decoration: _styleButton(color),
          child: Center(
            child: Text(
              title,
              style: _styleTextButton,
            ),
          ),
        ),
      ),
    );
  }

  _tapAngka(String tap) {
    setState(() {
      if (_equal) {
        _perhitungan = "";
        _hasilPerhitungan = "";
        _equal = false;
        _parameter = 0;
      }
      _perhitungan += tap;
    });
  }

  _tapClear() {
    setState(() {
      _perhitungan = "";
      _hasilPerhitungan = "";
      _parameter = 0;
      _dataParameter.clear();
      _equal = false;
    });
  }

  _tapParameter(String title) {
    setState(() {
      var param;
      if (_equal) {
        _perhitungan = _hasilPerhitungan;
        _hasilPerhitungan = "";
        _equal = false;
        _parameter = 0;
      }
      if (_parameter > 0) {
        _tapEqual();
      } else if (_perhitungan.length < 1) {
      } else {
        param = _perhitungan.substring(_perhitungan.length - 1);
        if (param == "/" || param == "*" || param == "-" || param == "+") {
          setState(() {
            _perhitungan =
                _perhitungan.substring(0, _perhitungan.length - 1) + title;
            _dataParameter.last = title;
          });
        } else {
          _tapAngka(title);
          setState(() {
            _dataParameter.add(title);
            _parameter++;
          });
        }
        print(_dataParameter.toString());
        print(_parameter);
      }
    });
  }

  _tapDel() {
    setState(() {
      if (_perhitungan.length < 1) {
      } else {
        _perhitungan = _perhitungan.substring(0, _perhitungan.length - 1);
      }
    });
  }

  _tapEqual() {
    num result = 0;
    if (_parameter == 1) {
      var data = List();
      data = _perhitungan.split(_dataParameter[0]);

      if (_dataParameter[0] == "+") {
        result = num.parse(data[0]) + num.parse(data[1]);
      } else if (_dataParameter[0] == "-") {
        result = num.parse(data[0]) - num.parse(data[1]);
      } else if (_dataParameter[0] == "*") {
        result = num.parse(data[0]) * num.parse(data[1]);
      } else if (_dataParameter[0] == "/") {
        result = num.parse(data[0]) / num.parse(data[1]);
      }
    }
    setState(() {
      _hasilPerhitungan = result.toString();
      _equal = true;
      _parameter = 0;
    });
  }
}

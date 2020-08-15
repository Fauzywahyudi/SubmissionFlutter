import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  var _styleTextHasil = TextStyle(
    color: Colors.white,
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  var _styleTextButton = TextStyle(
    color: Colors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
  final f = new NumberFormat("#,##0.00", "en_US");
  var _operator = "";
  var _operasi = "";
  bool _showResult = false;
  String get _textOperasi => _operasi;
  num _hasilOperasi = 0;
  String get _textHasilOperasi => _hasilOperasi.toString();
  var _dataAngka = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            _buildDisplay(context),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(3.0),
                height: MediaQuery.of(context).size.height * 0.6,
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
                    _buildExpanded(["7", "8", "9", "/"]),
                    _buildExpanded(["4", "5", "6", "*"]),
                    _buildExpanded(["1", "2", "3", "-"]),
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

  Container _buildDisplay(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 - 10,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                AnimatedDefaultTextStyle(
                  textAlign: TextAlign.right,
                  style: _showResult ? _styleTextPerhitungan : _styleTextHasil,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _textOperasi,
                  ),
                ),
                AnimatedDefaultTextStyle(
                  textAlign: TextAlign.right,
                  style: _showResult ? _styleTextHasil : _styleTextPerhitungan,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _showResult && (num.parse(_textHasilOperasi) % 1 == 0)
                        ? _textHasilOperasi
                        : _showResult && (num.parse(_textHasilOperasi) % 1 < 1)
                            ? f.format(num.parse(_textHasilOperasi))
                            : "",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded _buildExpanded(var data) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: <Widget>[
            _buildButton(
              data[0],
              Color(0xffff0045).withOpacity(0.5),
            ),
            SizedBox(width: 10),
            _buildButton(data[1], Color(0xffff0045).withOpacity(0.5)),
            SizedBox(width: 10),
            _buildButton(data[2], Color(0xffff0045).withOpacity(0.5)),
            SizedBox(width: 10),
            _buildButton(data[3], Color(0xffff0045)),
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
            _tapAdd(title);
          } else if (title == "C") {
            _tapClear();
          } else if (title == ".") {
            _tapAdd(title);
          } else if (title == "DEL") {
            _tapDel();
          } else if (title == "=") {
            _tapEqual();
          } else {
            _tapOperator(title);
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

  _tapAdd(var tap) {
    setState(() {
      if (_showResult) {
        _showResult = false;
        _operator = "";
        _operasi = tap;
      } else {
        _operasi += tap;
      }
      // _perhitungan += tap;
    });
  }

  _tapOperator(String tap) {
    if (_showResult) {
      setState(() {
        _operasi = _hasilOperasi.toString();
        _showResult = false;
        _dataAngka.clear();
        _dataAngka.add(_operasi);
        _operator = tap;
        _operasi += tap;
      });
    } else {
      _getLast(tap);
      if (_operator.isNotEmpty) {
        _tapEqual();
      } else {
        setState(() {
          _dataAngka.add(_operasi.substring(0, _operasi.length));
          _operasi += tap;
          _operator = tap;
        });
      }
    }
  }

  _tapClear() {
    setState(() {
      _operasi = "";
      _operator = "";
      _hasilOperasi = null;
      _dataAngka.clear();
      _showResult = false;
    });
  }

  _tapDel() {
    if (_showResult) {
      setState(() {
        _showResult = false;
        _operasi = "";
        _operator = "";
      });
    } else {
      setState(() {
        if (_operasi.length < 1) {
        } else {
          var last = _operasi.substring(_operasi.length - 1);
          if (last == "/" || last == "*" || last == "-" || last == "+") {
            _operator = "";
            print(_operator.isEmpty);
            _dataAngka.clear();
          }
          _operasi = _operasi.substring(0, _operasi.length - 1);
        }
      });
    }
  }

  _tapEqual() {
    if (_showResult) {
    } else {
      if (_operator.isNotEmpty) {
        var data = _operasi.toString().split(_operator);
        _dataAngka.add(data.last);
        switch (_operator) {
          case "+":
            _penjumlahan(_dataAngka);
            break;
          case "-":
            _pengurangan(_dataAngka);
            break;
          case "*":
            _perkalian(_dataAngka);
            break;
          case "/":
            _pembagian(_dataAngka);
            break;
        }
      } else {}
    }
  }

  _getLast(var tap) {
    var last = _operasi.substring(_operasi.length - 1);
    if (last == "/" || last == "*" || last == "-" || last == "+") {
      setState(() {
        _operasi = _operasi.substring(0, _operasi.length - 1) + tap;
        _operator = tap;
        print(_operator);
      });
    }

    // else {
    //   _tapAdd(tap);
    //   setState(() {
    //     _operator = tap;
    //   });
    // }
  }

  _penjumlahan(var data) {
    setState(() {
      num hasil = num.parse(data[0]) + num.parse(data[1]);
      _hasilOperasi = hasil;
      _showResult = true;
      _dataAngka.clear();
    });
  }

  _pengurangan(var data) {
    setState(() {
      num hasil = num.parse(data[0]) - num.parse(data[1]);
      _hasilOperasi = hasil;
      _showResult = true;
      _dataAngka.clear();
    });
  }

  _perkalian(var data) {
    setState(() {
      num hasil = num.parse(data[0]) * num.parse(data[1]);
      _hasilOperasi = hasil;
      _showResult = true;
      _dataAngka.clear();
    });
  }

  _pembagian(var data) {
    setState(() {
      num hasil = num.parse(data[0]) / num.parse(data[1]);
      _hasilOperasi = hasil;
      _showResult = true;
      _dataAngka.clear();
    });
  }

  // _refresh() {}
}

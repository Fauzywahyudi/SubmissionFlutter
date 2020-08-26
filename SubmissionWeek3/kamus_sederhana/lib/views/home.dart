import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kamus_sederhana/utils/assets/color.dart';
import 'package:kamus_sederhana/utils/assets/text_style.dart';
import 'package:kamus_sederhana/utils/link.dart' as link;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _currentSearch = "";
  final asset = "assets/images/";
  var tecSearch = TextEditingController();

  Future<List> _getData(String search) async {
    final result = await http
        .post(link.Link.main + "getData.php", body: {"search": search});
    final response = await json.decode(result.body);
    // return response;
    int value = response['value'];
    String pesan = response['message'];
    if (value == 1) {
      final data = await json.decode(response['data']);
      return data;
    }
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: Container(
        child: Stack(
          children: [
            _buildBody(),
            _buildHeader(),
            _buildSearchInput(),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        color: colPrimary,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                color: colPrimary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: colSecondary,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          asset + "logo.png",
                        ),
                      ),
                    ),
                    Text(
                      "Kamus Informatika",
                      style: GoogleFonts.mcLaren(
                          color: colSecondary, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: colSecondary,
              height: MediaQuery.of(context).size.height - 180,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Kamus Informatika",
        style: GoogleFonts.mcLaren(),
      ),
      elevation: 0.0,
    );
  }

  Widget _buildSearchInput() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                controller: tecSearch,
                cursorColor: Theme.of(context).primaryColor,
                style: textDark.copyWith(fontSize: 18),
                decoration: InputDecoration(
                  hintText: "Search..",
                  hintStyle: textLabel,
                  prefixIcon: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(Icons.search),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                ),
                onChanged: (value) {
                  setState(() {
                    _currentSearch = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colPrimary,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 60),
      child: FutureBuilder<List>(
        future: _getData(_currentSearch),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? _buildList(snapshot) : _buildLoading();
        },
      ),
    );
  }

  Widget _noRecord() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: SvgPicture.asset(asset + "nodata.svg"),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Tidak ada data",
          style: textLabel.copyWith(fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildList(AsyncSnapshot<List> snapshot) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: snapshot.data.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return _buildItemList(snapshot, index);
              },
            )
          : _noRecord(),
    );
  }

  Widget _buildItemList(AsyncSnapshot<List> snapshot, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  snapshot.data[index]['kata'],
                  style: GoogleFonts.mcLaren(fontSize: 17, color: colPrimary),
                ),
              ),
              Divider(
                indent: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text(
                  snapshot.data[index]['penjelasan'],
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return ListTile(
    //   title: Text(snapshot.data[index]['kata']),
    //   subtitle: Text(snapshot.data[index]['penjelasan']),
    // );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}

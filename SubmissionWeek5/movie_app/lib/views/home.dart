import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/repository/shared_preferenced.dart';
import 'package:movie_app/utils/assets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils/link.dart' as link;
import 'package:movie_app/views/detail_video.dart';
import 'package:movie_app/views/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _page = "Home";

  Future<List> _getVideo(String status) async {
    DataShared dataShared = DataShared();
    int idUser = await dataShared.getId();
    final result = await http.post(link.Link.server + "getVideo.php", body: {
      "status": status,
      "id_user": idUser.toString(),
    });
    final response = await json.decode(result.body);
    List data;
    int value = response['value'];
    String pesan = response['message'];

    if (value == 1) {
      data = json.decode(response['data']);
    } else {
      messageDanger(context, pesan);
    }
    return data;
  }

  Future<Null> handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();
    new Future.delayed(new Duration(milliseconds: 500)).then((_) {
      completer.complete();
      setState(() {});
    });
    return completer.future;
  }

  Future _logout() async {
    DataShared dataShared = DataShared();
    await dataShared.logout();
    setState(() {
      pushReplacePage(context, Login());
    });
  }

  void _dialogLogout() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Logout',
      desc: 'Yakin untuk Logout',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _logout();
      },
    )..show();
  }

  Future<bool> _onWillPop() async {
    _dialogLogout();
  }

  Color _text(String value) => _page == value ? colSecondary : Colors.black54;
  Color _item(String value) =>
      _page == value ? colPrimary.withOpacity(0.8) : Colors.white;

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$_page Movie App",
          textAlign: TextAlign.left,
          style: GoogleFonts.mcLaren(
            color: colSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  color: colPrimary,
                  child: SvgPicture.asset(
                    link.Link.asset + "logo.svg",
                  ),
                ),
                Container(
                  color: _item("Home"),
                  child: ListTile(
                    title: Text(
                      "Home",
                      style: GoogleFonts.mcLaren(
                        color: _text("Home"),
                      ),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: _text("Home"),
                    ),
                    onTap: () {
                      setState(() {
                        _page = "Home";
                      });
                      popPage(context);
                    },
                  ),
                ),
                Container(
                  color: _item("Favorite"),
                  child: ListTile(
                    title: Text(
                      "Favorite",
                      style: GoogleFonts.mcLaren(
                        color: _text("Favorite"),
                      ),
                    ),
                    leading: Icon(
                      Icons.favorite,
                      color: _text("Favorite"),
                    ),
                    onTap: () {
                      setState(() {
                        _page = "Favorite";
                      });
                      popPage(context);
                    },
                  ),
                ),
                Container(
                  color: _item("Logout"),
                  child: ListTile(
                    title: Text(
                      "Logout",
                      style: GoogleFonts.mcLaren(
                        color: _text("Logout"),
                      ),
                    ),
                    leading: Icon(
                      Icons.exit_to_app,
                      color: _text("Logout"),
                    ),
                    onTap: () {
                      _dialogLogout();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: colPrimary,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Container(
            height: mediaSize.height,
            width: mediaSize.width,
            color: colSecondary,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _pageControl(mediaSize),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageControl(Size mediaSize) {
    switch (_page) {
      case "Home":
        return _buildHome(mediaSize);
        break;
      case "Favorite":
        return _buildFavorite(mediaSize);
        break;
      default:
        return _buildHome(mediaSize);
        break;
    }
  }

  Container _buildHome(Size mediaSize) {
    return Container(
      child: Stack(
        children: [
          Container(
            color: colPrimary,
            height: mediaSize.height - 50,
          ),
          Container(
              height: mediaSize.height - 50,
              padding: EdgeInsets.only(top: 50, left: 20, right: 10),
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
                color: colSecondary,
              ),
              child: FutureBuilder<List>(
                future: _getVideo(""),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? _buildList(snapshot)
                      : Center(child: CircularProgressIndicator());
                },
              )),
        ],
      ),
    );
  }

  Container _buildFavorite(Size mediaSize) {
    return Container(
      child: Stack(
        children: [
          Container(
            color: colPrimary,
            height: mediaSize.height - 50,
          ),
          Container(
              height: mediaSize.height - 50,
              padding: EdgeInsets.only(top: 50, left: 20, right: 10),
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
                color: colSecondary,
              ),
              child: FutureBuilder<List>(
                future: _getVideo("favorite"),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? _buildList(snapshot)
                      : Center(child: CircularProgressIndicator());
                },
              )),
        ],
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<List> snapshot) {
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: snapshot.data.isEmpty
          ? _noNotif()
          : ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return _itemList(snapshot.data[index], index);
              },
            ),
    );
  }

  Widget _itemList(var data, int index) {
    return InkWell(
      onTap: () async {
        await pushPage(context, DetailVideo(data: data));
        handleRefresh();
      },
      borderRadius: BorderRadius.circular(20),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Hero(
                    tag: data['id_video'],
                    child: Image.network(
                        link.Link.thumbnail + data['thumbnail']))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data['title'],
                style: GoogleFonts.mcLaren(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noNotif() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.height / 3,
              child: SvgPicture.asset(
                'assets/images/nodata.svg',
                fit: BoxFit.cover,
              )),
          Container(
            child: Text(
              "Tidak Ada Data",
              style: TextStyle(color: Colors.grey, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}

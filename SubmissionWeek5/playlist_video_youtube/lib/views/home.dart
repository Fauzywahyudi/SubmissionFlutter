import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playlist_video_youtube/views/playlist_video.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _page = "Home";
  String _url = "";
  static String _urlApiFlutter = "https://myplaylistflutter.herokuapp.com/";
  static String _urlApiLaravel = "https://mylistlaravel.herokuapp.com/";

  Color _fontColor(String menu) =>
      menu == _page ? Colors.white : Colors.black54;
  Color _menuColor(String menu) => menu == _page ? Colors.red : Colors.white;

  void _onTapdMenu(String value, url) {
    setState(() {
      _page = value;
      _url = url;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(_page),
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_page) {
      case "Home":
        return _pageHome();
        break;
      case "Flutter":
        return PlaylistVideo(
          title: _page,
          url: _url,
        );
        break;
      case "Laravel 6":
        return PlaylistVideo(
          title: _page,
          url: _url,
        );
        break;
      default:
        return _pageHome();
        break;
    }
  }

  Container _pageHome() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 150),
          Container(
            height: 250,
            child: Image.asset(
              "images/welcome.png",
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Selamat Datang di Playlist Video Youtube",
            textAlign: TextAlign.center,
            style: GoogleFonts.mcLaren(fontSize: 25),
          ),
        ],
      ),
    );
  }

  SafeArea _buildDrawer() {
    return SafeArea(
      child: Drawer(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/drawer.png"))),
                ),
                _listMenu(Icons.home, "Home", ""),
                _listMenu(Icons.playlist_play, "Flutter", _urlApiFlutter),
                _listMenu(Icons.playlist_play, "Laravel 6", _urlApiLaravel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listMenu(IconData icon, String menu, url) {
    return Container(
      color: _menuColor(menu),
      child: ListTile(
        leading: Icon(icon, color: _fontColor(menu)),
        title: Text(
          menu,
          style: GoogleFonts.mcLaren(color: _fontColor(menu)),
        ),
        autofocus: true,
        onTap: () => _onTapdMenu(menu, url),
      ),
    );
  }
}

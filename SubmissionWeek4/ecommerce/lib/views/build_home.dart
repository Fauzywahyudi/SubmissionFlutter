import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/kategori_provider.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ecommerce/utils/link.dart' as link;

class BuildHome extends StatefulWidget {
  final User user;

  const BuildHome({Key key, this.user}) : super(key: key);
  @override
  _BuildHomeState createState() => _BuildHomeState();
}

class _BuildHomeState extends State<BuildHome> {
  KategoriProvider _kategoriProvider = KategoriProvider();
  Future<bool> _onWillPop() async {
    return _dialogExit();
  }

  Future _dialogExit() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Exit',
      desc: 'Yakin Keluar Aplikasi',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
    )..show();
  }

  Future<List> _getKategori() async {
    final result = await _kategoriProvider.getAllKategori(context);
    return result;
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Likes',
      style: optionStyle,
    ),
    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => _tapAddNotes(),
      // ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Container(
            color: colSecondary,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerViewIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: true,
                    expandedHeight: 200,
                    flexibleSpace: _buildFlexibleSpaceBar(),
                  ),
                ];
              },
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Kategori",
                      style: GoogleFonts.mcLaren(
                        color: colPrimary,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  _listFutureBuilder(),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 800),
                tabBackgroundColor: Colors.grey[800],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.heart_o,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: LineIcons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }

  Container _listFutureBuilder() {
    return Container(
      height: 160,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: FutureBuilder<List>(
        future: _getKategori(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return _buildItemGrid(snapshot.data[index]);
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildItemGrid(var data) {
    return InkWell(
      onTap: () async {
        print(data['nama_kategori']);
      },
      child: Container(
        width: 100,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colPrimary,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  link.Link.imageKategori + data['icon_kategori'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AutoSizeText(
              data['nama_kategori'],
              textAlign: TextAlign.center,
              style: GoogleFonts.mcLaren(fontSize: 15),
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }

  FlexibleSpaceBar _buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      title: Text("Ecommerce App"),
      centerTitle: true,
      background: Container(
        decoration: BoxDecoration(color: colPrimary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 15),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(2),
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colSecondary,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Hero(
                          tag: 'foto',
                          child: Image.asset(link.Link.asset + "foto.jpg")),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  widget.user.getNama(),
                  style: GoogleFonts.mcLaren(color: colSecondary, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

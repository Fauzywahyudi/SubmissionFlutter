import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/models/shared_preferenced.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/providers/kategori_provider.dart';
import 'package:ecommerce/providers/produk_provider.dart';
import 'package:ecommerce/utils/assets.dart';
import 'package:ecommerce/views/detail_produk.dart';
import 'package:ecommerce/views/login.dart';
import 'package:ecommerce/views/produk_kategori.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
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
  ProdukProvider _produkProvider = ProdukProvider();
  int _selectedIndex = 0;
  var _tecSearch = TextEditingController();
  final formatter = new NumberFormat.simpleCurrency(
    locale: "IDR",
    decimalDigits: 0,
  );
  TabController tabController;

  DataShared _dataShared = DataShared();
  String _currentSearch = "";

  ScrollController scrollController = new ScrollController();
  bool lastStatus = true;

  Future<bool> _onWillPop() async {
    if (_selectedIndex == 0) {
      return _dialogExit();
    } else {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
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

  Future<List> _getTerlaris() async {
    final result = await _produkProvider.getAllTerlaris(context);
    return result;
  }

  Future<List> _getProdukSearch(String search) async {
    final result = await _produkProvider.getProdukSearch(context, search);
    return result;
  }

  Widget _page() {
    switch (_selectedIndex) {
      case 0:
        return _buildHome();
        break;
      case 1:
        return _buildSearch();
        break;
      case 2:
        return _buildProfil();
        break;
      default:
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

  Future _logout() async {
    await _dataShared.logout();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colPrimary,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: _page(),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHome() {
    return Container(
      color: colSecondary,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 200,
              actions: [
                IconButton(
                  tooltip: "Logout",
                  onPressed: () => _dialogLogout(),
                  icon: Icon(LineIcons.power_off),
                )
              ],
              flexibleSpace: _buildFlexibleSpaceBar(),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
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
              _listBuilderKategori(),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Terlaris",
                  style: GoogleFonts.mcLaren(
                    color: colPrimary,
                    fontSize: 20,
                  ),
                ),
              ),
              _listBuilderTerlaris(),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              height: 50,
              decoration: BoxDecoration(
                color: colSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                child: TextField(
                  controller: _tecSearch,
                  onChanged: (v) {
                    setState(() {
                      _currentSearch = v;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _tecSearch.text = "";
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List>(
                future: _getProdukSearch(_currentSearch),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? RefreshIndicator(
                          onRefresh: handleRefresh,
                          child: GridView.builder(
                              itemCount: snapshot.data.length,
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200.0,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) {
                                return _buildItemGrid(snapshot.data[index]);
                              }),
                        )
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfil() {
    return Container(
      color: colSecondary,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text(widget.user.getEmail()),
              subtitle: Text("Email"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(widget.user.getNama()),
              subtitle: Text("Nama"),
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text(widget.user.getNohp()),
              subtitle: Text("No.HP"),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(widget.user.getAlamat()),
              subtitle: Text("Alamat"),
            ),
          ],
        )),
      ),
    );
  }

  Container _buildBottomNavBar() {
    return Container(
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
              tabBackgroundColor: colPrimary,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
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
    );
  }

  Container _listBuilderKategori() {
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
                    return _listItemKategori(snapshot.data[index]);
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Container _listBuilderTerlaris() {
    return Container(
      height: 280,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: FutureBuilder<List>(
        future: _getTerlaris(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return _listItemTerlaris(snapshot.data[index]);
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _listItemKategori(var data) {
    return InkWell(
      onTap: () => pushPage(
          context,
          ProdukKategori(
            data: data,
          )),
      child: Container(
        width: 100,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(2),
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

  Widget _listItemTerlaris(var data) {
    return InkWell(
      onTap: () async {
        pushPage(context, DetailProduk(data: data));
      },
      child: Card(
        child: Container(
          width: 150,
          child: Column(
            children: [
              Container(
                height: 150,
                width: 140,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    // color: colPrimary,
                    ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    link.Link.imageProduk + data['thumbnail'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AutoSizeText(
                data['nama_produk'],
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 15),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              AutoSizeText(
                formatter.format(int.parse(data['harga'])),
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 17, color: colPrimary),
                maxLines: 2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemGrid(var data) {
    return InkWell(
      onTap: () async {
        pushPage(context, DetailProduk(data: data));
      },
      child: Card(
        child: Container(
          width: 150,
          child: Column(
            children: [
              Container(
                height: 150,
                width: 140,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    // color: colPrimary,
                    ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    link.Link.imageProduk + data['thumbnail'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AutoSizeText(
                data['nama_produk'],
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 15),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              AutoSizeText(
                formatter.format(int.parse(data['harga'])),
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren(fontSize: 17, color: colPrimary),
                maxLines: 2,
              )
            ],
          ),
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

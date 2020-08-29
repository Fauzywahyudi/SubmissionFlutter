import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:galeri_photo_mantan/views/detail_mantan.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _daftarMantan = new List();

  var _dataMantan = [
    {
      "nama": "Soekarno",
      "gambar": "soekarno.jpg",
      "jabatan": "Presiden Pertama RI",
      "masa": "18 Agustus 1945—12 Maret 1967",
      "keterangan": "keterangan"
    },
    {
      "nama": "Soeharto",
      "gambar": "soeharto.jpg",
      "jabatan": "Presiden Ke-dua RI",
      "masa": "12 Maret 1967—21 Mei 1998",
      "keterangan": "keterangan"
    },
    {
      "nama": "Bacharuddin Jusuf Habibie",
      "gambar": "habibie.jpg",
      "jabatan": "Presiden Ke-tiga RI",
      "masa": "21 Mei 1998—20 Oktober 1999",
      "keterangan": "keterangan"
    },
    {
      "nama": "Abdurrahman Wahid",
      "gambar": "gusdur.jpg",
      "jabatan": "Presiden Ke-empat RI",
      "masa": "20 Oktober 1999—23 Juli 2001",
      "keterangan": "keterangan"
    },
    {
      "nama": "Megawati Soekarnoputri",
      "gambar": "mega.jpg",
      "jabatan": "Presiden Ke-lima RI",
      "masa": "23 Juli 2001—20 Oktober 2004",
      "keterangan": "keterangan"
    },
    {
      "nama": "Susilo Bambang Yudhoyono",
      "gambar": "sby.png",
      "jabatan": "Presiden Ke-enam RI",
      "masa": "20 Oktober 2004—20 Oktober 2014",
      "keterangan": "keterangan"
    },
  ];

  // void _buildDataMantan() {
  //   for (var i = 0; i < _dataMantan.length; i++) {
  //     _daftarMantan.add(_buildItem(_dataMantan[i]));
  //   }
  // }
  int get _countAxis =>
      MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3;

  @override
  void initState() {
    // _buildDataMantan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                  pinned: false,
                  snap: true,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset('assets/images/lambang.jpg',fit: BoxFit.cover,)),
                        Container(
                          color: Colors.black.withOpacity(0.2),)
                      ],
                    ),
                    title: Text("Mantan Presiden RI", ),
                    centerTitle: true,
                  )),
              SliverPadding(padding: EdgeInsets.only(top: 10)
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return _buildItem(_dataMantan[index]);
                  },
                  childCount: _dataMantan.length,
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 10)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildContainer() {
    return Container(
        child: GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _countAxis),
      itemCount: _dataMantan.length,
      itemBuilder: (context, index) {
        return _buildItem(_dataMantan[index]);
      },
    ));
  }

  Widget _buildItem(var data) {
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailMantan(data: data,))),
      child: Card(
        child: Stack(
          children: [
            Container(
              width: 250,
              child: Hero(
                tag: data['nama'],
                child: Image.asset(
                  'assets/images/${data['gambar']}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                ),
                height: 30,
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: AutoSizeText(
                        data['nama'],
                        style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 1,
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
}

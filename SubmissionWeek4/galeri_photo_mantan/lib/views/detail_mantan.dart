import 'package:flutter/material.dart';

class DetailMantan extends StatefulWidget {
  final data;

  const DetailMantan({Key key, this.data}) : super(key: key);

  @override
  _DetailMantanState createState() => _DetailMantanState();
}

class _DetailMantanState extends State<DetailMantan> {
  var asset = "assets/images/";
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
                pinned: true,
                expandedHeight: 450,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.data['nama']),
                  background: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: widget.data['nama'],
                          child: Image.asset(
                            asset + widget.data['gambar'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.work),
                          title: Text(
                            widget.data['jabatan'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.data['masa'],
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            "Informasi",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            widget.data['keterangan'],
                            textAlign: TextAlign.justify,
                          ),
                          isThreeLine: true,
                        ),
                        SizedBox(
                          height: 200,
                        )
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
//            SliverFillRemaining(
//              child: Container(
//                color: Colors.white,
//                child: SingleChildScrollView(
//                  child: Column(
//                    children: [
//                      ListTile(
//                        leading: Icon(Icons.work),
//                        title: Text(
//                          widget.data['jabatan'],
//                          style: TextStyle(fontWeight: FontWeight.bold),
//                        ),
//                        subtitle: Text(widget.data['masa']),
//                      ),
//                      ListTile(
//                        leading: Icon(Icons.person),
//                        title: Text("Informasi",
//                            style: TextStyle(fontWeight: FontWeight.bold),),
//                        subtitle: Text(widget.data['keterangan'],textAlign: TextAlign.justify,),
//                        isThreeLine: true,
//                      ),
//
//                    ],
//                  ),
//                ),
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}

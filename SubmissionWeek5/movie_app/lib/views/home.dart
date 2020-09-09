import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/utils/assets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/utils/link.dart' as link;
import 'package:movie_app/views/detail_video.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> _getVideo() async {
    final result = await http.get(link.Link.server + "getVideo.php");
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

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie App",
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
            child: Container(
              height: 200,
              color: colPrimary,
            ),
          ),
        ),
      ),
      backgroundColor: colPrimary,
      body: SafeArea(
        child: Container(
          height: mediaSize.height,
          width: mediaSize.width,
          color: colSecondary,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Container(
                        color: colPrimary,
                        height: mediaSize.height - 50,
                      ),
                      Container(
                          height: mediaSize.height - 50,
                          padding:
                              EdgeInsets.only(top: 50, left: 20, right: 10),
                          margin: EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                            ),
                            color: colSecondary,
                          ),
                          child: FutureBuilder<List>(
                            future: _getVideo(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) print(snapshot.error);
                              return snapshot.hasData
                                  ? _buildGridView(snapshot)
                                  : Center(child: CircularProgressIndicator());
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(AsyncSnapshot<List> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return _itemList(snapshot.data[index], index);
      },
    );
  }

  Widget _itemList(var data, int index) {
    return InkWell(
      onTap: () => pushPage(
          context,
          DetailVideo(
            data: data,
          )),
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
}

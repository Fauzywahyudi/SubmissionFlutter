import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:movie_app/utils/assets.dart';
import 'package:movie_app/utils/assets/color.dart';
import 'package:movie_app/utils/link.dart' as link;
import 'package:webview_plugin/webview_plugin.dart';

class DetailVideo extends StatefulWidget {
  final data;

  const DetailVideo({Key key, this.data}) : super(key: key);
  @override
  _DetailVideoState createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
  final formatter = new NumberFormat();

  String _formatLike(String value) {
    if (int.parse(value) >= 1000) {
      String nilai = formatter.format(int.parse(value));
      List data = nilai.split(",");
      return data.first + " rb";
    } else if (int.parse(value) >= 1000000) {
      String nilai = formatter.format(int.parse(value));
      List data = nilai.split(",");
      return data.first + " jt";
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerViewIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: true,
                leading: Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: colPrimary.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => popPage(context),
                  ),
                ),
                expandedHeight: 225,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        height: 250,
                        child: Hero(
                          tag: widget.data['id_video'],
                          child: Image.network(
                            link.Link.thumbnail + widget.data['thumbnail'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        color: colDark.withOpacity(0.3),
                        child: Center(
                          child: IconButton(
                              iconSize: 100,
                              color: colPrimary,
                              icon: Icon(Icons.play_arrow),
                              onPressed: () => pushPage(
                                  context, VideoPlayer(widget.data['link']))),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.data['title'],
                      style: GoogleFonts.mcLaren(fontSize: 20),
                    ),
                    subtitle: Text(
                      formatter.format(
                            int.parse(widget.data['jumlah_tonton']),
                          ) +
                          " x tonton",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIcon(
                          icon: Icons.thumb_up,
                          text: _formatLike(widget.data['jumlah_like']),
                          ontap: null),
                      _buildIcon(
                          icon: Icons.thumb_down,
                          text: _formatLike(widget.data['jumlah_dislike']),
                          ontap: null),
                      _buildIcon(
                          icon: Icons.favorite_border,
                          text: "Favorite",
                          ontap: null),
                      _buildIcon(icon: Icons.share, text: "Share", ontap: null),
                    ],
                  ),
                  ListTile(
                    title: Text("Deskripsi"),
                    subtitle: Text(widget.data['deskripsi']),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell _buildIcon({void Function() ontap, IconData icon, String text}) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () => ontap,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Icon(icon),
            SizedBox(
              height: 10,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class VideoPlayer extends StatelessWidget {
  final url;
  VideoPlayer(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colPrimary,
      child: SafeArea(
        child: Center(
          child: FlutterWebView(
            onWebCreated: (controller) {
              controller.loadUrl("https://youtube.com/embed/" + url);
            },
          ),
        ),
      ),
    );
  }
}

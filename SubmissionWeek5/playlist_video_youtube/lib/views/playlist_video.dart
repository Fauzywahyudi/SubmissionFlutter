import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_plugin/webview_plugin.dart';

class PlaylistVideo extends StatefulWidget {
  final title;
  final url;

  const PlaylistVideo({Key key, this.title, this.url}) : super(key: key);
  @override
  _PlaylistVideoState createState() => _PlaylistVideoState();
}

class _PlaylistVideoState extends State<PlaylistVideo> {
  ScrollController _controller;

  Future<List> getPlaylist() async {
    final result = await http.get(widget.url);
    return json.decode(result.body);
  }

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List>(
        future: getPlaylist(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBuilder(
                  data: snapshot.data,
                  controller: _controller,
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListBuilder extends StatelessWidget {
  final List data;
  final ScrollController controller;

  const ListBuilder({Key key, this.data, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayer(
                              "https://youtube.com/embed/${data[index]['contentDetails']['videoId']}"))),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(data[index]['snippet']
                              ['thumbnails']['high']['url']),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    data[index]['snippet']['title'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VideoPlayer extends StatelessWidget {
  final url;
  VideoPlayer(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Center(
          child: FlutterWebView(
            onWebCreated: (controller) {
              controller.loadUrl(url);
            },
          ),
        ),
      ),
    );
  }
}

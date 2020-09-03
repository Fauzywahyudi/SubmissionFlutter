import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _page = "Home";

  void _onTapdMenu(String value) {
    setState(() {
      _page = value;
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
        return Container(
          color: Colors.white,
          child: Center(
            child: Text("Home"),
          ),
        );
        break;
      case "Flutter":
        return Container(
          color: Colors.white,
          child: Center(
            child: Text("Flutter"),
          ),
        );
        break;
      case "Laravel 6":
        return Container(
          color: Colors.white,
          child: Center(
            child: Text("Laravel 6"),
          ),
        );
        break;
      default:
        return Container(
          color: Colors.white,
          child: Center(
            child: Text("Home"),
          ),
        );
        break;
    }
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: Colors.red,
              ),
              ListTile(
                title: Text("Home"),
                autofocus: true,
                onTap: () => _onTapdMenu("Home"),
              ),
              ListTile(
                title: Text("Flutter"),
                onTap: () => _onTapdMenu("Flutter"),
              ),
              ListTile(
                title: Text("Laravel 6"),
                onTap: () => _onTapdMenu("Laravel 6"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

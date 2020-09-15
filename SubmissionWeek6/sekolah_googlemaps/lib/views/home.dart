import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sekolah_googlemaps/models/food_model.dart';
import 'package:sekolah_googlemaps/service/authentication.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignOut;
  final String userId;
  HomePage({Key key, this.auth, this.onSignOut, this.userId}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> _foodList;
//deklarasi database
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Query _foodQuery;
  final _textEditingCOntroller = TextEditingController();
  StreamSubscription<Event> _onFoodAddedSubscription;
  StreamSubscription<Event> _onFoodChangeSubscription;
  bool isEmailVerified = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkEmailVerification();
    //load data
    _foodList = new List();
    _foodQuery = _database
        .reference()
        .child("data_makanan")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onFoodAddedSubscription = _foodQuery.onChildAdded.listen(_onEntryAdded);
    _onFoodChangeSubscription =
        _foodQuery.onChildChanged.listen(_onEntryChangedd);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onFoodAddedSubscription.cancel();
    _onFoodChangeSubscription.cancel();
  }

//entry data
  _onEntryAdded(Event event) {
    setState(() {
      _foodList.add(FoodModel.fromSnapshot(event.snapshot));
    });
  }

  _addNewFoodList(String foodListItem) {
    if (foodListItem.length > 0) {
      FoodModel foodModel = new FoodModel(
        foodListItem.toString(),
        false,
        widget.userId,
      );
      _database
          .reference()
          .child("data_makanan")
          .push()
          .set(foodModel.toJson());
    }
  }

  _showDialogFoodForm(BuildContext context) async {
    _textEditingCOntroller.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: _textEditingCOntroller,
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Add Food Item'),
                ))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    _addNewFoodList(_textEditingCOntroller.text.toString());
                    Navigator.pop(context);
                  },
                  child: Text('Save'))
            ],
          );
        });
  }

  _onEntryChangedd(Event event) {
    var oldEntry = _foodList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      _foodList[_foodList.indexOf(oldEntry)] ==
          FoodModel.fromSnapshot(event.snapshot);
    });
  }

  void _checkEmailVerification() async {
    isEmailVerified = await widget.auth.isEmailVerified();
    if (!isEmailVerified) {
      _showDialogKonfirmasiEmail();
    }
  }

  void _showDialogKonfirmasiEmail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Silahkan Verifikasi akun anda'),
            content: Text('Please verivy account in link sent to your email'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resentEmailVerifikasi();
                  },
                  child: Text('Resent Link')),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  void _resentEmailVerifikasi() {
    widget.auth.sendEmailVerification();
    _showDialogVerifikasiEmail();
  }

  void _showDialogVerifikasiEmail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verify your account'),
            content:
                Text('please verivy account in the ling sent to your email'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Dismiss'))
            ],
          );
        });
  }

  _singOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
    }
  }

//method untuk emnampilkan list makanan
  Widget _showFoodList() {
    if (_foodList.length > 0) {
      return ListView.builder(
          itemCount: _foodList.length,
          itemBuilder: (BuildContext context, int index) {
            String foodId = _foodList[index].key;
            String foodName = _foodList[index].foodName;
            bool completed = _foodList[index].completed;
            String userId = _foodList[index].userId;
            return Dismissible(
                key: Key(foodId),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) async {
                  _deleteFooodItem(foodId, index);
                },
                child: ListTile(
                  title: Text(
                    foodName,
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                  trailing: IconButton(
                      icon: (completed)
                          ? Icon(
                              Icons.done_outline,
                              color: Colors.green,
                              size: 20.0,
                            )
                          : Icon(
                              Icons.done,
                              color: Colors.grey,
                              size: 20.0,
                            ),
                      onPressed: () {
                        _updateFoodList(_foodList[index]);
                      }),
                ));
          });
    } else {
      return Center(
        child: Text(
          'Welcome. Food list still Empty',
          style: TextStyle(fontSize: 25.0),
        ),
      );
    }
  }

//methode untuk delete data
  _deleteFooodItem(String foodId, int index) {
    _database
        .reference()
        .child("data_makanan")
        .child(foodId)
        .remove()
        .then((_) {
      print("Delete $foodId Successfull");
      _foodList.removeAt(index);
    });
  }

//methode untuk update
  _updateFoodList(FoodModel food) {
    food.completed = !food.completed;
    if (food != null) {
      _database
          .reference()
          .child("data_makanan")
          .child(food.key)
          .set(food.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Food Apps'),
          actions: <Widget>[
            FlatButton(
                onPressed: _singOut,
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ))
          ],
        ),
        body: _showFoodList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialogFoodForm(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}

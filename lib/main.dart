import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './Detail.dart';
import './adddata.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My Store",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get(
        "http://192.168.43.117/my_store/getdata.php"); // your getdata file url here
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.redAccent,
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          size: 35.0,
        ),
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.brown,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        elevation: 8.0,
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new AddData(),
            )),
      ),
      appBar: new AppBar(
        title: new Text(
          "MY STORE",
          style: TextStyle(fontSize: 15.0, color: Colors.red),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Detail(
                      list: list,
                      index: i,
                    ))),
            child: new Card(
              color: Color.fromRGBO(500, 200, 100, 1.0),
              elevation: 8.0,
              child: new ListTile(
                title: new Text(
                  list[i]['item_name'], // column name in the table
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                leading: new Icon(Icons.widgets),
                subtitle: new Text(
                    "Stock : ${list[i]['stock']}"), // // column name in the table

                trailing: new Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
        );
      },
    );
  }
}

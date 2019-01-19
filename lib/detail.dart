import 'package:flutter/material.dart';

import './editdata.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: new AppBar(
          backgroundColor: Colors.orangeAccent,
          title: new Text(
            "${widget.list[widget.index]['item_name']}", // column name in the table
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.red,
            ),
          )),
      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          elevation: 8.0,
          color: Colors.yellowAccent,
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new Text(
                  widget.list[widget.index]
                      ['item_name'], // column name in the table
                  style: new TextStyle(fontSize: 25.0),
                ),
                new Text(
                  "Code : ${widget.list[widget.index]['item_code']}", // column name in the table
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Price : ${widget.list[widget.index]['price']}", // column name in the table
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Stock : ${widget.list[widget.index]['stock']}", // column name in the table
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("EDIT"),
                      color: Colors.green,
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new EditData(
                                  list: widget.list,
                                  index: widget.index,
                                ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:FlutterAppTpl/models/test/test.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String val = '';
  Test testModel;
  void _incrementCounter() {
    setState(() {
      val = testModel.data.friends[0].email;
    });
  }

  @override
  void initState() {
    super.initState();
    testModel = Test.fromJson({
      "num": 1,
      "int": 1,
      "double": 1.1,
      "bool": true,
      "String": "String",
      "List": "List",
      "Map": "Map",
      "import": "import",
      "customize3": 4,
      "user1": {"name": "John Smith", "email": "john@example.com"},
      "user2": {"name": "John Smith", "email": "john@example.com"},
      "data": {
        "name": "John Smith",
        "email": "john@example.com",
        "mother": {"name": "Alice", "email": "alice@example.com"},
        "friends": [
          {"name": "Jack", "email": "Jack@example.com"},
          {"name": "Nancy", "email": "Nancy@example.com"}
        ]
      },
      "Listnum": [1],
      "Listint": [1],
      "Listdouble": [1.1],
      "Listbool": [true],
      "ListString": [''],
      "ListList": [[]],
      "ListMap": [
        {'a': 'a'}
      ],
      "ListUser1": [
        {"name": "John Smith", "email": "john@example.com"}
      ],
      "ListUser2": [
        {"name": "John Smith", "email": "john@example.com"}
      ],
      "ListData": [
        {
          "name": "John Smith",
          "email": "john@example.com",
          "mother": {"name": "Alice", "email": "alice@example.com"},
          "friends": [
            {"name": "Jack", "email": "Jack@example.com"},
            {"name": "Nancy", "email": "Nancy@example.com"}
          ]
        }
      ],
      "customize_": {"name": "John Smith", "email": "john@example.com"}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$val',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

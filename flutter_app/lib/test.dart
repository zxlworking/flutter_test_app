import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'MyTitle',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: new MyStateless(),
    );
  }
}

//class MyStateless extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Center(
//      child: Text(
//        'my content text',
//        style: TextStyle(
//            fontSize: 14,
//            color: Colors.redAccent,
//            backgroundColor: Colors.greenAccent
//        ),
//      ),
//    );
//  }
//}

class MyStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: ListView(
        children: <Widget>[
          Text(
            'text---1',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
                backgroundColor: Colors.greenAccent),
          ),
          Text(
            'text---2',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
                backgroundColor: Colors.greenAccent),
          ),
          Text(
            'text---3',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
                backgroundColor: Colors.greenAccent),
          ),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
    );
  }
}

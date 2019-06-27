import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'MyTitle',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: new MyStateful(title:'title'),
    );
  }
}

class MyStateful extends StatefulWidget{
  final String title;
  MyStateful({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MyState();
  }
}

class MyState extends State<MyStateful>{
  String content = 'www';

  void getHttp() async {
    try {
      Response response = await Dio().get("http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/list?page=0&page_size=20");
      print(response.data);
      content = response.data;
      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new MaterialButton(
            child: Text('click',style: TextStyle(color: Colors.red),),
            onPressed: getHttp,
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 14
            ),
          )
        ],
      )
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

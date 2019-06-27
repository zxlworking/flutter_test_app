import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/QsbkHotPicItem.dart';
import 'package:flutter_app/QsbkHotPicItemList.dart';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'title'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  QsbkHotPicItemList mQsbkHotPicItemList;

  void getHttp() async {
    try {
      Response response = await Dio().get("http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/list?page=0&page_size=100");

      mQsbkHotPicItemList = new QsbkHotPicItemList.fromJson(json.decode(response.data));
      print('mQsbkHotPicItemList.length = ');
      print(mQsbkHotPicItemList.itemList.length);
      mQsbkHotPicItemList.itemList.forEach((qsbkHotPicItem){
        print(qsbkHotPicItem.authorNickName + "---" + qsbkHotPicItem.content);
      });

      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child :
          mQsbkHotPicItemList == null ?
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                    child: Text('loading...',style: TextStyle(color: Colors.blue),)
                  ),
                ],
              )
          )
              :
          ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                QsbkHotPicItem qsbkHotPicItem = mQsbkHotPicItemList.itemList.elementAt(index);
                return new Text(
                  "$index --- ${qsbkHotPicItem.authorNickName}",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return new Container(height: 1.0, color: Colors.blue);
              },
              itemCount: mQsbkHotPicItemList.itemList.length)
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
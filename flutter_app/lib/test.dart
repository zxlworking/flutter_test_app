import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/mode/DayWord.dart';
import 'package:flutter_app/mode/QsbkHotPicItem.dart';
import 'package:flutter_app/mode/QsbkHotPicItemList.dart';
import 'package:flutter_app/widget/MarqueeWidget.dart';
import 'dart:convert';

import 'package:flutter_app/widget/QsbkHotPicItemWidget.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoadingQsbkHotPic = false;
  var mQsbkHotPicPageSize = 10;
  var mQsbkHotPicPage = 0;
  QsbkHotPicItemList mQsbkHotPicItemList;
  DayWord mDayWord;

  void getQsbkHotPic() async {
    if(isLoadingQsbkHotPic){
      return;
    }
    isLoadingQsbkHotPic = true;
    try {
      Response qsbkHotPicResponse = await Dio().get("http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize");
      QsbkHotPicItemList qsbkHotPicItemList = new QsbkHotPicItemList.fromJson(json.decode(qsbkHotPicResponse.data));

      print("page::$mQsbkHotPicPage::$isLoadingQsbkHotPic");

      if(qsbkHotPicItemList == null){
        print("mQsbkHotPicItemList::is null");
        isLoadingQsbkHotPic = false;
        return;
      }
      if(qsbkHotPicItemList.itemList == null){
        print("mQsbkHotPicItemList.itemList::is null");
        isLoadingQsbkHotPic = false;
        return;
      }
      if(qsbkHotPicItemList.itemList.isEmpty == null){
        print("mQsbkHotPicItemList.itemList::is isEmpty");
        isLoadingQsbkHotPic = false;
        return;
      }

      if(mQsbkHotPicItemList == null){
        mQsbkHotPicItemList = qsbkHotPicItemList;
      }else{
        mQsbkHotPicItemList.itemList.addAll(qsbkHotPicItemList.itemList);
      }

      /*mQsbkHotPicItemList.itemList.forEach((item){
        print("item::${item.authorNickName}");
      });*/

      setState(() {
      });

      isLoadingQsbkHotPic = false;
      mQsbkHotPicPage++;
    } catch (e) {
      print(e);
    }
  }

  void getDayWOrd() async {
    try {
      DateTime now = DateTime.now();
      Response dayWordResponse = await Dio().get("http://open.iciba.com/dsapi/?date=${now.year}-${now.month}-${now.day}");
      mDayWord = new DayWord.fromJson(json.decode(dayWordResponse.data));

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
    getQsbkHotPic();
    getDayWOrd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: mDayWord == null ?
            Text(
                widget.title
            )
            :
            MarqueeWidget(
                Container(
                  width: window.physicalSize.width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${mDayWord.content}",
                        style: TextStyle(
                            fontSize: 14
                        ),
                      ),
                      Text(
                        "${mDayWord.note}",
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                ),
                0.0,
                new Duration(seconds: 5),
                230.0
            )
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

                if(index == mQsbkHotPicItemList.itemList.length - 1){
                  getQsbkHotPic();
                }

                QsbkHotPicItem qsbkHotPicItem = mQsbkHotPicItemList.itemList.elementAt(index);
                print("item::index = " + "$index");
                print("item::url = " + qsbkHotPicItem.thumbImgUrl);
                print(qsbkHotPicItem.authorNickName + "---" + qsbkHotPicItem.content);
                return new QsbkHotPicItemWidget().createItemWidget(qsbkHotPicItem);
              },
              separatorBuilder: (BuildContext context, int index) {
                return new Container(height: 1.0, color: Colors.blue);
              },
              itemCount: mQsbkHotPicItemList.itemList.length)
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/mode/DayWord.dart';
import 'package:flutter_app/mode/QsbkItem.dart';
import 'package:flutter_app/mode/QsbkList.dart';
import 'package:flutter_app/widget/MarqueeWidget.dart';
import 'dart:convert';

import 'package:flutter_app/widget/JokeItemWidget.dart';
import 'package:flutter_app/widget/JokeWidget.dart';

import 'DayWordPage.dart';
import 'mode/TabItem.dart';

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

//https://www.qiushibaike.com/commentpage/122204240?page=1&count=10

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _TabWidgetState createState() => _TabWidgetState();
}

class _TabWidgetState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController mController;
  List<TabItem> tabList;

  DayWord mDayWord;

  void getDayWOrd() async {
    try {
      DateTime now = DateTime.now();
      Response dayWordResponse = await Dio().get(
          "http://open.iciba.com/dsapi/?date=${now.year}-${now.month}-${now.day}");
      mDayWord = new DayWord.fromJson(json.decode(dayWordResponse.data));

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void clickTitle(DayWord dayWord) {
    print("clickTitle");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new DayWordPage(mDayWord);
    }));
//    Navigator.push(
//        context, new MaterialPageRoute(builder: (BuildContext context) {
////            return new SecondApp(); //不传值的跳转
////      return new SecondApp(todo: todos[i]);//带传值的跳转
//    }));
  }

  @override
  void initState() {
    super.initState();
    print("TabWidgetState()::initState");
    getDayWOrd();
    initTabData();
    mController = TabController(
      length: tabList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  initTabData() {
    print("TabWidgetState()::initTabData");
    tabList = [
      new TabItem('囧文', 0),
      new TabItem('囧图', 1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("TabWidgetState()::build");
    return Scaffold(
      appBar: AppBar(
          title: mDayWord == null ?
          Text(
              widget.title
          )
              :
          GestureDetector(
            child: MarqueeWidget(
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
            ),
            onTap: (){clickTitle(mDayWord);},
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.all_inclusive),
        backgroundColor: Colors.blue,
        elevation: 2.0,
        highlightElevation: 2.0,
        onPressed: () {},
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: new Color(0xfff4f5f6),
            height: 38.0,
            child: TabBar(
              isScrollable: true,
              //是否可以滚动
              controller: mController,
              labelColor: Colors.red,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tabList.map((item) {
                return Tab(
                  text: item.title,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: mController,
              children: tabList.map((item) {
//                return Stack(children: <Widget>[
//                  Align(alignment:Alignment.topCenter,child: Text(item.title),),
//                ],);
                print("TabWidgetState()::TabBarView::index::${item.index}");
                return new JokeWidget().createWidget(context, item.index);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

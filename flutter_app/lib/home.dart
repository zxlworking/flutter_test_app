
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BaseTabItemWidget.dart';
import 'package:flutter_app/widget/BaseTabWidget.dart';
import 'package:flutter_app/widget/DayWordAppBarWidget.dart';
import 'package:flutter_app/widget/JokeWidget.dart';
import 'package:flutter_app/widget/MaoYanWidget.dart';

void main() => runApp(new HomeApp());

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'my_title',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: TabWidget(),
    );
  }
}

class TabWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabWidgetState();
  }
}

class TabWidgetState extends State<TabWidget> with AutomaticKeepAliveClientMixin{

  List<BaseTabItemWidget> mTabList = [
    MaoYanWidget(0, "电影"),
    //JokeWidget(1, "笑话"),
    BaseTabItemWidget(2, "tab 2"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomeApp::build::width = " + "${MediaQuery.of(context).size.width}");
    return Scaffold(
      appBar: AppBar(title: DayWordAppBarWidget(),),
      body: BaseTabWidget(mTabList),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
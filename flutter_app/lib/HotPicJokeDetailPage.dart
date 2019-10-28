import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'mode/QsbkHotPicItem.dart';
import 'mode/TabItem.dart';

class HotPicJokeDetailPage extends StatelessWidget{

  //http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/detail?hot_pic_id=199
  //https://blog.csdn.net/qq_39969226/article/details/97247140---content provider
  QsbkHotPicItem mQsbkHotPicItem;

  HotPicJokeDetailPage(QsbkHotPicItem qsbkHotPicItem) {
    print("HotPicJokeDetailPage()");
    mQsbkHotPicItem = qsbkHotPicItem;
  }

  @override
  Widget build(BuildContext context) {
    return TabWidget(mQsbkHotPicItem);
  }
}

//https://www.jianshu.com/p/cefe49a0ab7f
class TabWidget extends StatefulWidget {
  QsbkHotPicItem mQsbkHotPicItem;

  TabWidget(QsbkHotPicItem qsbkHotPicItem){
    print("TabWidget()");
    mQsbkHotPicItem = qsbkHotPicItem;
  }

  @override
  State<StatefulWidget> createState() {
    print("TabWidget()::createState");
    return TabWidgetState(mQsbkHotPicItem);
  }
}

class TabWidgetState extends State<TabWidget> with SingleTickerProviderStateMixin {
  TabController mController;
  List<TabItem> tabList;

  QsbkHotPicItem mQsbkHotPicItem;

  TabWidgetState(QsbkHotPicItem qsbkHotPicItem){
    print("TabWidgetState()");
    mQsbkHotPicItem = qsbkHotPicItem;
  }

  @override
  void initState() {
    super.initState();
    print("TabWidgetState()::initState");
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
      new TabItem('内容', 0),
      new TabItem('评论', 1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("TabWidgetState()::build");
    print("TabWidgetState()::build::mQsbkHotPicItem::${mQsbkHotPicItem.authorNickName}");
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
        backgroundColor: Colors.blue,
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
                if(item.index == 0) {
                  return ContentWidget(mQsbkHotPicItem);
                } else if (item.index == 1) {
                  return Stack(children: <Widget>[
                    Align(alignment:Alignment.topCenter,child: Text(item.title),),
                  ],);
                }
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class ContentWidget extends StatefulWidget {
  QsbkHotPicItem mQsbkHotPicItem;

  ContentWidget(QsbkHotPicItem qsbkHotPicItem){
    print("ContentWidget()");
    mQsbkHotPicItem = qsbkHotPicItem;
  }

  @override
  ContentWidgetState createState() => ContentWidgetState(mQsbkHotPicItem);
}

class ContentWidgetState extends State<ContentWidget> {
  bool isLoading = false;
  
  QsbkHotPicItem mQsbkHotPicItem;

  ContentWidgetState(QsbkHotPicItem qsbkHotPicItem){
    mQsbkHotPicItem = qsbkHotPicItem;
  }
  
  void getQsbkHotPicDetail() async {
    print("ContentWidget()::getQsbkHotPicDetail::isLoading::$isLoading");
    if (isLoading) {
      return;
    }
    isLoading = true;
    try {
      Response qsbkHotPicDetailResponse = await Dio().get(
          "http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/detail?hot_pic_id=${mQsbkHotPicItem.id}");
      print("getQsbkHotPicDetail::data::${qsbkHotPicDetailResponse.data}");
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    print("ContentWidget()::initState");
    getQsbkHotPicDetail();
  }

  @override
  Widget build(BuildContext context) {
    print("ContentWidget()::build");
    isLoading = false;
    getQsbkHotPicDetail();
    return Text("content");
  }
  
}

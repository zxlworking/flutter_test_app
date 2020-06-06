import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mode/QsbkDetail.dart';
import 'package:flutter_app/mode/QsbkItem.dart';
import 'package:flutter_app/mode/TabItem.dart';
import 'package:flutter_app/widget/JokeDetailContentWidget.dart';

import 'JokeCommentWidget.dart';


class JokeDetailPage extends StatelessWidget{

  //http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/detail?hot_pic_id=199
  //https://blog.csdn.net/qq_39969226/article/details/97247140---content provider
  QsbkItem mQsbkItem;

  JokeDetailPage(this.mQsbkItem);

  @override
  Widget build(BuildContext context) {
    return TabWidget(mQsbkItem: this.mQsbkItem);
  }
}

//https://www.jianshu.com/p/cefe49a0ab7f
class TabWidget extends StatefulWidget {
  QsbkItem mQsbkItem;
  TabWidget({Key key, this.mQsbkItem}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    print("TabWidget()::createState");
    return TabWidgetState();
  }
}

class TabWidgetState extends State<TabWidget> with SingleTickerProviderStateMixin {
  TabController mController;
  List<TabItem> tabList;

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
      new TabItem('热评', 1),
      new TabItem('评论', 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("TabWidgetState()::build");
    print("TabWidgetState()::build::mQsbkHotPicItem::${widget.mQsbkItem.authorNickName}");
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
                  return ContentWidget(mQsbkHotPicItem: widget.mQsbkItem);
                } else if (item.index == 1) {
                  return new JokeCommentWidget().createWidget(context, widget.mQsbkItem.id, 0);
                } else if (item.index == 2) {
                  return new JokeCommentWidget().createWidget(context, widget.mQsbkItem.id, 1);
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
  QsbkItem mQsbkHotPicItem;
  ContentWidget({Key key, this.mQsbkHotPicItem}) : super(key : key);

  @override
  ContentWidgetState createState() => ContentWidgetState();
}

class ContentWidgetState extends State<ContentWidget> {
  bool isLoading = false;

  QsbkDetail mQsbkDetail;
  
  void getQsbkHotPicDetail() async {
    print("ContentWidget()::getQsbkHotPicDetail::isLoading::$isLoading");
    if (isLoading) {
      return;
    }
    isLoading = true;
          String url = "http://zxltest.zicp.vip:51763/";
//    String url = "http://192.168.31.63:9090/";
    try {
      url = url + "test/qsbk/detail?joke_id=${widget.mQsbkHotPicItem.id}";
      Response qsbkHotPicDetailResponse = await Dio().get(url);

      print("getQsbkHotPicDetail::data::${qsbkHotPicDetailResponse.data}");
      mQsbkDetail = new QsbkDetail.fromJson(json.decode(qsbkHotPicDetailResponse.data));
      isLoading = false;
      setState(() {

      });
    } catch (e) {
      print(e);
      isLoading = false;
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
    return Center(
        child :
        mQsbkDetail == null ?
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
      new JokeDetailContentWidget().createItemWidget(context, widget.mQsbkHotPicItem, mQsbkDetail)
    );
  }
  
}

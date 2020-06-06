import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mode/DayWord.dart';
import 'package:flutter_app/mode/QsbkItem.dart';
import 'package:flutter_app/mode/QsbkList.dart';

import '../DayWordPage.dart';
import 'MarqueeWidget.dart';
import 'JokeItemWidget.dart';

class JokeWidget {
  Widget createWidget(BuildContext context, int jokeType){
    print("createItemWidget()::$jokeType");
    return new _InnerWidget(mJokeType: jokeType,);
  }
}

class _InnerWidget extends StatefulWidget {
  var mJokeType;
  _InnerWidget({Key key, this.mJokeType}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("createState()::$mJokeType");
    return new _InnerWidgetState();
  }
}

class _InnerWidgetState extends State<_InnerWidget> {
  var isLoadingQsbkHotPic = false;
  var mQsbkHotPicPageSize = 10;
  var mQsbkHotPicPage = 0;
  var mJokeType = 0;
  QsbkList mQsbkList;


  void getQsbkHotPic(String lastId) async {
    mJokeType = widget.mJokeType;
    print("getQsbkHotPic::isLoadingQsbkHotPic = $isLoadingQsbkHotPic");
    print("getQsbkHotPic::jokeType = $mJokeType");
    if(isLoadingQsbkHotPic){
      return;
    }
    isLoadingQsbkHotPic = true;
    try {
      String url = "http://zxltest.zicp.vip:51763/";
//      String url = "http://192.168.31.63:9090/";
      if (lastId.isEmpty) {
//        url = url + "test/qsbk/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize&joke_type=$mJokeType";
        url = url + "test/qsbk/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize&joke_type=$mJokeType";
      } else {
//        url = url + "test/qsbk/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize&last_id=$lastId&joke_type=$mJokeType";
        url =  url + "test/qsbk/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize&last_id=$lastId&joke_type=$mJokeType";
      }
      Response qsbkHotPicResponse = await Dio().get(url);
      QsbkList qsbkList = new QsbkList.fromJson(json.decode(qsbkHotPicResponse.data));

      print("page::$mQsbkHotPicPage::$isLoadingQsbkHotPic");

      if(qsbkList == null){
        print("mQsbkHotPicItemList::is null");
        isLoadingQsbkHotPic = false;
        return;
      }
      if(qsbkList.itemList == null){
        print("mQsbkHotPicItemList.itemList::is null");
        isLoadingQsbkHotPic = false;
        return;
      }
      if(qsbkList.itemList.isEmpty == null){
        print("mQsbkHotPicItemList.itemList::is isEmpty");
        isLoadingQsbkHotPic = false;
        return;
      }

      if(mQsbkList == null){
        mQsbkList = qsbkList;
      }else{
        mQsbkList.itemList.addAll(qsbkList.itemList);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQsbkHotPic("");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child :
        mQsbkList == null ?
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

              QsbkItem qsbkItem = mQsbkList.itemList.elementAt(index);

              if(index == mQsbkList.itemList.length - 1){
                getQsbkHotPic(qsbkItem.id);
              }

              print("item::index = " + "$index");
              print("item::authorImgUrl = " + qsbkItem.authorImgUrl);
              print("item::thumbImgUrl = " + qsbkItem.thumbImgUrl);
              print(qsbkItem.authorNickName + "---" + qsbkItem.content);
              return new JokeItemWidget().createItemWidget(context, qsbkItem);
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Container(height: 1.0, color: Colors.blue);
            },
            itemCount: mQsbkList.itemList.length)
    );
  }
}
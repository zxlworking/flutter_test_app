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
  QsbkHotPicItemList mQsbkHotPicItemList;


  void getQsbkHotPic() async {
    mJokeType = widget.mJokeType;
    print("getQsbkHotPic::isLoadingQsbkHotPic = $isLoadingQsbkHotPic");
    print("getQsbkHotPic::jokeType = $mJokeType");
    if(isLoadingQsbkHotPic){
      return;
    }
    isLoadingQsbkHotPic = true;
    try {
//      Response qsbkHotPicResponse = await Dio().get("http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize");
      Response qsbkHotPicResponse = await Dio().get("http://10.241.143.218:9090/test/qsbk/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize&joke_type=$mJokeType");
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQsbkHotPic();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
              print("item::authorImgUrl = " + qsbkHotPicItem.authorImgUrl);
              print("item::thumbImgUrl = " + qsbkHotPicItem.thumbImgUrl);
              print(qsbkHotPicItem.authorNickName + "---" + qsbkHotPicItem.content);
              return new JokeItemWidget().createItemWidget(context, qsbkHotPicItem);
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Container(height: 1.0, color: Colors.blue);
            },
            itemCount: mQsbkHotPicItemList.itemList.length)
    );
  }
}
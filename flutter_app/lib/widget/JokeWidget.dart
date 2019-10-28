
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mode/QsbkHotPicItem.dart';
import 'package:flutter_app/mode/QsbkHotPicItemList.dart';
import 'package:flutter_app/widget/BaseTabItemWidget.dart';

import 'QsbkHotPicItemWidget.dart';

class JokeWidget extends BaseTabItemWidget {
  JokeWidget(int index, String title) : super(index, title);

  State<StatefulWidget> customState() {
    return JokeWidgetState();
  }
}

class JokeWidgetState extends State {
  var isLoadingQsbkHotPic = false;
  var mQsbkHotPicPageSize = 10;
  var mQsbkHotPicPage = 0;

  QsbkHotPicItemList mQsbkHotPicItemList;

  void getQsbkHotPic() async {
    if(isLoadingQsbkHotPic){
      return;
    }
    isLoadingQsbkHotPic = true;
    try {
      Response qsbkHotPicResponse = await Dio().get("http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize");
//      Response qsbkHotPicResponse = await Dio().get("http://10.234.199.73:9090/test/qsbk_hot_pic/list?page=$mQsbkHotPicPage&page_size=$mQsbkHotPicPageSize");
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
    // TODO: implement build
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
              return new QsbkHotPicItemWidget().createItemWidget(context, qsbkHotPicItem);
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Container(height: 1.0, color: Colors.blue);
            },
            itemCount: mQsbkHotPicItemList.itemList.length)
    );
  }

}
import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mode/DayWord.dart';
import 'package:flutter_app/mode/JokeCommentList.dart';
import 'package:flutter_app/mode/QsbkItem.dart';
import 'package:flutter_app/mode/QsbkList.dart';

import '../DayWordPage.dart';
import 'MarqueeWidget.dart';
import 'JokeItemWidget.dart';

class JokeCommentWidget {
  Widget createWidget(BuildContext context, var jokeId, int commentType){
    print("createItemWidget()::$commentType");
    return new _InnerWidget(mJokeId : jokeId, mCommentType: commentType,);
  }
}

class _InnerWidget extends StatefulWidget {
  var mJokeId;
  var mCommentType;
  _InnerWidget({Key key, this.mJokeId, this.mCommentType}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("createState()::$mCommentType");
    return new _InnerWidgetState();
  }
}

class _InnerWidgetState extends State<_InnerWidget> {
  var isLoading = false;
  var mJokeCommentageSize = 10;
  var mJokeCommentPage = 0;
  var mCommentType = 0;
  JokeCommentList mJokeCommentList;


  void getJokeComment(String lastId) async {
    mCommentType = widget.mCommentType;
    print("getJokeComment::isLoading = $isLoading");
    print("getJokeComment::mJokeId = " + widget.mJokeId);
    print("getJokeComment::mCommentType = $mCommentType");
    if(isLoading){
      return;
    }
    isLoading = true;
    try {
      String jokeId = widget.mJokeId;
      String url = "http://zxltest.zicp.vip:51763/";
//      String url = "http://192.168.31.63:9090/";
      if (lastId.isEmpty) {
//        url = url + "test/qsbk/comment/list?page=$mJokeCommentPage&page_size=$mJokeCommentageSize&joke_id=$jokeId&comment_type=$mCommentType";
        url = url + "test/qsbk/comment/list?page=$mJokeCommentPage&page_size=$mJokeCommentageSize&joke_id=$jokeId&comment_type=$mCommentType";
      } else {
//        url = url + "test/qsbk/comment/list?page=$mJokeCommentPage&page_size=$mJokeCommentageSize&joke_id=$jokeId&comment_type=$mCommentType&last_id=$lastId";
        url =  url + "test/qsbk/comment/list?page=$mJokeCommentPage&page_size=$mJokeCommentageSize&joke_id=$jokeId&comment_type=$mCommentType&last_id=$lastId";
      }
      Response jokeCommentResponse = await Dio().get(url);
      JokeCommentList jokeCommentList = new JokeCommentList.fromJson(json.decode(jokeCommentResponse.data));

      print("page::$mJokeCommentPage::$mJokeCommentageSize");

      if(jokeCommentList == null){
        print("jokeCommentList::is null");
        isLoading = false;
        return;
      }
      if(jokeCommentList.itemList == null){
        print("jokeCommentList.itemList::is null");
        isLoading = false;
        return;
      }
      if(jokeCommentList.itemList.isEmpty == null){
        print("jokeCommentList.itemList::is isEmpty");
        isLoading = false;
        return;
      }

      if(mJokeCommentList == null){
        mJokeCommentList = jokeCommentList;
      }else{
        mJokeCommentList.itemList.addAll(jokeCommentList.itemList);
      }

      setState(() {
      });

      isLoading = false;
      mJokeCommentPage++;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJokeComment("");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child :
        mJokeCommentList == null ?
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

              JokeCommentItem jokeCommentItem = mJokeCommentList.itemList.elementAt(index);

              if(index == mJokeCommentList.itemList.length - 1){
                getJokeComment(jokeCommentItem.id);
              }

              print("item::index = " + "$index");
              print("item::authorImgUrl = " + jokeCommentItem.commentUserNickName);
              print("item::thumbImgUrl = " + jokeCommentItem.commentUserImg);
              print(jokeCommentItem.commentUserNickName + "---" + jokeCommentItem.commentUserContent);
              return new _JokeCommentContentWidget(jokeCommentItem);
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Container(height: 1.0, color: Colors.blue);
            },
            itemCount: mJokeCommentList.itemList.length)
    );
  }
}

class _JokeCommentContentWidget extends StatefulWidget {
  JokeCommentItem mJokeCommentItem;

  _JokeCommentContentWidget(this.mJokeCommentItem);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _JokeCommentContentState();
  }

}

class _JokeCommentContentState extends State<_JokeCommentContentWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
        children: <Widget>[
            _createAuthorInfoWidget(widget.mJokeCommentItem),
            _createContentWidget(widget.mJokeCommentItem),
        ]
    );
  }
}

Widget _createAuthorInfoWidget(JokeCommentItem jokeCommentItem){
  print("_createAuthorInfoWidget::${jokeCommentItem.commentUserGender}::${jokeCommentItem.commentUserAge}");

  String GENDER_WOMEN = "0";
  String GENDER_MEN = "1";

  String gender = '未知';
  if (jokeCommentItem.commentUserGender == GENDER_WOMEN) {
    gender = "女";
  } else if (jokeCommentItem.commentUserGender == GENDER_MEN) {
    gender = "男";
  }
  return Container(
    margin: EdgeInsets.all(8),
    color: Colors.blueGrey,
    child: Row(
        children:<Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Image.network(
              jokeCommentItem.commentUserImg, width:48, height:48, fit:BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Container(
                      child: Text(
                        "${jokeCommentItem.commentUserNickName}",
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),)
                  ],
                ),

                Row(
                  children: <Widget>[
                    Expanded(child: Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        "${jokeCommentItem.commentUserAge}岁 $gender",
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),)
                  ],
                ),

              ],
            ),
          ),
        ]
    ),
  );
}

Widget _createContentWidget(JokeCommentItem jokeCommentItem){
  return new Row(
      children:<Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
            padding: EdgeInsets.only(left: 8,right: 8),
            color: Colors.lime,
            child: Text(
              "${jokeCommentItem.commentUserContent}",
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic
              ),
            ),
          ),
        ),
      ]
  );
}
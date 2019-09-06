import 'package:flutter/material.dart';
import 'package:flutter_app/mode/QsbkHotPicItem.dart';

import '../HotPicJokeDetailPage.dart';

class QsbkHotPicDetailWidget{

  static const String GENDER_WOMEN = "articleGender womenIcon";
  static const String GENDER_MEN = "articleGender manIcon";

  Widget createItemWidget(QsbkHotPicItem qsbkHotPicItem){
    return
      new GestureDetector(
        child: new Column(
                  children: <Widget>[
                    _createAuthorInfoWidget(qsbkHotPicItem),
                    _createContentWidget(qsbkHotPicItem),
                    _createThumbWidget(qsbkHotPicItem),
                    _createVoteCommentWidget(qsbkHotPicItem)
                  ]
              )
      );
  }

  Widget _createAuthorInfoWidget(QsbkHotPicItem qsbkHotPicItem){
    print("_createAuthorInfoWidget::${qsbkHotPicItem.authorGender}::${qsbkHotPicItem.authorAge}");
    String gender = qsbkHotPicItem.authorGender == GENDER_WOMEN ? "女" : "男";
    return Container(
      margin: EdgeInsets.all(8),
      color: Colors.blueGrey,
      child: Row(
          children:<Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: Image.network(
                qsbkHotPicItem.authorImgUrl, width:48, height:48, fit:BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: Container(
                        child: Text(
                          "${qsbkHotPicItem.authorNickName}",
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            decoration: TextDecoration.none,
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
                          "${qsbkHotPicItem.authorAge}岁 $gender",
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            decoration: TextDecoration.none,
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

  Widget _createContentWidget(QsbkHotPicItem qsbkHotPicItem){
    return new Row(
        children:<Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
              padding: EdgeInsets.only(left: 8,right: 8),
              color: Colors.lime,
              child: Text(
                "${qsbkHotPicItem.content}",
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ]
    );
  }

  Widget _createThumbWidget(QsbkHotPicItem qsbkHotPicItem){
    if(qsbkHotPicItem.thumbImgUrl == null || qsbkHotPicItem.thumbImgUrl.isEmpty) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top:4, right: 8.0,bottom: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                qsbkHotPicItem.thumbImgUrl,fit:BoxFit.fitHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createVoteCommentWidget(QsbkHotPicItem qsbkHotPicItem){
    String intervalStr = "";
    if((qsbkHotPicItem.statsVoteContent != null && qsbkHotPicItem.statsVoteContent.isNotEmpty) &&
        (qsbkHotPicItem.statsCommentContent != null && qsbkHotPicItem.statsCommentContent.isNotEmpty)){
      intervalStr = " · ";
    }
    return Container(
      margin: EdgeInsets.fromLTRB(10,0,8,4),
      color: Colors.white70,
      child: Row(
        children: <Widget>[
          Text(
            //487 好笑 · 18 评论
            "${qsbkHotPicItem.statsVoteContent}" + intervalStr + "${qsbkHotPicItem.statsCommentContent}",
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.none
              )
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_app/mode/QsbkItem.dart';

import 'package:flutter_app/widget/JokeDetailPage.dart';

class JokeItemWidget{

  static const String GENDER_WOMEN = "0";
  static const String GENDER_MEN = "1";

  Widget createItemWidget(BuildContext context, QsbkItem qsbkItem){
    return
      new GestureDetector(
        child: new Column(
                  children: <Widget>[
                    _createAuthorInfoWidget(qsbkItem),
                    _createContentWidget(qsbkItem),
                    _createThumbWidget(qsbkItem),
                    _createVoteCommentWidget(qsbkItem)
                  ]
              ),
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return new JokeDetailPage(qsbkItem);
          }));
        }
      );
  }

  Widget _createAuthorInfoWidget(QsbkItem qsbkItem){
    print("_createAuthorInfoWidget::${qsbkItem.authorGender}::${qsbkItem.authorAge}");

    String gender = '未知';
    if (qsbkItem.authorGender == GENDER_WOMEN) {
      gender = "女";
    } else if (qsbkItem.authorGender == GENDER_MEN) {
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
                qsbkItem.authorImgUrl, width:48, height:48, fit:BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: Container(
                        child: Text(
                          "${qsbkItem.authorNickName}",
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
                          "${qsbkItem.authorAge}岁 $gender",
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

  Widget _createContentWidget(QsbkItem qsbkItem){
    return new Row(
        children:<Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
              padding: EdgeInsets.only(left: 8,right: 8),
              color: Colors.lime,
              child: Text(
                "${qsbkItem.content}",
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

  Widget _createThumbWidget(QsbkItem qsbkItem){
    if(qsbkItem.thumbImgUrl == null || qsbkItem.thumbImgUrl.isEmpty) {
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
                qsbkItem.thumbImgUrl,fit:BoxFit.fitHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createVoteCommentWidget(QsbkItem qsbkItem){
    String intervalStr = "";
    if((qsbkItem.statsVoteContent != null && qsbkItem.statsVoteContent.isNotEmpty) &&
        (qsbkItem.statsCommentContent != null && qsbkItem.statsCommentContent.isNotEmpty)){
      intervalStr = " · ";
    }
    return Container(
      margin: EdgeInsets.fromLTRB(10,0,8,4),
      color: Colors.white70,
      child: Row(
        children: <Widget>[
          Text(
            //487 好笑 · 18 评论
            "${qsbkItem.statsVoteContent}" + intervalStr + "${qsbkItem.statsCommentContent}",
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontStyle: FontStyle.italic
              )
          )
        ],
      ),
    );
  }
}
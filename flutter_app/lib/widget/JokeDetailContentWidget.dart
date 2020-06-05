import 'package:flutter/material.dart';
import 'package:flutter_app/mode/QsbkDetail.dart';
import 'package:flutter_app/mode/QsbkItem.dart';
import 'package:flutter_app/widget/JokeDetailPage.dart';

class JokeDetailContentWidget {

  static const String GENDER_WOMEN = "0";
  static const String GENDER_MEN = "1";

  Widget createItemWidget(BuildContext context, QsbkHotPicItem qsbkHotPicItem, QsbkDetail qsbkDetail){
    return
      new GestureDetector(
        child: new Column(
                  children: <Widget>[
                    _createAuthorInfoWidget(qsbkHotPicItem),
                    _createContentWidget(qsbkDetail),
                    _createThumbWidget(qsbkDetail)
                  ]
              ),
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return new JokeDetailPage(qsbkHotPicItem);
          }));
        }
      );
  }

  Widget _createAuthorInfoWidget(QsbkHotPicItem qsbkHotPicItem){
    print("_createAuthorInfoWidget::${qsbkHotPicItem.authorGender}::${qsbkHotPicItem.authorAge}");

    String gender = '未知';
    if (qsbkHotPicItem.authorGender == GENDER_WOMEN) {
      gender = "女";
    } else if (qsbkHotPicItem.authorGender == GENDER_MEN) {
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

  Widget _createContentWidget(QsbkDetail qsbkDetail){
    return new Row(
        children:<Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 4),
              padding: EdgeInsets.only(left: 8,right: 8),
              color: Colors.lime,
              child: Text(
                "${qsbkDetail.content}",
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

  Widget _createThumbWidget(QsbkDetail qsbkDetail){
    if(qsbkDetail.thumbImgUrl == null || qsbkDetail.thumbImgUrl.isEmpty) {
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
                qsbkDetail.thumbImgUrl,fit:BoxFit.fitHeight,
              )
            ],
          ),
        ),
      ),
    );
  }
}
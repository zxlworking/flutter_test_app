import 'package:flutter/material.dart';
import 'package:flutter_app/mode/QsbkHotPicItem.dart';

class QsbkHotPicItemWidget{

  static const String GENDER_WOMEN = "articleGender womenIcon";
  static const String GENDER_MEN = "articleGender manIcon";

  Widget createItemWidget(QsbkHotPicItem qsbkHotPicItem){
    return
      new Column(
          children: <Widget>[
            _createAuthorInfoWidget(qsbkHotPicItem),
            _createContentWidget(qsbkHotPicItem),
            _createThumbWidget(qsbkHotPicItem),
          ]
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
                    fontStyle: FontStyle.italic
                ),
              ),
            ),
          ),
        ]
    );
  }

  Widget _createThumbWidget(QsbkHotPicItem qsbkHotPicItem){
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top:4, right: 18.0,bottom: 8),
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
}
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/QsbkHotPicDetailWidget.dart';

import 'mode/QsbkHotPicItem.dart';

class HotPicJokeDetailPage extends StatelessWidget{

  //http://zxltest.zicp.vip:36619/test/qsbk_hot_pic/detail?hot_pic_id=199
  QsbkHotPicItem mQsbkHotPicItem;

  HotPicJokeDetailPage(QsbkHotPicItem qsbkHotPicItem) {
    print("DayWordPage()");
    mQsbkHotPicItem = qsbkHotPicItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(title:Text("详情")),
          ),
          SliverList(
            delegate: new SliverChildListDelegate(
                <Widget>[
                  new QsbkHotPicDetailWidget().createItemWidget(mQsbkHotPicItem)
                ]
            ),
          ),
        ],
      ),
    );
  }

}
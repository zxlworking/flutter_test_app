import 'package:flutter/material.dart';
import 'package:flutter_app/widget/QsbkHotPicDetailWidget.dart';
import 'package:flutter_app/widget/TabBarWidget.dart';

import 'mode/QsbkHotPicItem.dart';
import 'mode/TabItem.dart';

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
      appBar: AppBar(
        title: Text("tab title"),
      ),
      body: TabWidget(),
//      body: CustomScrollView(
//        slivers: <Widget>[
//          SliverAppBar(
//            flexibleSpace: FlexibleSpaceBar(title:Text("详情")),
//          ),
//          SliverList(
//            delegate: new SliverChildListDelegate(
//                <Widget>[
//                  new QsbkHotPicDetailWidget().createItemWidget(mQsbkHotPicItem)
//                ]
//            ),
//          ),
//        ],
//      ),
    );
  }


}

class TabWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabWidgetState();
  }
}

class TabWidgetState extends State<TabWidget> {
  TabWidgetState({this.currentTab, this.onSelectTab});

  //定义tab页基本数据结构
  final List<TabItem> NewsTabs = <TabItem>[
    new TabItem('金融','financial'),
    new TabItem('科技','technology'),
    new TabItem('医疗','medical'),
  ];

  final TabBarWidget currentTab;
  final ValueChanged<TabItem> onSelectTab;  //这个参数比较关键，仔细理解下，省了setState()调用的环节

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return Container(
//      child: Text("tab test"),
//    );
    return Row(
        children: NewsTabs.map((item){
          return GestureDetector(    //手势监听控件，用于监听各种手势
              child: Container(
                padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: Text(item.text,style: TextStyle(color: _colorTabMatching(item: item)),),
              ),
              onTap: ()=>onSelectTab(item,)
            //onSelectTab函数的使用非常巧妙，
            //相当于定义了一个接口，可操控当前控件以外的数据
          );
        }).toList()
    );
  }

  //定义tab被选中和没被选中的颜色样式
  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? Colors.black : Colors.grey;
  }

}

import 'package:flutter/material.dart';

import 'package:flutter_app/mode/TabItem.dart';

class TabBarWidget extends StatelessWidget {
  //https://www.jianshu.com/p/cefe49a0ab7f
    TabBarWidget({this.currentTab, this.onSelectTab});

    //定义tab页基本数据结构
    final List<TabItem> NewsTabs = <TabItem>[
//      new TabItem('金融','financial'),
//      new TabItem('科技','technology'),
//      new TabItem('医疗','medical'),
    ];

    final TabBarWidget currentTab;
    final ValueChanged<TabItem> onSelectTab;  //这个参数比较关键，仔细理解下，省了setState()调用的环节

    @override
    Widget build(BuildContext context) {
        return Row(
                children: NewsTabs.map((item){
        return GestureDetector(    //手势监听控件，用于监听各种手势
                child: Container(
                padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
                child: Text(item.title,style: TextStyle(color: _colorTabMatching(item: item)),),
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



import 'dart:ui' as prefix0;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/BaseTabItemWidget.dart';

class BaseTabWidget extends StatefulWidget {
  List<BaseTabItemWidget> mTabList;

  BaseTabWidget(List<BaseTabItemWidget> list) {
    mTabList = list;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BaseTabWidgetState();
  }
}

class BaseTabWidgetState extends State<BaseTabWidget> with SingleTickerProviderStateMixin {
  TabController mController;

  @override
  void initState() {
    super.initState();
    print("BaseTabWidgetState()::initState");
    mController = TabController(
      length: widget.mTabList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("BaseTabWidgetState::build::width = " + "${MediaQuery.of(context).size.width}");
    print("BaseTabWidgetState::build::widget.mTabList.length = " + "${widget.mTabList.length}");
    return Column(
      children: <Widget>[
        Container(
          color: new Color(0xfff4f5f6),
          height: 38.0,
          child: TabBar(
            isScrollable: false,
            //是否可以滚动
            controller: mController,
            labelColor: Colors.red,
            unselectedLabelColor: Color(0xff666666),
            labelStyle: TextStyle(fontSize: 16.0),
            tabs: widget.mTabList.map((item) {
              return Tab(
                child: Container(
                  width: MediaQuery.of(context).size.width / widget.mTabList.length / 2,
                  child: Center(child: Text(item.getTitle()),),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: mController,
            children: widget.mTabList.map((item) {
              print("BaseTabWidgetState()::TabBarView::index::${item.getIndex()}");
              return Stack(children: <Widget>[
                  Align(alignment:Alignment.topCenter,child: item,),
                ],);
            }).toList(),
          ),
        )
      ],
    );
  }
}
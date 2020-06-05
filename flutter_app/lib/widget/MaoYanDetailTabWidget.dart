import 'package:flutter/material.dart';
import 'package:flutter_app/widget/MaoYanDetailWidget.dart';

import 'BaseTabItemWidget.dart';
import 'BaseTabWidget.dart';

class MaoYanDetailTabWidget extends StatefulWidget {
  String mMovieId = '';

  MaoYanDetailTabWidget(String movieId) {
    mMovieId = movieId;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MaoYanDetailTabWidgetState();
  }
}

class MaoYanDetailTabWidgetState extends State<MaoYanDetailTabWidget>
    with AutomaticKeepAliveClientMixin {
  List<BaseTabItemWidget> mTabList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mTabList = [
      BaseTabItemWidget(1, "tab 1"),
      BaseTabItemWidget(2, "tab 2"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("MaoYanDetailTabWidget::build");
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: BaseTabWidget(mTabList),
    );
  }

  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


import 'package:flutter/material.dart';

class BaseTabItemWidget extends StatefulWidget {
  int mIndex = 0;
  String mTitle = '';

  BaseTabItemWidget(int index, String title) {
    mIndex = index;
    mTitle = title;
  }

  int getIndex() {
    return mIndex;
  }

  String getTitle() {
    return mTitle;
  }

  State<StatefulWidget> customState() {
    return BaseTabItemState();
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return customState();
  }
}

class BaseTabItemState extends State<BaseTabItemWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(widget.mTitle);
  }

}
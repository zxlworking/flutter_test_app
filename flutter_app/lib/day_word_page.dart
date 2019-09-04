import 'package:flutter/material.dart';

import 'mode/DayWord.dart';

class DayWordPage extends StatelessWidget{

  DayWord mDayWord;

  DayWordPage(DayWord dayWord) {
    print("DayWordPage()");
    mDayWord = dayWord;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(mDayWord.caption)
      ),
      body: Container(
        child: ContentPage(mDayWord),
      ),
    );
  }

}

class ContentPage extends StatelessWidget{

  DayWord mDayWord;

  ContentPage(DayWord dayWord) {
    print("DayWordPage()");
    mDayWord = dayWord;
  }

  @override
  Widget build(BuildContext context) {
    if(mDayWord.fenxiangImg == null || mDayWord.fenxiangImg.isEmpty) {
      return Container();
    }
    print("build::fenxiangImg = " + mDayWord.fenxiangImg);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top:4, right: 8.0,bottom: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                mDayWord.fenxiangImg,fit:BoxFit.fitHeight,
              )
            ],
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';

import 'mode/DayWord.dart';

class HotPicJokeDetailPage extends StatelessWidget{

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
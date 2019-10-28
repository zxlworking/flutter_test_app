
import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DayWordPage.dart';
import 'package:flutter_app/mode/DayWord.dart';

import 'MarqueeWidget.dart';

class DayWordAppBarWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DayWordAppBarState();
  }
}

class DayWordAppBarState extends State<DayWordAppBarWidget> {
  DayWord mDayWord;

  void getDayWOrd() async {
    print("getDayWOrd::start");
    try {
      DateTime now = DateTime.now();
      Response dayWordResponse = await Dio().get("http://open.iciba.com/dsapi/?date=${now.year}-${now.month}-${now.day}");
      mDayWord = new DayWord.fromJson(json.decode(dayWordResponse.data));

      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }

  void clickTitle(DayWord dayWord) {
    print("DayWordAppBarWidget::clickTitle");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new DayWordPage(mDayWord);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDayWOrd();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (
        mDayWord == null ?
        Text('电影')
            :
        GestureDetector(
          child: MarqueeWidget(
              Container(
                width: window.physicalSize.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${mDayWord.content}",
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                    Text(
                      "${mDayWord.note}",
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
              0.0,
              new Duration(seconds: 5),
              230.0
          ),
          onTap: () {
            clickTitle(mDayWord);
          },
        )
    );
  }

}
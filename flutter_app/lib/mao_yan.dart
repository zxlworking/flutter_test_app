import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/DayWordPage.dart';
import 'package:flutter_app/mode/DayWord.dart';
import 'package:flutter_app/mode/MovieInfoList.dart';
import 'package:flutter_app/widget/MarqueeWidget.dart';


void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "电影",
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: MainAppWidget(),
    );
  }

}

class MainAppWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainAppState();
  }
}

class MainAppState extends State<MainAppWidget> {
  MovieInfoList mMovieInfoList;
  DayWord mDayWord;

  var is_loading = false;

  var page_index = 0;
  var page_size = 10;

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

  void getMovieInfoList() async {
    print("getMovieInfoList::start");
    try {
      Response response = await Dio().get(
          "http://10.234.199.73:9090/test/maoyan/movie_list?page=${page_index}&page_size=${page_size}&movie_type=1");
      MovieInfoList tempMovieInfoList = new MovieInfoList.fromJson(
          json.decode(response.data));

      if (tempMovieInfoList.baseBean.code == 0) {
        if (mMovieInfoList == null) {
          mMovieInfoList = tempMovieInfoList;
        } else {
          mMovieInfoList.movieInfoList.addAll(tempMovieInfoList.movieInfoList);
        }
      } else {
        is_loading = false;
        return;
      }

      setState(() {

      });

      is_loading = false;
      page_index++;
    } catch (e) {
      print(e);
    }
  }

  void clickTitle(DayWord dayWord) {
    print("clickTitle");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new DayWordPage(mDayWord);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDayWOrd();
    getMovieInfoList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: mDayWord == null ?
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
      ),
      body: Center(
          child: mMovieInfoList == null ?
          Text("Loading...", style: TextStyle(color: Colors.blue))
              :
          ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                if (index == mMovieInfoList.movieInfoList.length - 1) {
                  getMovieInfoList();
                }

                print("item::index = " + "$index");
                print("item::movieTitle = " + mMovieInfoList.movieInfoList.elementAt(index).movieTitle);
                print("item::moviePosterUrl = " + mMovieInfoList.movieInfoList.elementAt(index).moviePosterUrl);

                return new Column(
                  children: <Widget>[
                    Image.network(mMovieInfoList.movieInfoList.elementAt(index).moviePosterUrl, fit: BoxFit.fitHeight,),
                    Text(mMovieInfoList.movieInfoList.elementAt(index).movieTitle),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return new Container(height: 1, color: Colors.blue,);
              },
              itemCount: mMovieInfoList.movieInfoList.length)
      ),
    );
  }

}
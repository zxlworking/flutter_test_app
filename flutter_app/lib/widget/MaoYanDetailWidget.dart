import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/mode/MovieDetailInfoList.dart';

class MaoYanDetailWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MaoYanDetailWidgetState();
  }
}

class MaoYanDetailWidgetState extends State {
  //http://10.234.199.73:9090/test/maoyan/movie_detail?movie_id=1218029

  MovieDetailInfoList movieDetailInfoList;

  var is_loading = false;

  void getMovieDetailInfoList() async {
    print("getMovieInfoList::start");
    try {
      Response response = await Dio().get(
          "http://10.234.199.73:9090/test/maoyan/movie_detail?movie_id=1218029");
      MovieDetailInfoList tempMovieDetailInfoList =
          new MovieDetailInfoList.fromJson(json.decode(response.data));
      movieDetailInfoList = tempMovieDetailInfoList;

      setState(() {});

      is_loading = false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieDetailInfoList();
  }

  @override
  Widget build(BuildContext context) {
    MovieDetailInfo movieDetailInfo;
    if (movieDetailInfoList != null && movieDetailInfoList.baseBean.code == 0) {
      movieDetailInfo = movieDetailInfoList.movieDetailInfoList.elementAt(0);
    }

    var itemWidth = (MediaQuery.of(context).size.width - 10 * 2) / 3;
    var itemHeight = itemWidth / 0.65;
    print("item::itemWidth = " + "$itemWidth");
    print("item::itemHeight = " + "$itemHeight");

    return movieDetailInfoList == null || movieDetailInfoList.baseBean.code != 0
        ? Center(
            child: Text("Loading...", style: TextStyle(color: Colors.blue)))
        : Container(
      alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.network(
                  movieDetailInfo.movieAvatarUrl,
                  width: itemWidth,
                  height: itemHeight,
                ),
                Column(
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(
                        movieDetailInfo.movieName,
                        style: TextStyle(
                            decoration: TextDecoration.none
                        ),
                      ),
                      Text(
                        movieDetailInfo.movieScoreContent,
                        style: TextStyle(
                            decoration: TextDecoration.none
                        ),
                      )
                    ],),
                  ],
                ),
              ],
            ),
          );
  }
}

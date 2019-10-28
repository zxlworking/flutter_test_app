import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/mode/MovieDetailInfoList.dart';

import 'BaseTabItemWidget.dart';

class MaoYanDetailWidget extends BaseTabItemWidget {
  String mMovieId = '';

  MaoYanDetailWidget(int index, String title, this.mMovieId)
      : super(index, title);

  State<StatefulWidget> customState() {
    // TODO: implement createState
    print("MaoYanDetailWidget::createState");
    return MaoYanDetailWidgetState();
  }
}

class MaoYanDetailWidgetState extends State<MaoYanDetailWidget> {
  //http://10.234.199.73:9090/test/maoyan/movie_detail?movie_id=1218029

  MovieDetailInfoList movieDetailInfoList;

  var is_loading = false;

  void getMovieDetailInfoList() async {
    print("MaoYanDetailWidget::getMovieInfoList::start");
    try {
      Response response = await Dio().get(
          "http://zxltest.zicp.vip:36619/test/maoyan/movie_detail?movie_id=${widget.mMovieId}");
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

    var itemWidth = (MediaQuery.of(context).size.width - 10 * 2) / 2;
    var itemHeight = itemWidth / 0.65;
    print("MaoYanDetailWidget::item::itemWidth = " + "$itemWidth");
    print("MaoYanDetailWidget::item::itemHeight = " + "$itemHeight");

    return movieDetailInfoList == null || movieDetailInfoList.baseBean.code != 0
        ? Center(
            child: Text("Loading...", style: TextStyle(color: Colors.blue)))
        : new CustomScrollView(
            shrinkWrap: true,
            // 内容
            slivers: <Widget>[
              new SliverPadding(
                padding: EdgeInsets.all(0),
                sliver: new SliverList(
                  delegate: new SliverChildListDelegate(
                    <Widget>[
                      Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Image.network(
                                      movieDetailInfo.movieAvatarUrl,
                                      width: itemWidth,
                                      height: itemHeight,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: itemWidth,
                                  height: itemHeight,
                                  padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            movieDetailInfo.movieName,
                                            style: TextStyle(decoration: TextDecoration.none, fontSize: 20, fontStyle: FontStyle.italic),
                                          ),
                                          Text(
                                            movieDetailInfo.movieEnName,
                                            style: TextStyle(decoration: TextDecoration.none, fontSize: 15, fontStyle: FontStyle.italic),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  movieDetailInfo.movieDuration,
                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 12),
                                                ),
                                                Text(
                                                  movieDetailInfo.movieCategory,
                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 12),
                                                ),
                                                Text(
                                                  movieDetailInfo.movieReleaseInfo,
                                                  style: TextStyle(decoration: TextDecoration.none, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            movieDetailInfo.movieScoreContent,
                                            style: TextStyle(decoration: TextDecoration.none, fontSize: 15, color: Colors.orange),
                                          ),
                                          Text(
                                            movieDetailInfo.movieBoxValueContent + movieDetailInfo.movieBoxUnitContent,
                                            style: TextStyle(decoration: TextDecoration.none, fontSize: 15, color: Colors.lightGreen),
                                          ),
                                          Text(
                                            (movieDetailInfo.movieStatsPeopleCountContent + movieDetailInfo.movieStatsPeopleCountUnitContent).length == 0 ? ((movieDetailInfo.movieStatsPeopleCountContent + movieDetailInfo.movieStatsPeopleCountUnitContent)) : ((movieDetailInfo.movieStatsPeopleCountContent + movieDetailInfo.movieStatsPeopleCountUnitContent) + "人评论"),
                                            style: TextStyle(decoration: TextDecoration.none, fontSize: 15, color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                              child: Text(
                                movieDetailInfo.introduceContent,
                                style: TextStyle(decoration: TextDecoration.none, fontSize: 15, color: Colors.blueGrey),
                              ),
                            ),
                          ],)
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

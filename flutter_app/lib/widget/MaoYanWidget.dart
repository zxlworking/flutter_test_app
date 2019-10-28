import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/mode/MovieInfoList.dart';
import 'package:flutter_app/widget/BaseTabItemWidget.dart';
import 'package:flutter_app/widget/MaoYanDetailTabWidget.dart';

class MaoYanWidget extends BaseTabItemWidget {
  MaoYanWidget(int index, String title) : super(index, title);

  State<StatefulWidget> customState() {
    return MaoYanWidgetState();
  }
}

class MaoYanWidgetState extends State {
  MovieInfoList mMovieInfoList;

  var is_loading = false;

  var page_index = 0;
  var page_size = 10;

  void getMovieInfoList() async {
    print("MaoYanWidget::getMovieInfoList::start");
    try {
      Response response = await Dio().get(
          "http://zxltest.zicp.vip:36619/test/maoyan/movie_list?page=${page_index}&page_size=${page_size}&movie_type=1");
      MovieInfoList tempMovieInfoList =
          new MovieInfoList.fromJson(json.decode(response.data));

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

      setState(() {});

      is_loading = false;
      page_index++;
    } catch (e) {
      print(e);
    }
  }

  void clickItem(MovieInfo movieInfo) {
    print("MaoYanWidget::clickItem");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new MaoYanDetailTabWidget(movieInfo.movieId);
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("MaoYanWidget::initState");
    getMovieInfoList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: mMovieInfoList == null
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new MaterialButton(
                    child: Text(
                  'loading...',
                  style: TextStyle(color: Colors.blue),
                )),
              ],
            ))
          : GridView.builder(
              padding: EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                if (index == mMovieInfoList.movieInfoList.length - 1) {
                  print("MaoYanWidget::load more");
                  getMovieInfoList();
                }

                print("MaoYanWidget::item::index = " + "$index");
                print("MaoYanWidget::item::movieTitle = " +
                    mMovieInfoList.movieInfoList.elementAt(index).movieTitle);
                print("item::moviePosterUrl = " +
                    mMovieInfoList.movieInfoList
                        .elementAt(index)
                        .moviePosterUrl);

                var itemWidth =
                    (MediaQuery.of(context).size.width - 10 * 3) / 2;
                var itemHeight = itemWidth / 0.65;
                print("MaoYanWidget::item::itemWidth = " + "$itemWidth");
                print("MaoYanWidget::item::itemHeight = " + "$itemHeight");

                MovieInfo movieInfo = mMovieInfoList.movieInfoList.elementAt(index);

                return GestureDetector(
                  child: new Column(
                    children: <Widget>[
                      Image.network(
                        movieInfo.moviePosterUrl +
                            "@${(itemWidth * 1.5).toInt()}w_${(itemHeight * 1.5).toInt()}h_1e_1c",
                        fit: BoxFit.fill,
                        width: itemWidth,
                        height: itemHeight,
                      ),
                      Text(movieInfo.movieTitle),
                    ],
                  ),
                  onTap: (){
                    clickItem(movieInfo);
                  },
                );
              },
              itemCount: mMovieInfoList.movieInfoList.length),
    );
  }
}

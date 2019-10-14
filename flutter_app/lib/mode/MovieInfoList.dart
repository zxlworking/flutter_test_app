class MovieInfoList {
  BaseBean baseBean;
  List<MovieInfo> movieInfoList;

  MovieInfoList({this.baseBean, this.movieInfoList});

  MovieInfoList.fromJson(Map<String, dynamic> json) {
    baseBean = json['BaseBean'] != null
        ? new BaseBean.fromJson(json['BaseBean'])
        : null;
    if (json['MovieInfoList'] != null) {
      movieInfoList = new List<MovieInfo>();
      json['MovieInfoList'].forEach((v) {
        movieInfoList.add(new MovieInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.baseBean != null) {
      data['BaseBean'] = this.baseBean.toJson();
    }
    if (this.movieInfoList != null) {
      data['MovieInfoList'] =
          this.movieInfoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BaseBean {
  int code;
  String desc;

  BaseBean({this.code, this.desc});

  BaseBean.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    desc = json['Desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Desc'] = this.desc;
    return data;
  }
}

class MovieInfo {
  String id;
  String movieId;
  String movieTitle;
  String moviePosterUrl;
  String movieDetailUrl;
  int movieType;

  MovieInfo(
      {this.id,
        this.movieId,
        this.movieTitle,
        this.moviePosterUrl,
        this.movieDetailUrl,
        this.movieType});

  MovieInfo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    movieId = json['MovieId'];
    movieTitle = json['MovieTitle'];
    moviePosterUrl = json['MoviePosterUrl'];
    movieDetailUrl = json['MovieDetailUrl'];
    movieType = json['MovieType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['MovieId'] = this.movieId;
    data['MovieTitle'] = this.movieTitle;
    data['MoviePosterUrl'] = this.moviePosterUrl;
    data['MovieDetailUrl'] = this.movieDetailUrl;
    data['MovieType'] = this.movieType;
    return data;
  }
}
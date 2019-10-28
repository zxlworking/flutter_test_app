class MovieDetailInfoList {
  BaseBean baseBean;
  List<MovieDetailInfo> movieDetailInfoList;

  MovieDetailInfoList({this.baseBean, this.movieDetailInfoList});

  MovieDetailInfoList.fromJson(Map<String, dynamic> json) {
    baseBean = json['BaseBean'] != null
        ? new BaseBean.fromJson(json['BaseBean'])
        : null;
    if (json['MovieDetailInfoList'] != null) {
      movieDetailInfoList = new List<MovieDetailInfo>();
      json['MovieDetailInfoList'].forEach((v) {
        movieDetailInfoList.add(new MovieDetailInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.baseBean != null) {
      data['BaseBean'] = this.baseBean.toJson();
    }
    if (this.movieDetailInfoList != null) {
      data['MovieDetailInfoList'] =
          this.movieDetailInfoList.map((v) => v.toJson()).toList();
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

class MovieDetailInfo {
  String id;
  String movieId;
  String movieAvatarUrl;
  String movieName;
  String movieEnName;
  String movieCategory;
  String movieDuration;
  String movieReleaseInfo;
  String movieReleaseTime;
  String movieReleaseArea;
  String movieScoreContent;
  String movieStatsPeopleCountContent;
  String movieStatsPeopleCountUnitContent;
  String movieBoxValueContent;
  String movieBoxUnitContent;
  String introduceContent;

  MovieDetailInfo(
      {this.id,
        this.movieId,
        this.movieAvatarUrl,
        this.movieName,
        this.movieEnName,
        this.movieCategory,
        this.movieDuration,
        this.movieReleaseInfo,
        this.movieReleaseTime,
        this.movieReleaseArea,
        this.movieScoreContent,
        this.movieStatsPeopleCountContent,
        this.movieStatsPeopleCountUnitContent,
        this.movieBoxValueContent,
        this.movieBoxUnitContent,
        this.introduceContent});

  MovieDetailInfo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    movieId = json['MovieId'];
    movieAvatarUrl = json['MovieAvatarUrl'];
    movieName = json['MovieName'];
    movieEnName = json['MovieEnName'];
    movieCategory = json['MovieCategory'];
    movieDuration = json['MovieDuration'];
    movieReleaseInfo = json['MovieReleaseInfo'];
    movieReleaseTime = json['MovieReleaseTime'];
    movieReleaseArea = json['MovieReleaseArea'];
    movieScoreContent = json['MovieScoreContent'];
    movieStatsPeopleCountContent = json['MovieStatsPeopleCountContent'];
    movieStatsPeopleCountUnitContent = json['MovieStatsPeopleCountUnitContent'];
    movieBoxValueContent = json['MovieBoxValueContent'];
    movieBoxUnitContent = json['MovieBoxUnitContent'];
    introduceContent = json['IntroduceContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['MovieId'] = this.movieId;
    data['MovieAvatarUrl'] = this.movieAvatarUrl;
    data['MovieName'] = this.movieName;
    data['MovieEnName'] = this.movieEnName;
    data['MovieCategory'] = this.movieCategory;
    data['MovieDuration'] = this.movieDuration;
    data['MovieReleaseInfo'] = this.movieReleaseInfo;
    data['MovieReleaseTime'] = this.movieReleaseTime;
    data['MovieReleaseArea'] = this.movieReleaseArea;
    data['MovieScoreContent'] = this.movieScoreContent;
    data['MovieStatsPeopleCountContent'] = this.movieStatsPeopleCountContent;
    data['MovieStatsPeopleCountUnitContent'] =
        this.movieStatsPeopleCountUnitContent;
    data['MovieBoxValueContent'] = this.movieBoxValueContent;
    data['MovieBoxUnitContent'] = this.movieBoxUnitContent;
    data['IntroduceContent'] = this.introduceContent;
    return data;
  }
}
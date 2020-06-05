class QsbkDetail {
  String id;
  String jokeId;
  String articleId;
  String statsTime;
  String content;
  String thumbImgUrl;

  QsbkDetail(
      {this.id,
        this.jokeId,
        this.articleId,
        this.statsTime,
        this.content,
        this.thumbImgUrl});

  QsbkDetail.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    jokeId = json['JokeId'];
    articleId = json['ArticleId'];
    statsTime = json['StatsTime'];
    content = json['Content'];
    thumbImgUrl = json['ThumbImgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['JokeId'] = this.jokeId;
    data['ArticleId'] = this.articleId;
    data['StatsTime'] = this.statsTime;
    data['Content'] = this.content;
    data['ThumbImgUrl'] = this.thumbImgUrl;
    return data;
  }
}
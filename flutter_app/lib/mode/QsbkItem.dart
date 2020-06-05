class QsbkHotPicItem {
  String id;
  String authorNickName;
  String authorGender;
  String authorAge;
  String authorImgUrl;
  String content;
  String thumbImgUrl;
  String statsVoteContent;
  String statsCommentContent;
  String statsCommentDetailUrl;
  String md5;

  QsbkHotPicItem(
      {this.id,
        this.authorNickName,
        this.authorGender,
        this.authorAge,
        this.authorImgUrl,
        this.content,
        this.thumbImgUrl,
        this.statsVoteContent,
        this.statsCommentContent,
        this.statsCommentDetailUrl,
        this.md5});

  QsbkHotPicItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    authorNickName = json['AuthorNickName'];
    authorGender = json['AuthorGender'];
    authorAge = json['AuthorAge'];
    authorImgUrl = json['AuthorImgUrl'];
    content = json['Content'];
    thumbImgUrl = json['ThumbImgUrl'];
    statsVoteContent = json['StatsVoteContent'];
    statsCommentContent = json['StatsCommentContent'];
    statsCommentDetailUrl = json['StatsCommentDetailUrl'];
    md5 = json['Md5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['AuthorNickName'] = this.authorNickName;
    data['AuthorGender'] = this.authorGender;
    data['AuthorAge'] = this.authorAge;
    data['AuthorImgUrl'] = this.authorImgUrl;
    data['Content'] = this.content;
    data['ThumbImgUrl'] = this.thumbImgUrl;
    data['StatsVoteContent'] = this.statsVoteContent;
    data['StatsCommentContent'] = this.statsCommentContent;
    data['StatsCommentDetailUrl'] = this.statsCommentDetailUrl;
    data['Md5'] = this.md5;
    return data;
  }
}
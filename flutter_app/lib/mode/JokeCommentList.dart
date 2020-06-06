class JokeCommentList {
  List<JokeCommentItem> itemList;

  JokeCommentList({this.itemList});

  JokeCommentList.fromJson(Map<String, dynamic> json) {
    if (json['ItemList'] != null) {
      itemList = new List<JokeCommentItem>();
      json['ItemList'].forEach((v) {
        itemList.add(new JokeCommentItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemList != null) {
      data['ItemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JokeCommentItem {
  String id;
  String jokeId;
  String articleId;
  String commentUserId;
  String commentUserImg;
  String commentUserNickName;
  String commentUserGender;
  String commentUserAge;
  String commentUserContent;
  String commentType;

  JokeCommentItem(
      {this.id,
        this.jokeId,
        this.articleId,
        this.commentUserId,
        this.commentUserImg,
        this.commentUserNickName,
        this.commentUserGender,
        this.commentUserAge,
        this.commentUserContent,
        this.commentType});

  JokeCommentItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    jokeId = json['JokeId'];
    articleId = json['ArticleId'];
    commentUserId = json['CommentUserId'];
    commentUserImg = json['CommentUserImg'];
    commentUserNickName = json['CommentUserNickName'];
    commentUserGender = json['CommentUserGender'];
    commentUserAge = json['CommentUserAge'];
    commentUserContent = json['CommentUserContent'];
    commentType = json['CommentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['JokeId'] = this.jokeId;
    data['ArticleId'] = this.articleId;
    data['CommentUserId'] = this.commentUserId;
    data['CommentUserImg'] = this.commentUserImg;
    data['CommentUserNickName'] = this.commentUserNickName;
    data['CommentUserGender'] = this.commentUserGender;
    data['CommentUserAge'] = this.commentUserAge;
    data['CommentUserContent'] = this.commentUserContent;
    data['CommentType'] = this.commentType;
    return data;
  }
}

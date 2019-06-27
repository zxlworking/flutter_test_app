class DayWord {
  String sid;
  String tts;
  String content;
  String note;
  String love;
  String translation;
  String picture;
  String picture2;
  String caption;
  String dateline;
  String sPv;
  String spPv;
  List<Tags> tags;
  String fenxiangImg;

  DayWord(
      {this.sid,
        this.tts,
        this.content,
        this.note,
        this.love,
        this.translation,
        this.picture,
        this.picture2,
        this.caption,
        this.dateline,
        this.sPv,
        this.spPv,
        this.tags,
        this.fenxiangImg});

  DayWord.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    tts = json['tts'];
    content = json['content'];
    note = json['note'];
    love = json['love'];
    translation = json['translation'];
    picture = json['picture'];
    picture2 = json['picture2'];
    caption = json['caption'];
    dateline = json['dateline'];
    sPv = json['s_pv'];
    spPv = json['sp_pv'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    fenxiangImg = json['fenxiang_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['tts'] = this.tts;
    data['content'] = this.content;
    data['note'] = this.note;
    data['love'] = this.love;
    data['translation'] = this.translation;
    data['picture'] = this.picture;
    data['picture2'] = this.picture2;
    data['caption'] = this.caption;
    data['dateline'] = this.dateline;
    data['s_pv'] = this.sPv;
    data['sp_pv'] = this.spPv;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['fenxiang_img'] = this.fenxiangImg;
    return data;
  }
}

class Tags {
  String id;
  String name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
import 'QsbkHotPicItem.dart';

class QsbkHotPicItemList {
  List<QsbkHotPicItem> itemList;

  QsbkHotPicItemList({this.itemList});

  QsbkHotPicItemList.fromJson(Map<String, dynamic> json) {
    if (json['ItemList'] != null) {
      itemList = new List<QsbkHotPicItem>();
      json['ItemList'].forEach((v) {
        itemList.add(new QsbkHotPicItem.fromJson(v));
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
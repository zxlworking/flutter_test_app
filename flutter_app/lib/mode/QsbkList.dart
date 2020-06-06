import 'package:flutter_app/mode/QsbkItem.dart';

class QsbkList {
  List<QsbkItem> itemList;

  QsbkList({this.itemList});

  QsbkList.fromJson(Map<String, dynamic> json) {
    if (json['ItemList'] != null) {
      itemList = new List<QsbkItem>();
      json['ItemList'].forEach((v) {
        itemList.add(new QsbkItem.fromJson(v));
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
// Project imports:
import 'package:alanis/export.dart';

class OneToOneChatResponseModel {
  List<OneToOneChatDataModel> list;
  String copyrighths;

  OneToOneChatResponseModel({this.list, this.copyrighths});

  OneToOneChatResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list.add(new OneToOneChatDataModel.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

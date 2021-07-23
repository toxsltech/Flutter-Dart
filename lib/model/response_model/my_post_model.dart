// Project imports:
import 'package:alanis/export.dart';
import 'package:alanis/model/response_model/postlist_model.dart';

class MyPostModel {
  List<PostList> list;
  Meta mMeta;
  String copyrighths;

  MyPostModel({this.list, this.mMeta, this.copyrighths});

  MyPostModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list.add(new PostList.fromJson(v));
      });
    }
    mMeta = json['_meta'] != null ? new Meta.fromJson(json['_meta']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    if (this.mMeta != null) {
      data['_meta'] = this.mMeta.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

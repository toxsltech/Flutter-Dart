// Project imports:
import 'package:alanis/export.dart';

class LikeDataModel {
  String count;
  String message;
  ShortDetail detail;
  String copyrighths;

  LikeDataModel({this.count, this.message, this.detail, this.copyrighths});

  LikeDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    message = json['message'];
    detail = json['detail'] != null
        ? new ShortDetail.fromJson(json['detail'])
        : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['message'] = this.message;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

// Project imports:
import 'package:alanis/export.dart';

class FollowRequest {
  String message;
  ShortDetail detail;
  String copyrighths;

  FollowRequest({this.message, this.detail, this.copyrighths});

  FollowRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    detail = json['detail'] != null
        ? new ShortDetail.fromJson(json['detail'])
        : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

// Project imports:
import 'package:alanis/export.dart';

class CheckUserModel {
  Detail detail;
  String copyrighths;

  CheckUserModel({this.detail, this.copyrighths});

  CheckUserModel.fromJson(Map<String, dynamic> json) {
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

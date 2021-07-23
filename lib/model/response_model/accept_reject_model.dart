// Project imports:
import 'package:alanis/export.dart';

class AcceptRejectModel {
  String message;
  Detail detail;
  String copyrighths;

  AcceptRejectModel({this.message, this.detail, this.copyrighths});

  AcceptRejectModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
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

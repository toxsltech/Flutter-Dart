// Project imports:
import 'package:alanis/export.dart';

class SubmitRisingModel {
  String error;
  String message;
  Detail detail;
  String copyrighths;

  SubmitRisingModel({this.error, this.message, this.detail, this.copyrighths});

  SubmitRisingModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

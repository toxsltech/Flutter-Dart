// Project imports:
import 'package:alanis/export.dart';

class SendMessageResponseModel {
  SendMessageDataModel detail;
  String message;
  String copyrighths;

  SendMessageResponseModel({this.detail, this.message, this.copyrighths});

  SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? new SendMessageDataModel.fromJson(json['detail'])
        : null;
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['message'] = this.message;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

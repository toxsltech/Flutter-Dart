// Project imports:
import 'package:alanis/export.dart';

class LoginResponseModel {
  String message;
  String accessToken;
  LoginDataModel detail;
  String copyrighths;

  LoginResponseModel(
      {this.message, this.accessToken, this.detail, this.copyrighths});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access-token'];
    detail = json['detail'] != null
        ? new LoginDataModel.fromJson(json['detail'])
        : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['access-token'] = this.accessToken;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

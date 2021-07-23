// Project imports:
import 'package:alanis/model/response_model/login_data_model.dart';

class UpdateResponseModel {
  LoginDataModel detail;
  String copyrighths;

  UpdateResponseModel({this.detail, this.copyrighths});

  UpdateResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null
        ? new LoginDataModel.fromJson(json['detail'])
        : null;
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

// Project imports:
import 'detail_model.dart';

class CoverPhotoModel {
  Detail detail;
  String copyrighths;

  CoverPhotoModel({this.detail, this.copyrighths});

  CoverPhotoModel.fromJson(Map<String, dynamic> json) {
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

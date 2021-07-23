// Project imports:
import 'package:alanis/export.dart';
import 'file_model.dart';

class MyPostResponseModel {
  List<MyPostResponseModelList> list;
  Meta mMeta;
  String copyrighths;

  MyPostResponseModel({this.list, this.mMeta, this.copyrighths});

  MyPostResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list.add(new MyPostResponseModelList.fromJson(v));
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

class MyPostResponseModelList {
  int id;
  String title;
  String description;
  int stateId;
  int typeId;
  String createdOn;
  int createdById;
  File file;
  CreatedBy createdBy;

  MyPostResponseModelList(
      {this.id,
      this.title,
      this.description,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById,
      this.file,
      this.createdBy});

  MyPostResponseModelList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    file = json['File'] != null ? new File.fromJson(json['File']) : null;
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    return data;
  }
}

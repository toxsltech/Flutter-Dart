// Project imports:
import 'file_model.dart';

class AddPostModel {
  String message;
  AddPostDetail detail;
  String copyrighths;

  AddPostModel({this.message, this.detail, this.copyrighths});

  AddPostModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    detail = json['detail'] != null
        ? new AddPostDetail.fromJson(json['detail'])
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

class AddPostDetail {
  int id;
  String title;
  String tagId;
  String description;
  int stateId;
  var typeId;
  String createdOn;
  int createdById;
  File file;
  int roleId;
  String countPost;

  AddPostDetail(
      {this.id,
      this.title,
      this.tagId,
      this.description,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById,
      this.file,
      this.roleId,
      this.countPost});

  AddPostDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tagId = json['tag_id'];
    description = json['description'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    file = json['File'] != null ? new File.fromJson(json['File']) : null;
    if (json['role_id'] != null) roleId = json['role_id'];
    if (json['post_count'] != null) countPost = json['post_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tag_id'] = this.tagId;
    data['description'] = this.description;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    if (this.roleId != null) {
      data['role_id'] = this.roleId;
    }
    if (this.countPost != null) {
      data['post_count'] = this.countPost;
    }
    return data;
  }
}

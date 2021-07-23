// Project imports:
import 'package:alanis/export.dart';
import 'file_model.dart';
import 'tags_model.dart';

class PostList {
  int id;
  String title;
  String description;
  int stateId;
  String tagId;
  List<Tags> tags;
  int typeId;
  String createdOn;
  int createdById;
  int likes;
  String comments;
  bool checkLike;
  File file;
  Detail createdBy;

  PostList(
      {this.id,
      this.title,
      this.description,
      this.stateId,
      this.tagId,
      this.tags,
      this.typeId,
      this.createdOn,
      this.createdById,
      this.likes,
      this.comments,
      this.checkLike,
      this.file,
      this.createdBy});

  PostList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    stateId = json['state_id'];
    tagId = json['tag_id'];
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    likes = json['likes'];
    comments = json['comments'];
    checkLike = json['check_like'];
    file = json['File'] != null ? new File.fromJson(json['File']) : null;
    createdBy = json['createdBy'] != null
        ? new Detail.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['state_id'] = this.stateId;
    data['tag_id'] = this.tagId;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['likes'] = this.likes;
    data['comments'] = this.comments;
    data['check_like'] = this.checkLike;
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    return data;
  }
}

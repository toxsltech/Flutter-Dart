// Project imports:
import 'package:alanis/export.dart';

class ShortDetail {
  int id;
  var modelId;
  String modelType;
  int stateId;
  var typeId;
  String createdOn;
  int createdById;
  ToUser toUser;
  CreatedBy createdBy;
  String comment;

  ShortDetail(
      {this.id,
      this.modelId,
      this.modelType,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById,
      this.toUser,
      this.comment,
      this.createdBy});

  ShortDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    modelType = json['model_type'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    if (json['comment'] != null) {
      comment = json['comment'];
    }
    toUser =
        json['ToUser'] != null ? new ToUser.fromJson(json['ToUser']) : null;
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['model_type'] = this.modelType;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    if (this.toUser != null) {
      data['ToUser'] = this.toUser.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    if (this.comment != null) {
      data['comment'] = this.comment;
    }
    return data;
  }
}

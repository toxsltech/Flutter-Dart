// Project imports:
import 'createdby_model.dart';

class CommentList {
  int id;
  int modelId;
  String comment;
  String modelType;
  int stateId;
  int typeId;
  var createdOn;
  int createdById;
  CreatedBy createdBy;
  bool like;

  CommentList(
      {this.id,
      this.modelId,
      this.comment,
      this.modelType,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById,
      this.like,
      this.createdBy});

  CommentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['model_id'];
    comment = json['comment'];
    modelType = json['model_type'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    like = json['like'];
    createdBy = json['createdBy'] != null
        ? new CreatedBy.fromJson(json['createdBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_id'] = this.modelId;
    data['comment'] = this.comment;
    data['model_type'] = this.modelType;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['like'] = this.like;
    data['created_by_id'] = this.createdById;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    return data;
  }
}

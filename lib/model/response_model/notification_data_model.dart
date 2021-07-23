class NotificationData {
  int id;
  String title;
  Null description;
  int modelId;
  String modelType;
  String controller;
  String action;
  int isRead;
  int stateId;
  int typeId;
  String createdOn;
  int toUserId;
  int createdById;

  NotificationData(
      {this.id,
      this.title,
      this.description,
      this.modelId,
      this.controller,
      this.action,
      this.modelType,
      this.isRead,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.toUserId,
      this.createdById});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    modelId = json['model_id'];
    modelType = json['model_type'];
    isRead = json['is_read'];
    controller = json['controller'];
    action = json['action'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    toUserId = json['to_user_id'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['model_id'] = this.modelId;
    data['model_type'] = this.modelType;
    data['is_read'] = this.isRead;
    data['controller'] = this.controller;
    data['action'] = this.action;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['to_user_id'] = this.toUserId;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

class ChatLikeDataModel {
  ChatList detail;
  String message;
  String copyrighths;

  ChatLikeDataModel({this.detail, this.message, this.copyrighths});

  ChatLikeDataModel.fromJson(Map<String, dynamic> json) {
    detail =
        json['detail'] != null ? new ChatList.fromJson(json['detail']) : null;
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

class ChatList {
  int id;
  String modelType;
  String chatId;
  String modelId;
  int stateId;
  Null typeId;
  String createdOn;
  int createdById;

  ChatList(
      {this.id,
      this.modelType,
      this.chatId,
      this.modelId,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById});

  ChatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    chatId = json['chat_id'];
    modelId = json['model_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['chat_id'] = this.chatId;
    data['model_id'] = this.modelId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

class OneToOneChatDataModel {
  var id;
  var message;
  var users;
  var fromId;
  var toId;
  var readers;
  bool checkLike;
  var groupId;
  var createdOn;
  var isRead;
  var stateId;
  var fromUserProfileFile;
  var toUserProfileFile;
  var typeId;
  var sendOn;

  OneToOneChatDataModel(
      {this.id,
      this.message,
      this.users,
      this.fromId,
      this.toId,
      this.readers,
      this.checkLike,
      this.groupId,
      this.createdOn,
      this.isRead,
      this.stateId,
      this.fromUserProfileFile,
      this.toUserProfileFile,
      this.typeId,
      this.sendOn});

  OneToOneChatDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    users = json['users'];
    fromId = json['from_id'];
    toId = json['to_id'];
    readers = json['readers'];
    checkLike = json['check_like'];
    groupId = json['group_id'];
    createdOn = json['created_on'];
    isRead = json['is_read'];
    stateId = json['state_id'];
    fromUserProfileFile = json['from_user_profile_file'];
    toUserProfileFile = json['to_user_profile_file'];
    typeId = json['type_id'];
    sendOn = json['send_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['users'] = this.users;
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    data['readers'] = this.readers;
    data['check_like'] = this.checkLike;
    data['group_id'] = this.groupId;
    data['created_on'] = this.createdOn;
    data['is_read'] = this.isRead;
    data['state_id'] = this.stateId;
    data['from_user_profile_file'] = this.fromUserProfileFile;
    data['to_user_profile_file'] = this.toUserProfileFile;
    data['type_id'] = this.typeId;
    data['send_on'] = this.sendOn;
    return data;
  }
}

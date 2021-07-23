// Project imports:
import 'package:alanis/export.dart';

class NotificationSettingModel {
  Result result;
  String copyrighths;

  NotificationSettingModel({this.result, this.copyrighths});

  NotificationSettingModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

class Result {
  int id;
  String fullName;
  Null firstName;
  Null lastName;
  String email;
  String dateOfBirth;
  int gender;
  String contactNo;
  String country;
  String language;
  String profileFile;
  String coverProfile;
  Null tos;
  String shortDescription;
  int roleId;
  int stateId;
  int typeId;
  String timezone;
  String createdOn;
  int createdById;
  bool checkRisingDetail;
  bool checkProfessionalDetail;
  String countPost;
  int label;
  Null checkFollowStatus;
  String countRequest;
  String notificationCount;
  int followerCount;
  int followingCount;
  int isFollow;
  int isPost;
  int isReply;
  RisingDetail risingDetail;

  Result(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.contactNo,
      this.country,
      this.language,
      this.profileFile,
      this.coverProfile,
      this.tos,
      this.shortDescription,
      this.roleId,
      this.stateId,
      this.typeId,
      this.timezone,
      this.createdOn,
      this.createdById,
      this.checkRisingDetail,
      this.checkProfessionalDetail,
      this.countPost,
      this.label,
      this.checkFollowStatus,
      this.countRequest,
      this.notificationCount,
      this.followerCount,
      this.followingCount,
      this.isFollow,
      this.isPost,
      this.isReply,
      this.risingDetail});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    contactNo = json['contact_no'];
    country = json['country'];
    language = json['language'];
    profileFile = json['profile_file'];
    coverProfile = json['cover_profile'];
    tos = json['tos'];
    shortDescription = json['short_description'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    checkRisingDetail = json['check_rising_detail'];
    checkProfessionalDetail = json['check_professional_detail'];
    countPost = json['count_post'];
    label = json['label'];
    checkFollowStatus = json['check_follow_status'];
    countRequest = json['count_request'];
    notificationCount = json['notification_count'];
    followerCount = json['followerCount'];
    followingCount = json['followingCount'];
    isFollow = json['is_follow'];
    isPost = json['is_post'];
    isReply = json['is_reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['contact_no'] = this.contactNo;
    data['country'] = this.country;
    data['language'] = this.language;
    data['profile_file'] = this.profileFile;
    data['cover_profile'] = this.coverProfile;
    data['tos'] = this.tos;
    data['short_description'] = this.shortDescription;
    data['role_id'] = this.roleId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['check_rising_detail'] = this.checkRisingDetail;
    data['check_professional_detail'] = this.checkProfessionalDetail;
    data['count_post'] = this.countPost;
    data['label'] = this.label;
    data['check_follow_status'] = this.checkFollowStatus;
    data['count_request'] = this.countRequest;
    data['notification_count'] = this.notificationCount;
    data['followerCount'] = this.followerCount;
    data['followingCount'] = this.followingCount;
    data['is_follow'] = this.isFollow;
    data['is_post'] = this.isPost;
    data['is_reply'] = this.isReply;
    if (this.risingDetail != null) {
      data['RisingDetail'] = this.risingDetail.toJson();
    }
    return data;
  }
}

// Project imports:
import 'package:alanis/export.dart';

class Detail {
  int id;
  String fullName;
  String firstName;
  String lastName;
  String email;
  String dateOfBirth;
  int gender;
  String contactNo;
  String country;
  String language;
  String profileFile;
  String coverProfile;
  var tos;
  String shortDescription;
  int roleId;
  int stateId;
  int typeId;
  String timezone;
  String createdOn;
  int createdById;
  bool checkRisingDetail;
  bool checkProfessionalDetail;
  List<Answers> answers;
  RisingDetail risingDetail;
  String countPost;
  int checkFollowStatus;
  String countRequest;
  String notificationCount;
  var followerCount;
  var followingCount;
  var isFollow;
  var isPost;
  var isReply;
  int label;

  Detail(
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
      this.countPost,
      this.checkFollowStatus,
      this.countRequest,
      this.notificationCount,
      this.checkRisingDetail,
      this.checkProfessionalDetail,
      this.answers,
      this.risingDetail,
      this.followerCount,
      this.followingCount,
      this.isFollow,
      this.isPost,
      this.isReply,
      this.label});

  Detail.fromJson(Map<String, dynamic> json) {
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
    profileFile = imageUrl + json['profile_file'];
    if (json['cover_profile'] != null) {
      coverProfile = imageUrl + json['cover_profile'];
    }
    tos = json['tos'];
    shortDescription = json['short_description'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    if (json['label'] != null) {
      label = json['label'];
    }
    if (json['Answers'] != null) {
      answers = [];
      json['Answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    if (json['count_post'] != null) countPost = json['count_post'];
    if (json['check_follow_status'] != null)
      checkFollowStatus = json['check_follow_status'];
    if (json['count_request'] != null) countRequest = json['count_request'];
    if (json['notification_count'] != null)
      notificationCount = json['notification_count'];
    checkRisingDetail = json['check_rising_detail'];
    checkProfessionalDetail = json['check_professional_detail'];
    risingDetail = json['RisingDetail'] != null
        ? new RisingDetail.fromJson(json['RisingDetail'])
        : null;
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
    if (this.coverProfile != null) {
      data['cover_profile'] = this.coverProfile;
    }
    data['tos'] = this.tos;
    data['short_description'] = this.shortDescription;
    data['role_id'] = this.roleId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    if (this.label != null) {
      data['label'] = this.label;
    }
    data['label'] = this.label;
    if (this.countPost != null) data['count_post'] = this.countPost;
    if (this.checkFollowStatus != null)
      data['check_follow_status'] = this.checkFollowStatus;
    if (this.notificationCount != null)
      data['notification_count'] = this.notificationCount;
    data['check_rising_detail'] = this.checkRisingDetail;
    data['check_professional_detail'] = this.checkProfessionalDetail;
    if (this.risingDetail != null) {
      data['RisingDetail'] = this.risingDetail.toJson();
    }
    if (this.answers != null) {
      data['Answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['followerCount'] = this.followerCount;
    data['followingCount'] = this.followingCount;
    data['is_follow'] = this.isFollow;
    data['is_post'] = this.isPost;
    data['is_reply'] = this.isReply;
    return data;
  }
}

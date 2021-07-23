// Project imports:
import 'package:alanis/export.dart';
import 'rising_detail_model.dart';

class ToUser {
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
  String tos;
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

  ToUser(
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
      this.answers,
      this.risingDetail});

  ToUser.fromJson(Map<String, dynamic> json) {
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
    if (json['Answers'] != null) {
      answers = [];
      json['Answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    risingDetail = json['RisingDetail'] != null
        ? new RisingDetail.fromJson(json['RisingDetail'])
        : null;
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
    if (this.answers != null) {
      data['Answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    if (this.risingDetail != null) {
      data['RisingDetail'] = this.risingDetail.toJson();
    }
    return data;
  }
}
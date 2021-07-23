class UpdateProfileDataModel {
  int id;
  String fullName;
  String firstName;
  String lastName;
  String email;
  Null dateOfBirth;
  int gender;
  String contactNo;
  String language;
  String profileFile;
  String idProofDocument;
  Null tos;
  String roleId;
  int stateId;
  int typeId;
  String timezone;
  String createdOn;

  UpdateProfileDataModel(
      {this.id,
      this.fullName,
      this.firstName,
      this.lastName,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.contactNo,
      this.language,
      this.profileFile,
      this.idProofDocument,
      this.tos,
      this.roleId,
      this.stateId,
      this.typeId,
      this.timezone,
      this.createdOn});

  UpdateProfileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    contactNo = json['contact_no'];
    language = json['language'];
    profileFile = json['profile_file'];
    idProofDocument = json['id_proof_document'];
    tos = json['tos'];
    roleId = json['role_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    timezone = json['timezone'];
    createdOn = json['created_on'];
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
    data['language'] = this.language;
    data['profile_file'] = this.profileFile;
    data['id_proof_document'] = this.idProofDocument;
    data['tos'] = this.tos;
    data['role_id'] = this.roleId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['timezone'] = this.timezone;
    data['created_on'] = this.createdOn;
    return data;
  }
}

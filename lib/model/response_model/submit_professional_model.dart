class SubmitProfessionalModel {
  String message;
  QuestionDetail detail;
  String copyrighths;

  SubmitProfessionalModel({this.message, this.detail, this.copyrighths});

  SubmitProfessionalModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    detail = json['detail'] != null
        ? new QuestionDetail.fromJson(json['detail'])
        : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

class QuestionDetail {
  int id;
  String title;
  String companyName;
  String field;
  String otherDetail;
  int stateId;
  int typeId;
  String createdOn;
  int createdById;

  QuestionDetail(
      {this.id,
      this.title,
      this.companyName,
      this.field,
      this.otherDetail,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById});

  QuestionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    companyName = json['company_name'];
    field = json['field'];
    otherDetail = json['other_detail'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['company_name'] = this.companyName;
    data['field'] = this.field;
    data['other_detail'] = this.otherDetail;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

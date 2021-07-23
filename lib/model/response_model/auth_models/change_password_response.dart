class ChangePasswordResponseModel {
  String message;
  String copyrighths;

  ChangePasswordResponseModel({this.message, this.copyrighths});

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

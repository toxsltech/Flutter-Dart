class ErrorMessageResponseModel {
  bool success;
  String message;

  ErrorMessageResponseModel({this.success, this.message});

  ErrorMessageResponseModel.fromJson(Map json) {
    success = json['success'];
    message = json['message'];
  }

  Map toJson() {
    final Map data = new Map();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

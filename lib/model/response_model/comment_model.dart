class CommentDataModel {
  String count;
  String message;
  String copyrighths;

  CommentDataModel({this.count, this.message, this.copyrighths});

  CommentDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    message = json['message'];
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['message'] = this.message;
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

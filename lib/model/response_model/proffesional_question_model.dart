class RisingStarQuestionModel {
  List<QuestionData> list;
  String copyrighths;

  RisingStarQuestionModel({this.list, this.copyrighths});

  RisingStarQuestionModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list.add(new QuestionData.fromJson(v));
      });
    }
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['copyrighths'] = this.copyrighths;
    return data;
  }
}

class QuestionData {
  int id;
  String title;
  String description;
  int stateId;
  int typeId;
  String createdOn;
  int createdById;

  QuestionData(
      {this.id,
      this.title,
      this.description,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById});

  QuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

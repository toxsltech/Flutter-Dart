class Answers {
  int id;
  String description;
  int questionId;
  int stateId;
  int typeId;
  String createdOn;
  int createdById;

  Answers(
      {this.id,
      this.description,
      this.questionId,
      this.stateId,
      this.typeId,
      this.createdOn,
      this.createdById});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    questionId = json['question_id'];
    stateId = json['state_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['question_id'] = this.questionId;
    data['state_id'] = this.stateId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

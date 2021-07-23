class File {
  int id;
  String name;
  int size;
  String key;
  String modelType;
  int modelId;
  int typeId;
  String createdOn;
  int createdById;

  File(
      {this.id,
      this.name,
      this.size,
      this.key,
      this.modelType,
      this.modelId,
      this.typeId,
      this.createdOn,
      this.createdById});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    key = json['key'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['key'] = this.key;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    return data;
  }
}

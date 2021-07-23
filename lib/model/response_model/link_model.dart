// Project imports:
import 'package:alanis/export.dart';

class Links {
  Self self;
  Self first;
  Self last;
  Self next;

  Links({this.self, this.first, this.last, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    first = json['first'] != null ? new Self.fromJson(json['first']) : null;
    last = json['last'] != null ? new Self.fromJson(json['last']) : null;
    next = json['next'] != null ? new Self.fromJson(json['next']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self.toJson();
    }
    if (this.first != null) {
      data['first'] = this.first.toJson();
    }
    if (this.last != null) {
      data['last'] = this.last.toJson();
    }
    if (this.next != null) {
      data['next'] = this.next.toJson();
    }
    return data;
  }
}

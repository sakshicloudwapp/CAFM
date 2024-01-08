
class AssignToResponse {
  List<AssignToModel>? data;

  AssignToResponse({this.data});

  AssignToResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AssignToModel>[];
      json['data'].forEach((v) {
        data!.add(new AssignToModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignToModel {
  int? id;
  String? name;
  String? code;
  String? designation;
  String? email;
  String? mobileCode;
  String? mobileNo;
  int? resourceSubTypeId;
  String? resourceSubTypeName;

  AssignToModel(
      {this.id,
        this.name,
        this.code,
        this.designation,
        this.email,
        this.mobileCode,
        this.mobileNo,
        this.resourceSubTypeId,
        this.resourceSubTypeName});

  AssignToModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    designation = json['designation'];
    email = json['email'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
    resourceSubTypeId = json['resourceSubTypeId'];
    resourceSubTypeName = json['resourceSubTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['mobileCode'] = this.mobileCode;
    data['mobileNo'] = this.mobileNo;
    data['resourceSubTypeId'] = this.resourceSubTypeId;
    data['resourceSubTypeName'] = this.resourceSubTypeName;
    return data;
  }
}


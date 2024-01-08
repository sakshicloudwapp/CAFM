class GetUserModel {
  int? id;
  String? name;
  String? code;
  String? designation;
  String? email;
  String? mobileCode;
  String? mobileNo;
  int? resourceSubTypeId;
  String? resourceSubTypeName;
  String? imageUrl;

  GetUserModel(
      {this.id,
        this.name,
        this.code,
        this.designation,
        this.email,
        this.mobileCode,
        this.mobileNo,
        this.resourceSubTypeId,
        this.resourceSubTypeName,
        this.imageUrl});

  GetUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    designation = json['designation'];
    email = json['email'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
    resourceSubTypeId = json['resourceSubTypeId'];
    resourceSubTypeName = json['resourceSubTypeName'];
    imageUrl = json['imageUrl'];
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
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
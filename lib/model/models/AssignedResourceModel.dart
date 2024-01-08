class AssignedResoureModel {
  List<AssignedResourcesModel>? resources;

  AssignedResoureModel({this.resources});

  AssignedResoureModel.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      resources = <AssignedResourcesModel>[];
      json['resources'].forEach((v) {
        resources!.add(new AssignedResourcesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resources != null) {
      data['resources'] = this.resources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignedResourcesModel {
  int? id;
  String? name;
  String? designation;
  String? email;
  String? mobileCode;
  String? mobileNo;
  bool? isChecked = false;

  AssignedResourcesModel(
      {this.id,
        this.name,
        this.designation,
        this.email,
        this.mobileCode,
        this.mobileNo,
      this.isChecked});

  AssignedResourcesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    designation = json['designation'];
    email = json['email'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['mobileCode'] = this.mobileCode;
    data['mobileNo'] = this.mobileNo;
    return data;
  }
}
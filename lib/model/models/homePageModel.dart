class HomePageModel {
  String? title;
  List<HomePageDataModel>? data;

  HomePageModel({this.title, this.data});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['data'] != null) {
      data = <HomePageDataModel>[];
      json['data'].forEach((v) {
        data!.add(new HomePageDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomePageDataModel {
  int? id;
  String? type;
  String? displayName;
  int? sortOrder;
  String? iconName;
  int? value;

  HomePageDataModel(
      {this.id,
        this.type,
        this.displayName,
        this.sortOrder,
        this.iconName,
        this.value});

  HomePageDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    displayName = json['displayName'];
    sortOrder = json['sortOrder'];
    iconName = json['iconName'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['displayName'] = this.displayName;
    data['sortOrder'] = this.sortOrder;
    data['iconName'] = this.iconName;
    data['value'] = this.value;
    return data;
  }
}
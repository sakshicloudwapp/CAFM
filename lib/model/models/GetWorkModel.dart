class GetWorkModel {
  int? id;
  String? securityInfoId;
  bool? hasResourceViewed;
  String? buildingName;
  String? floorName;
  String? unitName;
  String? roomName;
  String? problem;
  String? dueDate;
  int? workStatusId;
 String?workStatusName;
  int? resourceId;
  String? reporteddate;
  bool isHide = false;

  GetWorkModel(
      {this.id,
        this.securityInfoId,
        this.hasResourceViewed,
        this.buildingName,
        this.floorName,
        this.unitName,
        this.roomName,
        this.problem,
        this.dueDate,
        this.workStatusId,
        this.workStatusName,
        this.resourceId,
      this.reporteddate,
      required this.isHide
      });


  GetWorkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    securityInfoId = json['securityInfoId'];
    hasResourceViewed = json['hasResourceViewed'];
    buildingName = json['buildingName'];
    floorName = json['floorName'];
    unitName = json['unitName'];
    roomName = json['roomName'];
    problem = json['problem'];
    dueDate = json['dueDate'];
    workStatusId = json['workStatusId'];
    workStatusName = json['workStatusName'];
    resourceId = json['resourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['securityInfoId'] = this.securityInfoId;
    data['hasResourceViewed'] = this.hasResourceViewed;
    data['buildingName'] = this.buildingName;
    data['floorName'] = this.floorName;
    data['unitName'] = this.unitName;
    data['roomName'] = this.roomName;
    data['problem'] = this.problem;
    data['dueDate'] = this.dueDate;
    data['workStatusId'] = this.workStatusId;
    data['workStatusName'] = this.workStatusName;
    data['resourceId'] = this.resourceId;
    return data;
  }
}
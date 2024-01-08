class GetNotificationWorkOrdersModel {
  int? id;
  String? securityInfoId;
  bool? hasResourceViewed;
  String? buildingName;
  String? floorName;
  String? unitName;
  String? roomName;
  String? problem;
  String? dueDate;
  String? reportedDate;
  int? workStatusId;
  String? workStatusName;
  int? resourceId;

  GetNotificationWorkOrdersModel(
      {this.id,
        this.securityInfoId,
        this.hasResourceViewed,
        this.buildingName,
        this.floorName,
        this.unitName,
        this.roomName,
        this.problem,
        this.dueDate,
        this.reportedDate,
        this.workStatusId,
        this.workStatusName,
        this.resourceId});

  GetNotificationWorkOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    securityInfoId = json['securityInfoId'];
    hasResourceViewed = json['hasResourceViewed'];
    buildingName = json['buildingName'];
    floorName = json['floorName'];
    unitName = json['unitName'];
    roomName = json['roomName'];
    problem = json['problem'];
    dueDate = json['dueDate'];
    reportedDate = json['reportedDate'];
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
    data['reportedDate'] = this.reportedDate;
    data['workStatusId'] = this.workStatusId;
    data['workStatusName'] = this.workStatusName;
    data['resourceId'] = this.resourceId;
    return data;
  }
}
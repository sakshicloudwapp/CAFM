class GetTaskLogDataResponse {
  int? id;
  String? securityInfoId;
  String? reportedBy;
  String? emailAddress;
  String? phoneNo;
  String? locationName;
  String? buildingName;
  String? typeName;
  String? subTypeName;
  String? categoryName;
  String? reportedDate;
  String? assetCode;
  String? assetName;
  String? title;
  String? modeOfCall;
  String? priorityName;
  String? dueDate;
  int? statusId;
  String? statusName;
  String? locCode;
  int? age;
  Null? resouceName;
  String? loggedBy;

  GetTaskLogDataResponse(
      {this.id,
        this.securityInfoId,
        this.reportedBy,
        this.emailAddress,
        this.phoneNo,
        this.locationName,
        this.buildingName,
        this.typeName,
        this.subTypeName,
        this.categoryName,
        this.reportedDate,
        this.assetCode,
        this.assetName,
        this.title,
        this.modeOfCall,
        this.priorityName,
        this.dueDate,
        this.statusId,
        this.statusName,
        this.locCode,
        this.age,
        this.resouceName,
        this.loggedBy});

  GetTaskLogDataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    securityInfoId = json['securityInfoId'];
    reportedBy = json['reportedBy'];
    emailAddress = json['emailAddress'];
    phoneNo = json['phoneNo'];
    locationName = json['locationName'];
    buildingName = json['buildingName'];
    typeName = json['typeName'];
    subTypeName = json['subTypeName'];
    categoryName = json['categoryName'];
    reportedDate = json['reportedDate'];
    assetCode = json['assetCode'];
    assetName = json['assetName'];
    title = json['title'];
    modeOfCall = json['modeOfCall'];
    priorityName = json['priorityName'];
    dueDate = json['dueDate'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    locCode = json['locCode'];
    age = json['age'];
    resouceName = json['resouceName'];
    loggedBy = json['loggedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['securityInfoId'] = this.securityInfoId;
    data['reportedBy'] = this.reportedBy;
    data['emailAddress'] = this.emailAddress;
    data['phoneNo'] = this.phoneNo;
    data['locationName'] = this.locationName;
    data['buildingName'] = this.buildingName;
    data['typeName'] = this.typeName;
    data['subTypeName'] = this.subTypeName;
    data['categoryName'] = this.categoryName;
    data['reportedDate'] = this.reportedDate;
    data['assetCode'] = this.assetCode;
    data['assetName'] = this.assetName;
    data['title'] = this.title;
    data['modeOfCall'] = this.modeOfCall;
    data['priorityName'] = this.priorityName;
    data['dueDate'] = this.dueDate;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['locCode'] = this.locCode;
    data['age'] = this.age;
    data['resouceName'] = this.resouceName;
    data['loggedBy'] = this.loggedBy;
    return data;
  }
}
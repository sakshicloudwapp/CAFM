class Autogenerated {
  List<MrTypesModel>? mrTypes;
 // Null? stocks;
  List<MrDetailsModel>? mrDetails;
 // Null? financeCodes;
  //Null? costCenters;
  //Null? costCodes;
 // Null? resources;
  //Null? workOrders;

  Autogenerated(
      {
        this.mrTypes,
       // this.stocks,
        this.mrDetails,
        // this.financeCodes,
        // this.costCenters,
        // this.costCodes,
        // this.resources,
        // this.workOrders
      });

  Autogenerated.fromJson(Map<String, dynamic> json) {
    if (json['mrTypes'] != null) {
      mrTypes = <MrTypesModel>[];
      json['mrTypes'].forEach((v) {
        mrTypes!.add(new MrTypesModel.fromJson(v));
      });
    }
    // stocks = json['stocks'];
    if (json['mrDetails'] != null) {
      mrDetails = <MrDetailsModel>[];
      json['mrDetails'].forEach((v) {
        mrDetails!.add(new MrDetailsModel.fromJson(v));
      });
    }
    // financeCodes = json['financeCodes'];
    // costCenters = json['costCenters'];
    // costCodes = json['costCodes'];
    // resources = json['resources'];
    // workOrders = json['workOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mrTypes != null) {
      data['mrTypes'] = this.mrTypes!.map((v) => v.toJson()).toList();
    }
    //data['stocks'] = this.stocks;
    if (this.mrDetails != null) {
      data['mrDetails'] = this.mrDetails!.map((v) => v.toJson()).toList();
    }
    // data['financeCodes'] = this.financeCodes;
    // data['costCenters'] = this.costCenters;
    // data['costCodes'] = this.costCodes;
    // data['resources'] = this.resources;
    // data['workOrders'] = this.workOrders;
    return data;
  }
}

class MrTypesModel {
  int? id;
  String? name;
  String? code;

  MrTypesModel({this.id, this.name, this.code});

  MrTypesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class MrDetailsModel {
  int? id;
  int? projectId;
  int? taskTypeId;
  int? taskLogId;
  String? description;
  Null? financeCodeId;
  Null? costCodeId;
  Null? costCenterId;
  int? reportedById;
  Null? reportedByName;
  Null? reportedByEmail;
  Null? reportedByMobile;
  Null? deptName;
  String? code;
  String? createdDate;
  Null? createdByName;
  Null? serviceReportNo;
  Null? serviceReportDate;
  List<MrDetailItemsModel>? mrDetailItems;

  MrDetailsModel(
      {this.id,
        this.projectId,
        this.taskTypeId,
        this.taskLogId,
        this.description,
        this.financeCodeId,
        this.costCodeId,
        this.costCenterId,
        this.reportedById,
        this.reportedByName,
        this.reportedByEmail,
        this.reportedByMobile,
        this.deptName,
        this.code,
        this.createdDate,
        this.createdByName,
        this.serviceReportNo,
        this.serviceReportDate,
        this.mrDetailItems});

  MrDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['projectId'];
    taskTypeId = json['taskTypeId'];
    taskLogId = json['taskLogId'];
    description = json['description'];
    financeCodeId = json['financeCodeId'];
    costCodeId = json['costCodeId'];
    costCenterId = json['costCenterId'];
    reportedById = json['reportedById'];
    reportedByName = json['reportedByName'];
    reportedByEmail = json['reportedByEmail'];
    reportedByMobile = json['reportedByMobile'];
    deptName = json['deptName'];
    code = json['code'];
    createdDate = json['createdDate'];
    createdByName = json['createdByName'];
    serviceReportNo = json['serviceReportNo'];
    serviceReportDate = json['serviceReportDate'];
    if (json['mrDetailItems'] != null) {
      mrDetailItems = <MrDetailItemsModel>[];
      json['mrDetailItems'].forEach((v) {
        mrDetailItems!.add(new MrDetailItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectId'] = this.projectId;
    data['taskTypeId'] = this.taskTypeId;
    data['taskLogId'] = this.taskLogId;
    data['description'] = this.description;
    data['financeCodeId'] = this.financeCodeId;
    data['costCodeId'] = this.costCodeId;
    data['costCenterId'] = this.costCenterId;
    data['reportedById'] = this.reportedById;
    data['reportedByName'] = this.reportedByName;
    data['reportedByEmail'] = this.reportedByEmail;
    data['reportedByMobile'] = this.reportedByMobile;
    data['deptName'] = this.deptName;
    data['code'] = this.code;
    data['createdDate'] = this.createdDate;
    data['createdByName'] = this.createdByName;
    data['serviceReportNo'] = this.serviceReportNo;
    data['serviceReportDate'] = this.serviceReportDate;
    if (this.mrDetailItems != null) {
      data['mrDetailItems'] =
          this.mrDetailItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MrDetailItemsModel {
  int? id;
  int? mrId;
  int? mrTypeId;
  int? stockId;
  String? stockName;
  int? availableQty;
  int? requiredQty;
  double? unitPrice;
  double? totalPrice;
  String? remarks;

  MrDetailItemsModel(
      {this.id,
        this.mrId,
        this.mrTypeId,
        this.stockId,
        this.stockName,
        this.availableQty,
        this.requiredQty,
        this.unitPrice,
        this.totalPrice,
        this.remarks});

  MrDetailItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mrId = json['mrId'];
    mrTypeId = json['mrTypeId'];
    stockId = json['stockId'];
    stockName = json['stockName'];
    availableQty = json['availableQty'];
    requiredQty = json['requiredQty'];
    unitPrice = json['unitPrice'];
    totalPrice = json['totalPrice'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mrId'] = this.mrId;
    data['mrTypeId'] = this.mrTypeId;
    data['stockId'] = this.stockId;
    data['stockName'] = this.stockName;
    data['availableQty'] = this.availableQty;
    data['requiredQty'] = this.requiredQty;
    data['unitPrice'] = this.unitPrice;
    data['totalPrice'] = this.totalPrice;
    data['remarks'] = this.remarks;
    return data;
  }
}

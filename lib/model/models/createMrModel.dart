class CreateMrModel {
  int? id;
  int? projectId;
  int? taskTypeId;
  int? taskLogId;
  String? description;
  int? financeCodeId;
  int? costCodeId;
  int? costCenterId;
  int? reportedById;
  String? reportedByName;
  String? reportedByEmail;
  String? reportedByMobile;
  String? deptName;
  String? code;
  String? createdDate;
  String? createdByName;
  String? serviceReportNo;
  String? serviceReportDate;
  List<MrDetailItems>? mrDetailItems;

  CreateMrModel(
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

  CreateMrModel.fromJson(Map<String, dynamic> json) {
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
      mrDetailItems = <MrDetailItems>[];
      json['mrDetailItems'].forEach((v) {
        mrDetailItems!.add(new MrDetailItems.fromJson(v));
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

class MrDetailItems {
  int? id;
  int? mrId;
  int? mrTypeId;
  int? stockId;
  String? stockName;
  int? availableQty;
  int? requiredQty;
  int? unitPrice;
  int? totalPrice;
  String? remarks;

  MrDetailItems(
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

  MrDetailItems.fromJson(Map<String, dynamic> json) {
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
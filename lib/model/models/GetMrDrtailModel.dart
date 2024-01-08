class MrStockModel {
  List<MrTypes>? mrTypes;
  List<ProjectsStockModel>? projects;
  List<WorkOrderTypes>? workOrderTypes;

  List<StocksModel>? stocks;
  List<MrDetails>? mrDetails;
  List<FinanceCodes>? financeCodes;
  List<CostCenters>? costCenters;
  List<CostCodes>? costCodes;
  List<NewResourcesModel>? resources;
  List<WorkOrders>? workOrders;

  MrStockModel(
      {this.projects,
        this.workOrderTypes,
        this.mrTypes,
        this.stocks,
        this.mrDetails,
        this.financeCodes,
        this.costCenters,
        this.costCodes,
        this.resources,
        this.workOrders});

  MrStockModel.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <ProjectsStockModel>[];
      json['projects'].forEach((v) {
        projects!.add(new ProjectsStockModel.fromJson(v));
      });
    }
    if (json['workOrderTypes'] != null) {
      workOrderTypes = <WorkOrderTypes>[];
      json['workOrderTypes'].forEach((v) {
        workOrderTypes!.add(new WorkOrderTypes.fromJson(v));
      });
    }
    if (json['mrTypes'] != null) {
      mrTypes = <MrTypes>[];
      json['mrTypes'].forEach((v) {
        mrTypes!.add(new MrTypes.fromJson(v));
      });
    }
    if (json['stocks'] != null) {
      stocks = <StocksModel>[];
      json['stocks'].forEach((v) {
        stocks!.add(new StocksModel.fromJson(v));
      });
    }
    if (json['mrDetails'] != null) {
      mrDetails = <MrDetails>[];
      json['mrDetails'].forEach((v) {
        mrDetails!.add(new MrDetails.fromJson(v));
      });
    }
    if (json['financeCodes'] != null) {
      financeCodes = <FinanceCodes>[];
      json['financeCodes'].forEach((v) {
        financeCodes!.add(new FinanceCodes.fromJson(v));
      });
    }
    if (json['costCenters'] != null) {
      costCenters = <CostCenters>[];
      json['costCenters'].forEach((v) {
        costCenters!.add(new CostCenters.fromJson(v));
      });
    }
    if (json['costCodes'] != null) {
      costCodes = <CostCodes>[];
      json['costCodes'].forEach((v) {
        costCodes!.add(new CostCodes.fromJson(v));
      });
    }
    if (json['resources'] != null) {
      resources = <NewResourcesModel>[];
      json['resources'].forEach((v) {
        resources!.add(new NewResourcesModel.fromJson(v));
      });
    }
    if (json['workOrders'] != null) {
      workOrders = <WorkOrders>[];
      json['workOrders'].forEach((v) {
        workOrders!.add(new WorkOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    if (this.workOrderTypes != null) {
      data['workOrderTypes'] =
          this.workOrderTypes!.map((v) => v.toJson()).toList();
    }
    if (this.mrTypes != null) {
      data['mrTypes'] = this.mrTypes!.map((v) => v.toJson()).toList();
    }
    if (this.stocks != null) {
      data['stocks'] = this.stocks!.map((v) => v.toJson()).toList();
    }
    if (this.mrDetails != null) {
      data['mrDetails'] = this.mrDetails!.map((v) => v.toJson()).toList();
    }
    if (this.financeCodes != null) {
      data['financeCodes'] = this.financeCodes!.map((v) => v.toJson()).toList();
    }
    if (this.costCenters != null) {
      data['costCenters'] = this.costCenters!.map((v) => v.toJson()).toList();
    }
    if (this.costCodes != null) {
      data['costCodes'] = this.costCodes!.map((v) => v.toJson()).toList();
    }
    if (this.resources != null) {
      data['resources'] = this.resources!.map((v) => v.toJson()).toList();
    }
    if (this.workOrders != null) {
      data['workOrders'] = this.workOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinanceCodes {
  int? id;
  String? name;
  String? code;
  String? description;
  int? groupId;

  FinanceCodes({this.id, this.name, this.code, this.description, this.groupId});

  FinanceCodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['groupId'] = this.groupId;
    return data;
  }
}


class MrTypes {
  int? id;
  String? name;
  String? code;
  String? description;
  double? groupId;

  MrTypes({this.id, this.name, this.code, this.description, this.groupId});

  MrTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['groupId'] = this.groupId;
    return data;
  }
}


class WorkOrderTypes {
  int? id;
  String? name;
  String? code;
  String? description;
  int? groupId;

  WorkOrderTypes(
      {this.id, this.name, this.code, this.description, this.groupId});

  WorkOrderTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['groupId'] = this.groupId;
    return data;
  }
}


class ProjectsStockModel {
  int? id;
  String? name;
  String? code;
  String? description;
  int? groupId;

  ProjectsStockModel({this.id, this.name, this.code, this.description, this.groupId});

  ProjectsStockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['groupId'] = this.groupId;
    return data;
  }
}

class StocksModel {
  int? id;
   String? name;
   String? code;
  String? sparePartCode;
  int? availableStock;
  double? unitPrice;
  String? manufacturer;
  String? mname;

  StocksModel(
      {this.id,
         this.name,
         this.code,
        this.sparePartCode,
        this.availableStock,
        this.unitPrice,
        this.manufacturer,
       this.mname
      });

  StocksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
     name = json['name'];
     code = json['code'];
    sparePartCode = json['sparePartCode'];
    availableStock = json['availableStock'];
    unitPrice = json['unitPrice'];
    manufacturer = json['manufacturer'];
   mname = json['model'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
     data['name'] = this.name;
     data['code'] = this.code;
    // data['sparePartCode'] = this.sparePartCode;
    // data['availableStock'] = this.availableStock;
    // data['unitPrice'] = this.unitPrice;
    // data['manufacturer'] = this.manufacturer;
  //  data['model'] = this.mname;
    return data;
  }
}

class MrDetails {
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

  MrDetails(
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

  MrDetails.fromJson(Map<String, dynamic> json) {
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
  double? unitPrice;
  double? totalPrice;
  String? remarks;
  String? typename;

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
        this.remarks,
        this.typename,
      });

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

class CostCenters {
  int? financeCodeId;
  int? id;
  String? name;
  String? code;
  String? description;
  int? groupId;

  CostCenters(
      {this.financeCodeId,
        this.id,
        this.name,
        this.code,
        this.description,
        this.groupId});

  CostCenters.fromJson(Map<String, dynamic> json) {
    financeCodeId = json['financeCodeId'];
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['financeCodeId'] = this.financeCodeId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['groupId'] = this.groupId;
    return data;
  }
}

class CostCodes {
  int? costCenterId;
  int? id;
  String? name;
  String? code;
  String? description;
  int? groupId;

  CostCodes(
      {this.costCenterId,
        this.id,
        this.name,
        this.code,
        this.description,
        this.groupId});

  CostCodes.fromJson(Map<String, dynamic> json) {
    costCenterId = json['costCenterId'];
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['costCenterId'] = this.costCenterId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['groupId'] = this.groupId;
    return data;
  }
}

class NewResourcesModel {
  int? id;
  String? name;
  String? mobile;
  String? email;
  String? designation;

  NewResourcesModel({this.id, this.name, this.mobile, this.email, this.designation});

  NewResourcesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['designation'] = this.designation;
    return data;
  }
}

class WorkOrders {
  int? id;
  String? name;
  String? workOrderDate;
  String? location;

  WorkOrders({this.id, this.name, this.workOrderDate, this.location});

  WorkOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    workOrderDate = json['workOrderDate'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['workOrderDate'] = this.workOrderDate;
    data['location'] = this.location;
    return data;
  }
}
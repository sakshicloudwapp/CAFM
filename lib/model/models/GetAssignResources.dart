
class GetAssignResource {
  Configuration? configuration;
  Actions? actions;
  List<GetAssignResourcesData>? data;

  GetAssignResource({this.configuration, this.actions, this.data});

  GetAssignResource.fromJson(Map<String, dynamic> json) {
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
    actions =
    json['actions'] != null ? new Actions.fromJson(json['actions']) : null;
    if (json['data'] != null) {
      data = <GetAssignResourcesData>[];
      json['data'].forEach((v) {
        data!.add(new GetAssignResourcesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.configuration != null) {
      data['configuration'] = this.configuration!.toJson();
    }
    if (this.actions != null) {
      data['actions'] = this.actions!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Configuration {
  List<Columns>? columns;

  Configuration({this.columns});

  Configuration.fromJson(Map<String, dynamic> json) {
    if (json['columns'] != null) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(new Columns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.columns != null) {
      data['columns'] = this.columns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Columns {
  String? displayText;
  bool? showSort;
  String? mappingColumn;
  bool? showColumn;
  bool? isRequired;
  int? columnFormat;

  Columns(
      {this.displayText,
        this.showSort,
        this.mappingColumn,
        this.showColumn,
        this.isRequired,
        this.columnFormat});

  Columns.fromJson(Map<String, dynamic> json) {
    displayText = json['displayText'];
    showSort = json['showSort'];
    mappingColumn = json['mappingColumn'];
    showColumn = json['showColumn'];
    isRequired = json['isRequired'];
    columnFormat = json['columnFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayText'] = this.displayText;
    data['showSort'] = this.showSort;
    data['mappingColumn'] = this.mappingColumn;
    data['showColumn'] = this.showColumn;
    data['isRequired'] = this.isRequired;
    data['columnFormat'] = this.columnFormat;
    return data;
  }
}

class Actions {
  bool? canAdd;
  bool? canEdit;
  bool? canDelete;
  bool? canSelect;
  bool? canSearch;
  bool? canAccessPDF;
  bool? canAccessExcel;
  bool? modifyColumnView;
  bool? canTransfer;
  bool? canExport;

  Actions(
      {this.canAdd,
        this.canEdit,
        this.canDelete,
        this.canSelect,
        this.canSearch,
        this.canAccessPDF,
        this.canAccessExcel,
        this.modifyColumnView,
        this.canTransfer,
        this.canExport});

  Actions.fromJson(Map<String, dynamic> json) {
    canAdd = json['canAdd'];
    canEdit = json['canEdit'];
    canDelete = json['canDelete'];
    canSelect = json['canSelect'];
    canSearch = json['canSearch'];
    canAccessPDF = json['canAccessPDF'];
    canAccessExcel = json['canAccessExcel'];
    modifyColumnView = json['modifyColumnView'];
    canTransfer = json['canTransfer'];
    canExport = json['canExport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canAdd'] = this.canAdd;
    data['canEdit'] = this.canEdit;
    data['canDelete'] = this.canDelete;
    data['canSelect'] = this.canSelect;
    data['canSearch'] = this.canSearch;
    data['canAccessPDF'] = this.canAccessPDF;
    data['canAccessExcel'] = this.canAccessExcel;
    data['modifyColumnView'] = this.modifyColumnView;
    data['canTransfer'] = this.canTransfer;
    data['canExport'] = this.canExport;
    return data;
  }
}
class GetAssignResourcesData {
  int? id;
  String? name;
  String? code;
  String? designation;
  String? email;
  Null? mobileCode;
  String? mobileNo;
  int? resourceSubTypeId;
  Null? resourceSubTypeName;

  GetAssignResourcesData(
      {this.id,
        this.name,
        this.code,
        this.designation,
        this.email,
        this.mobileCode,
        this.mobileNo,
        this.resourceSubTypeId,
        this.resourceSubTypeName});

  GetAssignResourcesData.fromJson(Map<String, dynamic> json) {
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
class GetAllAssetsModel {
  Configuration? configuration;
  Actions? actions;
  List<GetAllAssetData>? data;

  GetAllAssetsModel({this.configuration, this.actions, this.data});

  GetAllAssetsModel.fromJson(Map<String, dynamic> json) {
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
    actions =
    json['actions'] != null ? new Actions.fromJson(json['actions']) : null;
    if (json['data'] != null) {
      data = <GetAllAssetData>[];
      json['data'].forEach((v) {
        data!.add(new GetAllAssetData.fromJson(v));
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

  Columns(
      {this.displayText,
        this.showSort,
        this.mappingColumn,
        this.showColumn,
        this.isRequired});

  Columns.fromJson(Map<String, dynamic> json) {
    displayText = json['displayText'];
    showSort = json['showSort'];
    mappingColumn = json['mappingColumn'];
    showColumn = json['showColumn'];
    isRequired = json['isRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayText'] = this.displayText;
    data['showSort'] = this.showSort;
    data['mappingColumn'] = this.mappingColumn;
    data['showColumn'] = this.showColumn;
    data['isRequired'] = this.isRequired;
    return data;
  }
}

class Actions {
  bool? canAdd;
  bool? canEdit;
  bool? canDelete;

  Actions({this.canAdd, this.canEdit, this.canDelete});

  Actions.fromJson(Map<String, dynamic> json) {
    canAdd = json['canAdd'];
    canEdit = json['canEdit'];
    canDelete = json['canDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canAdd'] = this.canAdd;
    data['canEdit'] = this.canEdit;
    data['canDelete'] = this.canDelete;
    return data;
  }
}

class GetAllAssetData {
  int? assetId;
  String? assetCode;
  String? assetName;
  String? systemName;
  String? typeName;
  String? masterDevelopmentName;
  String? buildingName;
  String? roomName;
  String? description;

  GetAllAssetData(
      {this.assetId,
        this.assetCode,
        this.assetName,
        this.systemName,
        this.typeName,
        this.masterDevelopmentName,
        this.buildingName,
        this.roomName,
        this.description});

  GetAllAssetData.fromJson(Map<String, dynamic> json) {
    assetId = json['assetId'];
    assetCode = json['assetCode'];
    assetName = json['assetName'];
    systemName = json['systemName'];
    typeName = json['typeName'];
    masterDevelopmentName = json['masterDevelopmentName'];
    buildingName = json['buildingName'];
    roomName = json['roomName'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetId'] = this.assetId;
    data['assetCode'] = this.assetCode;
    data['assetName'] = this.assetName;
    data['systemName'] = this.systemName;
    data['typeName'] = this.typeName;
    data['masterDevelopmentName'] = this.masterDevelopmentName;
    data['buildingName'] = this.buildingName;
    data['roomName'] = this.roomName;
    data['description'] = this.description;
    return data;
  }
}
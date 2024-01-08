class ScanModel {
  String? code;
  String? description;
  Null? buildingId;
  int? id;
  String? name;

  ScanModel(
      {this.code, this.description, this.buildingId, this.id, this.name});

  ScanModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    buildingId = json['buildingId'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['buildingId'] = this.buildingId;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class AssetScanModel {
  int? projectId;
  String? projectName;
  int? buildingId;
  String? buildingName;
  int? floorId;
  String? floorName;
  int? unitId;
  String? unitName;
  int? roomId;
  String? roomName;
  String? assetName;
  String? assetType;
  String? systemName;
  String? subSystem;
  String? tag;
  String? description;
  String? manufacturer;
  String? productCode;
  String? model;
  String? serialNo;
  String? maintainabilityType;
  String? assetCriticality;
  String? assetCriticalityDescription;
  String? quantity;
  String? parentAssetCode;



  AssetScanModel(
      {this.projectId,
        this.projectName,
        this.buildingId,
        this.buildingName,
        this.floorId,
        this.floorName,
        this.unitId,
        this.unitName,
        this.roomId,
        this.roomName,
        this.assetName,
        this.assetType,
        this.systemName,
        this.subSystem,
        this.tag,
        this.description,
        this.manufacturer,
        this.productCode,
        this.model,
        this.serialNo,
        this.maintainabilityType,
        this.assetCriticality,
        this.assetCriticalityDescription,
        this.quantity,
        this.parentAssetCode
      });

  AssetScanModel.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    projectName = json['projectName'];
    buildingId = json['buildingId'];
    buildingName = json['buildingName'];
    floorId = json['floorId'];
    floorName = json['floorName'];
    unitId = json['unitId'];
    unitName = json['unitName'];
    roomId = json['roomId'];
    roomName = json['roomName'];
    assetName = json['assetName'];
    assetType = json['assetType'];
    systemName = json['systemName'];
    subSystem = json['subSystem'];
    tag = json['tag'];
    description = json['description'];
    manufacturer = json['manufacturer'];
    productCode = json['productCode'];
    model = json['model'];
    serialNo = json['serialNo'];
    maintainabilityType = json['maintainabilityType'];
    assetCriticality = json['assetCriticality'];
    assetCriticalityDescription = json['assetCriticalityDescription'];
    quantity = json['quantity'];
    parentAssetCode = json['parentAssetCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['projectName'] = this.projectName;
    data['buildingId'] = this.buildingId;
    data['buildingName'] = this.buildingName;
    data['floorId'] = this.floorId;
    data['floorName'] = this.floorName;
    data['unitId'] = this.unitId;
    data['unitName'] = this.unitName;
    data['roomId'] = this.roomId;
    data['roomName'] = this.roomName;
    data['roomName'] = this.roomName;
    data['assetName'] = this.assetName;
    data['assetType'] = this.assetType;
    data['systemName'] = this.systemName;
    data['subSystem'] = this.subSystem;
    data['tag'] = this.tag;
    data['description'] = this.description;
    data['manufacturer'] = this.manufacturer;
    data['productCode'] = this.productCode;
    data['model'] = this.model;
    data['serialNo'] = this.serialNo;
    data['maintainabilityType'] = this.maintainabilityType;
    data['assetCriticality'] = this.assetCriticality;
    data['assetCriticalityDescription'] = this.assetCriticalityDescription;
    data['quantity'] = this.quantity;
    data['parentAssetCode'] = this.parentAssetCode;
    return data;
  }
}
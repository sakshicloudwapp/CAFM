class AssetLookupDataModel {
  int? assetId;
  String? assetCode;
  String? assetName;
  String? systemName;
  String? typeName;
  String? masterDevelopmentName;
  String? buildingName;
  String? roomName;
  String? description;

  AssetLookupDataModel(
      {this.assetId,
        this.assetCode,
        this.assetName,
        this.systemName,
        this.typeName,
        this.masterDevelopmentName,
        this.buildingName,
        this.roomName,
        this.description});

  AssetLookupDataModel.fromJson(Map<String, dynamic> json) {
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


class AssetLookupDetailModel {
  Generals? generals;
  FinancialsModel? financials;
 /* List<Null>? parameters;
  List<Null>? identifications;
  List<Null>? conditionalAudits;
  List<Null>? condAuditDetails;
  List<Null>? documents;*/

  AssetLookupDetailModel(
      {this.generals,
        this.financials,
        /*this.parameters,
        this.identifications,
        this.conditionalAudits,
        this.condAuditDetails,
        this.documents*/
      });

  AssetLookupDetailModel.fromJson(Map<String, dynamic> json) {
    generals = json['generals'] != null
        ? new Generals.fromJson(json['generals'])
        : null;
    financials = json['financials'];
    // if (json['parameters'] != null) {
    //   parameters = <Null>[];
    //   json['parameters'].forEach((v) {
    //     parameters!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['identifications'] != null) {
    //   identifications = <Null>[];
    //   json['identifications'].forEach((v) {
    //     identifications!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['conditionalAudits'] != null) {
    //   conditionalAudits = <Null>[];
    //   json['conditionalAudits'].forEach((v) {
    //     conditionalAudits!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['condAuditDetails'] != null) {
    //   condAuditDetails = <Null>[];
    //   json['condAuditDetails'].forEach((v) {
    //     condAuditDetails!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['documents'] != null) {
    //   documents = <Null>[];
    //   json['documents'].forEach((v) {
    //     documents!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generals != null) {
      data['generals'] = this.generals!.toJson();
    }
    data['financials'] = this.financials;
    // if (this.parameters != null) {
    //   data['parameters'] = this.parameters!.map((v) => v.toJson()).toList();
    // }
    // if (this.identifications != null) {
    //   data['identifications'] =
    //       this.identifications!.map((v) => v.toJson()).toList();
    // }
    // if (this.conditionalAudits != null) {
    //   data['conditionalAudits'] =
    //       this.conditionalAudits!.map((v) => v.toJson()).toList();
    // }
    // if (this.condAuditDetails != null) {
    //   data['condAuditDetails'] =
    //       this.condAuditDetails!.map((v) => v.toJson()).toList();
    // }
    // if (this.documents != null) {
    //   data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Generals {
  int? assetId;
  String? assetName;
  String? assetCode;
  int? typeId;
  String? typeName;
  int? systemId;
  String? systemName;
  int? subSystemId;
  String? subSystemName;
  int? tagId;
  String? tagName;
  String? manufacturer;
  String? productCode;
  String? model;
  String? serialNo;
  String? group;
  String? drawing;
  String? description;
  int? capacity;
  bool? isAssetCritical;
  Null? assetCriticalityTypeId;
  Null? assetParentId;
  int? quantity;
  int? uomId;
  String? uomName;
  int? pack;
  int? isChildAsset;
  String? comments;
  int? countryId;
  int? stateId;
  int? cityId;
  int? masterDevelopmentId;
  int? zoneId;
  int? buildingId;
  String? buildingName;
  int? floorId;
  String? floorName;
  int? unitOrSpaceId;
  String? unitOrSpaceName;
  int? roomId;
  String? roomName;
  String? locationComments;
  String? status;
  int? maintainabilityTypeId;
  bool? isMaintainedOutsourced;
  int? subContractorId;
  String? locationOrAssetDescription;

  Generals(
      {this.assetId,
        this.assetName,
        this.assetCode,
        this.typeId,
        this.typeName,
        this.systemId,
        this.systemName,
        this.subSystemId,
        this.subSystemName,
        this.tagId,
        this.tagName,
        this.manufacturer,
        this.productCode,
        this.model,
        this.serialNo,
        this.group,
        this.drawing,
        this.description,
        this.capacity,
        this.isAssetCritical,
        this.assetCriticalityTypeId,
        this.assetParentId,
        this.quantity,
        this.uomId,
        this.uomName,
        this.pack,
        this.isChildAsset,
        this.comments,
        this.countryId,
        this.stateId,
        this.cityId,
        this.masterDevelopmentId,
        this.zoneId,
        this.buildingId,
        this.buildingName,
        this.floorId,
        this.floorName,
        this.unitOrSpaceId,
        this.unitOrSpaceName,
        this.roomId,
        this.roomName,
        this.locationComments,
        this.status,
        this.maintainabilityTypeId,
        this.isMaintainedOutsourced,
        this.subContractorId,
        this.locationOrAssetDescription});

  Generals.fromJson(Map<String, dynamic> json) {
    assetId = json['assetId'];
    assetName = json['assetName'];
    assetCode = json['assetCode'];
    typeId = json['typeId'];
    typeName = json['typeName'];
    systemId = json['systemId'];
    systemName = json['systemName'];
    subSystemId = json['subSystemId'];
    subSystemName = json['subSystemName'];
    tagId = json['tagId'];
    tagName = json['tagName'];
    manufacturer = json['manufacturer'];
    productCode = json['productCode'];
    model = json['model'];
    serialNo = json['serialNo'];
    group = json['group'];
    drawing = json['drawing'];
    description = json['description'];
    capacity = json['capacity'];
    isAssetCritical = json['isAssetCritical'];
    assetCriticalityTypeId = json['assetCriticalityTypeId'];
    assetParentId = json['assetParentId'];
    quantity = json['quantity'];
    uomId = json['uomId'];
    uomName = json['uomName'];
    pack = json['pack'];
    isChildAsset = json['isChildAsset'];
    comments = json['comments'];
    countryId = json['countryId'];
    stateId = json['stateId'];
    cityId = json['cityId'];
    masterDevelopmentId = json['masterDevelopmentId'];
    zoneId = json['zoneId'];
    buildingId = json['buildingId'];
    buildingName = json['buildingName'];
    floorId = json['floorId'];
    floorName = json['floorName'];
    unitOrSpaceId = json['unitOrSpaceId'];
    unitOrSpaceName = json['unitOrSpaceName'];
    roomId = json['roomId'];
    roomName = json['roomName'];
    locationComments = json['locationComments'];
    status = json['status'];
    maintainabilityTypeId = json['maintainabilityTypeId'];
    isMaintainedOutsourced = json['isMaintainedOutsourced'];
    subContractorId = json['subContractorId'];
    locationOrAssetDescription = json['locationOrAssetDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetId'] = this.assetId;
    data['assetName'] = this.assetName;
    data['assetCode'] = this.assetCode;
    data['typeId'] = this.typeId;
    data['typeName'] = this.typeName;
    data['systemId'] = this.systemId;
    data['systemName'] = this.systemName;
    data['subSystemId'] = this.subSystemId;
    data['subSystemName'] = this.subSystemName;
    data['tagId'] = this.tagId;
    data['tagName'] = this.tagName;
    data['manufacturer'] = this.manufacturer;
    data['productCode'] = this.productCode;
    data['model'] = this.model;
    data['serialNo'] = this.serialNo;
    data['group'] = this.group;
    data['drawing'] = this.drawing;
    data['description'] = this.description;
    data['capacity'] = this.capacity;
    data['isAssetCritical'] = this.isAssetCritical;
    data['assetCriticalityTypeId'] = this.assetCriticalityTypeId;
    data['assetParentId'] = this.assetParentId;
    data['quantity'] = this.quantity;
    data['uomId'] = this.uomId;
    data['uomName'] = this.uomName;
    data['pack'] = this.pack;
    data['isChildAsset'] = this.isChildAsset;
    data['comments'] = this.comments;
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    data['cityId'] = this.cityId;
    data['masterDevelopmentId'] = this.masterDevelopmentId;
    data['zoneId'] = this.zoneId;
    data['buildingId'] = this.buildingId;
    data['buildingName'] = this.buildingName;
    data['floorId'] = this.floorId;
    data['floorName'] = this.floorName;
    data['unitOrSpaceId'] = this.unitOrSpaceId;
    data['unitOrSpaceName'] = this.unitOrSpaceName;
    data['roomId'] = this.roomId;
    data['roomName'] = this.roomName;
    data['locationComments'] = this.locationComments;
    data['status'] = this.status;
    data['maintainabilityTypeId'] = this.maintainabilityTypeId;
    data['isMaintainedOutsourced'] = this.isMaintainedOutsourced;
    data['subContractorId'] = this.subContractorId;
    data['locationOrAssetDescription'] = this.locationOrAssetDescription;
    return data;
  }
}

class FinancialsModel{

  FinancialsModel();
}
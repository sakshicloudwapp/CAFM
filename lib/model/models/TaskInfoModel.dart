class TaskInfoModel {
  Configuration? configuration;
  TaskLogInfo? taskLogInfo;

  TaskInfoModel({this.configuration, this.taskLogInfo});

  TaskInfoModel.fromJson(Map<String, dynamic> json) {
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
    taskLogInfo = json['taskLogInfo'] != null
        ? new TaskLogInfo.fromJson(json['taskLogInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.configuration != null) {
      data['configuration'] = this.configuration!.toJson();
    }
    if (this.taskLogInfo != null) {
      data['taskLogInfo'] = this.taskLogInfo!.toJson();
    }
    return data;
  }
}

class Configuration {
  List<TaskStatuses>? taskStatuses;
  List<TaskInstructions>? taskInstructions;
  List<Types>? types;
  List<SubTypes>? subTypes;
  List<Categories>? categories;
  List<Channels>? channels;
  List<Locs>? locs;
  List<Priorities>? priorities;
  List<FaultCodes>? faultCodes;
  List<SubTaskTypes>? subTaskTypes;
  List<SubTaskStatuses>? subTaskStatuses;
  List<OnHoldReasons>? onHoldReasons;
  List<Countries>? countries;
  List<ReporterTypesModel>? reporterTypes;
  List<ReporterSubTypesModel>? reporterSubTypes;


  Configuration(
      {this.taskStatuses,
        this.taskInstructions,
        this.types,
        this.subTypes,
        this.categories,
        this.channels,
        this.locs,
        this.priorities,
        this.faultCodes,
        this.subTaskTypes,
        this.subTaskStatuses,
        this.onHoldReasons,
      this.countries,
      this.reporterSubTypes,
      this.reporterTypes});

  Configuration.fromJson(Map<String, dynamic> json) {
    if (json['taskStatuses'] != null) {
      taskStatuses = <TaskStatuses>[];
      json['taskStatuses'].forEach((v) {
        taskStatuses!.add(new TaskStatuses.fromJson(v));
      });
    }
    if (json['taskInstructions'] != null) {
      taskInstructions = <TaskInstructions>[];
      json['taskInstructions'].forEach((v) {
        taskInstructions!.add(new TaskInstructions.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(new Types.fromJson(v));
      });
    }
    if (json['subTypes'] != null) {
      subTypes = <SubTypes>[];
      json['subTypes'].forEach((v) {
        subTypes!.add(new SubTypes.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['channels'] != null) {
      channels = <Channels>[];
      json['channels'].forEach((v) {
        channels!.add(new Channels.fromJson(v));
      });
    }
    if (json['locs'] != null) {
      locs = <Locs>[];
      json['locs'].forEach((v) {
        locs!.add(new Locs.fromJson(v));
      });
    }
    if (json['priorities'] != null) {
      priorities = <Priorities>[];
      json['priorities'].forEach((v) {
        priorities!.add(new Priorities.fromJson(v));
      });
    }
    if (json['faultCodes'] != null) {
      faultCodes = <FaultCodes>[];
      json['faultCodes'].forEach((v) {
        faultCodes!.add(new FaultCodes.fromJson(v));
      });
    }
    if (json['subTaskTypes'] != null) {
      subTaskTypes = <SubTaskTypes>[];
      json['subTaskTypes'].forEach((v) {
        subTaskTypes!.add(new SubTaskTypes.fromJson(v));
      });
    }
    if (json['subTaskStatuses'] != null) {
      subTaskStatuses = <SubTaskStatuses>[];
      json['subTaskStatuses'].forEach((v) {
        subTaskStatuses!.add(new SubTaskStatuses.fromJson(v));
      });
    }
    if (json['onHoldReasons'] != null) {
      onHoldReasons = <OnHoldReasons>[];
      json['onHoldReasons'].forEach((v) {
        onHoldReasons!.add(new OnHoldReasons.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['reporterTypes'] != null) {
      reporterTypes = <ReporterTypesModel>[];
      json['reporterTypes'].forEach((v) {
        reporterTypes!.add(new ReporterTypesModel.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['reporterTypes'] != null) {
      reporterTypes = <ReporterTypesModel>[];
      json['reporterTypes'].forEach((v) {
        reporterTypes!.add(new ReporterTypesModel.fromJson(v));
      });
    }
    if (json['reporterSubTypes'] != null) {
      reporterSubTypes = <ReporterSubTypesModel>[];
      json['reporterSubTypes'].forEach((v) {
        reporterSubTypes!.add(new ReporterSubTypesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.taskStatuses != null) {
      data['taskStatuses'] = this.taskStatuses!.map((v) => v.toJson()).toList();
    }
    if (this.taskInstructions != null) {
      data['taskInstructions'] =
          this.taskInstructions!.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types!.map((v) => v.toJson()).toList();
    }
    if (this.subTypes != null) {
      data['subTypes'] = this.subTypes!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.channels != null) {
      data['channels'] = this.channels!.map((v) => v.toJson()).toList();
    }
    if (this.locs != null) {
      data['locs'] = this.locs!.map((v) => v.toJson()).toList();
    }
    if (this.priorities != null) {
      data['priorities'] = this.priorities!.map((v) => v.toJson()).toList();
    }
    if (this.faultCodes != null) {
      data['faultCodes'] = this.faultCodes!.map((v) => v.toJson()).toList();
    }
    if (this.subTaskTypes != null) {
      data['subTaskTypes'] = this.subTaskTypes!.map((v) => v.toJson()).toList();
    }
    if (this.subTaskStatuses != null) {
      data['subTaskStatuses'] =
          this.subTaskStatuses!.map((v) => v.toJson()).toList();
    }
    if (this.onHoldReasons != null) {
      data['onHoldReasons'] =
          this.onHoldReasons!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.reporterTypes != null) {
      data['reporterTypes'] =
          this.reporterTypes!.map((v) => v.toJson()).toList();
    }
    if (this.reporterSubTypes != null) {
      data['reporterSubTypes'] =
          this.reporterSubTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReporterSubTypesModel {
  int? id;
  String? name;
  int? reporterTypeId;
  bool? isSelectable;

  ReporterSubTypesModel(
      {this.id, this.name, this.reporterTypeId, this.isSelectable});

  ReporterSubTypesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reporterTypeId = json['reporterTypeId'];
    isSelectable = json['isSelectable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['reporterTypeId'] = this.reporterTypeId;
    data['isSelectable'] = this.isSelectable;
    return data;
  }
}

class ReporterTypesModel {
  int? id;
  String? name;
  int? code;

  ReporterTypesModel({this.id, this.name, this.code});

  ReporterTypesModel.fromJson(Map<String, dynamic> json) {
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

class Countries {
  int? id;
  String? name;
  String? mobileCode;

  Countries({this.id, this.name, this.mobileCode});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileCode = json['mobileCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobileCode'] = this.mobileCode;
    return data;
  }
}

class TaskStatuses {
  int? id;
  String? name;
  Null? description;

  TaskStatuses({this.id, this.name, this.description});

  TaskStatuses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

class TaskInstructions {
  int? classificationId;
  int? typeId;
  int? subTypeId;
  int? categoryId;
  int? priorityId;
  int? disciplineId;
  bool? isMasterInstruction;
  int? noOfStaff;
  double? estimatedLabourCost;
  double? estimatedStockCost;
  int? estimatedTimeInMins;
  int? totalTimeInMins;
  bool? isActive;
  int? userId;
  int? id;
  String? name;

  TaskInstructions(
      {this.classificationId,
        this.typeId,
        this.subTypeId,
        this.categoryId,
        this.priorityId,
        this.disciplineId,
        this.isMasterInstruction,
        this.noOfStaff,
        this.estimatedLabourCost,
        this.estimatedStockCost,
        this.estimatedTimeInMins,
        this.totalTimeInMins,
        this.isActive,
        this.userId,
        this.id,
        this.name});

  TaskInstructions.fromJson(Map<String, dynamic> json) {
    classificationId = json['classificationId'];
    typeId = json['typeId'];
    subTypeId = json['subTypeId'];
    categoryId = json['categoryId'];
    priorityId = json['priorityId'];
    disciplineId = json['disciplineId'];
    isMasterInstruction = json['isMasterInstruction'];
    noOfStaff = json['noOfStaff'];
    estimatedLabourCost = json['estimatedLabourCost'];
    estimatedStockCost = json['estimatedStockCost'];
    estimatedTimeInMins = json['estimatedTimeInMins'];
    totalTimeInMins = json['totalTimeInMins'];
    isActive = json['isActive'];
    userId = json['userId'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classificationId'] = this.classificationId;
    data['typeId'] = this.typeId;
    data['subTypeId'] = this.subTypeId;
    data['categoryId'] = this.categoryId;
    data['priorityId'] = this.priorityId;
    data['disciplineId'] = this.disciplineId;
    data['isMasterInstruction'] = this.isMasterInstruction;
    data['noOfStaff'] = this.noOfStaff;
    data['estimatedLabourCost'] = this.estimatedLabourCost;
    data['estimatedStockCost'] = this.estimatedStockCost;
    data['estimatedTimeInMins'] = this.estimatedTimeInMins;
    data['totalTimeInMins'] = this.totalTimeInMins;
    data['isActive'] = this.isActive;
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Types {
  int? id;
  String? name;
  String? code;

  Types({this.id, this.name, this.code});

  Types.fromJson(Map<String, dynamic> json) {
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

class SubTypes {
  int? id;
  String? name;
  String? code;
  int? typeId;

  SubTypes({this.id, this.name, this.code, this.typeId});

  SubTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    typeId = json['typeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['typeId'] = this.typeId;
    return data;
  }
}

class SubTaskTypes {
  int? id;
  String? name;

  SubTaskTypes({this.id, this.name});

  SubTaskTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class TaskLogInfo {
  int? id;
  String? title;
  int? taskSlNo;
  String? securityInfoId;
  int? serviceTypeId;
  String? dueDate;
  int? reportedById;
  String? reportedByName;
  String? userId;
  String? reportedDate;
  int? typeId;
  int? subTypeId;
  int? categoryId;
  int? channelId;
  String? modeId;
  int? locId;
  String? locDate;
  String? summary;
  int? priorityId;
  int? faultCodeId;
  double? estimatedStockCost;
  double? estimatedLabourCost;
  int? estimatedTime;
  int? assetId;
  String? assetDescription;
  String? assetCode;
  String? assetName;
  bool? hasAsset;
  int? projectId;
  int? buildingId;
  int? floorId;
  int? unitId;
  int? roomId;
  int? reporterTypeId;
  int? reporterSubTypeId;
  String? mobileCode;
  String? mobileNo;
  String? emailAddress;
  int? statusId;
  int? taskInstructionId;
  int? ratingId;
  String? completionDate;
  int? feedbackUserId;
  String? feedbackComments;
  String? feedbackDate;
  String? signatureUrl;
  String? onHoldReason;
  String? onHoldDate;
  int? onHoldReasonId;
  String? loggedByEmail;
  String? loggedByDesignation;
  int? stPlannerId;
  int? stPlannerFreqId;
  String? refNumber;
  List<Locations>? locations;

  TaskLogInfo(
      {this.id,
        this.title,
        this.taskSlNo,
        this.securityInfoId,
        this.serviceTypeId,
        this.dueDate,
        this.reportedById,
        this.reportedByName,
        this.userId,
        this.reportedDate,
        this.typeId,
        this.subTypeId,
        this.categoryId,
        this.channelId,
        this.modeId,
        this.locId,
        this.locDate,
        this.summary,
        this.priorityId,
        this.faultCodeId,
        this.estimatedStockCost,
        this.estimatedLabourCost,
        this.estimatedTime,
        this.assetId,
        this.assetDescription,
        this.assetCode,
        this.assetName,
        this.hasAsset,
        this.projectId,
        this.buildingId,
        this.floorId,
        this.unitId,
        this.roomId,
        this.reporterTypeId,
        this.reporterSubTypeId,
        this.mobileCode,
        this.mobileNo,
        this.emailAddress,
        this.statusId,
        this.taskInstructionId,
        this.ratingId,
        this.completionDate,
        this.feedbackUserId,
        this.feedbackComments,
        this.feedbackDate,
        this.signatureUrl,
        this.onHoldReason,
        this.onHoldDate,
        this.onHoldReasonId,
        this.loggedByEmail,
        this.loggedByDesignation,
        this.stPlannerId,
        this.stPlannerFreqId,
        this.locations,
        this.refNumber,
      });

  TaskLogInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    taskSlNo = json['taskSlNo'];
    securityInfoId = json['securityInfoId'];
    serviceTypeId = json['serviceTypeId'];
    dueDate = json['dueDate'];
    reportedById = json['reportedById'];
    reportedByName = json['reportedByName'];
    userId = json['userId'];
    reportedDate = json['reportedDate'];
    typeId = json['typeId'];
    subTypeId = json['subTypeId'];
    categoryId = json['categoryId'];
    channelId = json['channelId'];
    modeId = json['modeId'];
    locId = json['locId'];
    locDate = json['locDate'];
    summary = json['summary'];
    priorityId = json['priorityId'];
    faultCodeId = json['faultCodeId'];
    estimatedStockCost = json['estimatedStockCost'];
    estimatedLabourCost = json['estimatedLabourCost'];
    estimatedTime = json['estimatedTime'];
    assetId = json['assetId'];
    assetDescription = json['assetDescription'];
    assetCode = json['assetCode'];
    assetName = json['assetName'];
    hasAsset = json['hasAsset'];
    projectId = json['projectId'];
    buildingId = json['buildingId'];
    floorId = json['floorId'];
    unitId = json['unitId'];
    roomId = json['roomId'];
    reporterTypeId = json['reporterTypeId'];
    reporterSubTypeId = json['reporterSubTypeId'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
    emailAddress = json['emailAddress'];
    statusId = json['statusId'];
    taskInstructionId = json['taskInstructionId'];
    ratingId = json['ratingId'];
    completionDate = json['completionDate'];
    feedbackUserId = json['feedbackUserId'];
    feedbackComments = json['feedbackComments'];
    feedbackDate = json['feedbackDate'];
    signatureUrl = json['signatureUrl'];
    onHoldReason = json['onHoldReason'];
    onHoldDate = json['onHoldDate'];
    onHoldReasonId = json['onHoldReasonId'];
    loggedByEmail = json['loggedByEmail'];
    loggedByDesignation = json['loggedByDesignation'];
    stPlannerId = json['stPlannerId'];
    stPlannerFreqId = json['stPlannerFreqId'];
    refNumber = json['refNumber'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['taskSlNo'] = this.taskSlNo;
    data['securityInfoId'] = this.securityInfoId;
    data['serviceTypeId'] = this.serviceTypeId;
    data['dueDate'] = this.dueDate;
    data['reportedById'] = this.reportedById;
    data['reportedByName'] = this.reportedByName;
    data['userId'] = this.userId;
    data['reportedDate'] = this.reportedDate;
    data['typeId'] = this.typeId;
    data['subTypeId'] = this.subTypeId;
    data['categoryId'] = this.categoryId;
    data['channelId'] = this.channelId;
    data['modeId'] = this.modeId;
    data['locId'] = this.locId;
    data['locDate'] = this.locDate;
    data['summary'] = this.summary;
    data['priorityId'] = this.priorityId;
    data['faultCodeId'] = this.faultCodeId;
    data['estimatedStockCost'] = this.estimatedStockCost;
    data['estimatedLabourCost'] = this.estimatedLabourCost;
    data['estimatedTime'] = this.estimatedTime;
    data['assetId'] = this.assetId;
    data['assetDescription'] = this.assetDescription;
    data['assetCode'] = this.assetCode;
    data['assetName'] = this.assetName;
    data['hasAsset'] = this.hasAsset;
    data['projectId'] = this.projectId;
    data['buildingId'] = this.buildingId;
    data['floorId'] = this.floorId;
    data['unitId'] = this.unitId;
    data['roomId'] = this.roomId;
    data['reporterTypeId'] = this.reporterTypeId;
    data['reporterSubTypeId'] = this.reporterSubTypeId;
    data['mobileCode'] = this.mobileCode;
    data['mobileNo'] = this.mobileNo;
    data['emailAddress'] = this.emailAddress;
    data['statusId'] = this.statusId;
    data['taskInstructionId'] = this.taskInstructionId;
    data['ratingId'] = this.ratingId;
    data['completionDate'] = this.completionDate;
    data['feedbackUserId'] = this.feedbackUserId;
    data['feedbackComments'] = this.feedbackComments;
    data['feedbackDate'] = this.feedbackDate;
    data['signatureUrl'] = this.signatureUrl;
    data['onHoldReason'] = this.onHoldReason;
    data['onHoldDate'] = this.onHoldDate;
    data['onHoldReasonId'] = this.onHoldReasonId;
    data['loggedByEmail'] = this.loggedByEmail;
    data['loggedByDesignation'] = this.loggedByDesignation;
    data['stPlannerId'] = this.stPlannerId;
    data['stPlannerFreqId'] = this.stPlannerFreqId;
    data['refNumber'] = this.refNumber;
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Categories {
  String? code;
  int? id;
  String? name;

  Categories({this.code, this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Channels {
  String? code;
  int? id;
  String? name;

  Channels({this.code, this.id, this.name});

  Channels.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SubTaskStatuses {
  int? id;
  String? name;

  SubTaskStatuses({this.id, this.name});

  SubTaskStatuses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class Locs {
  String? code;
  int? id;
  String? name;

  Locs({this.code, this.id, this.name});

  Locs.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Priorities {
  String? code;
  int? id;
  String? name;

  Priorities({this.code, this.id, this.name});

  Priorities.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class FaultCodes {
  String? code;
  int? id;
  String? name;

  FaultCodes({this.code, this.id, this.name});

  FaultCodes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class OnHoldReasons {
  String? code;
  int? id;
  String? name;

  OnHoldReasons({this.code, this.id, this.name});

  OnHoldReasons.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Locations {
  String? floorName;
  String? unitName;
  String? roomName;

  Locations({this.floorName, this.unitName, this.roomName});

  Locations.fromJson(Map<String, dynamic> json) {
    floorName = json['floorName'];
    unitName = json['unitName'];
    roomName = json['roomName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floorName'] = this.floorName;
    data['unitName'] = this.unitName;
    data['roomName'] = this.roomName;
    return data;
  }
}
class GetResourceModel {
  List<ResourcesModel>? resources;
  List<ResourceLanguages>? resourceLanguages;
 // List<ResourceSkillSets>? resourceSkillSets;
 // List<ResourceTypes>? resourceTypes;
  List<ResourceSubTypes>? resourceSubTypes;
//  List<Roles>? roles;
  List<Departments>? departments;
  List<Designations>? designations;
//  List<Divisions>? divisions;
  List<Vendors>? vendors;
  List<Clients>? clients;
  List<Countries>? countries;
  List<States>? states;
  List<Cities>? cities;
  List<Accounts>? accounts;

  GetResourceModel(
      {this.resources,
        this.resourceLanguages,
       /* this.resourceSkillSets,
        this.resourceTypes,*/
        this.resourceSubTypes,
      //  this.roles,
        this.departments,
        this.designations,
      //  this.divisions,
        this.vendors,
        this.clients,
        this.countries,
        this.states,
        this.cities,
        this.accounts});

  GetResourceModel.fromJson(Map<String, dynamic> json) {
    if (json['resources'] != null) {
      resources = <ResourcesModel>[];
      json['resources'].forEach((v) {
        resources!.add(new ResourcesModel.fromJson(v));
      });
    }
    if (json['resourceLanguages'] != null) {
      resourceLanguages = <ResourceLanguages>[];
      json['resourceLanguages'].forEach((v) {
        resourceLanguages!.add(new ResourceLanguages.fromJson(v));
      });
    }
    // if (json['resourceSkillSets'] != null) {
    //   resourceSkillSets = <ResourceSkillSets>[];
    //   json['resourceSkillSets'].forEach((v) {
    //     resourceSkillSets!.add(new ResourceSkillSets.fromJson(v));
    //   });
    // }
    // if (json['resourceTypes'] != null) {
    //   resourceTypes = <ResourceTypes>[];
    //   json['resourceTypes'].forEach((v) {
    //     resourceTypes!.add(new ResourceTypes.fromJson(v));
    //   });
    // }
    if (json['resourceSubTypes'] != null) {
      resourceSubTypes = <ResourceSubTypes>[];
      json['resourceSubTypes'].forEach((v) {
        resourceSubTypes!.add(new ResourceSubTypes.fromJson(v));
      });
    }
    // if (json['roles'] != null) {
    //   roles = <Roles>[];
    //   json['roles'].forEach((v) {
    //     roles!.add(new Roles.fromJson(v));
    //   });
    // }
    if (json['departments'] != null) {
      departments = <Departments>[];
      json['departments'].forEach((v) {
        departments!.add(new Departments.fromJson(v));
      });
    }
    if (json['designations'] != null) {
      designations = <Designations>[];
      json['designations'].forEach((v) {
        designations!.add(new Designations.fromJson(v));
      });
    }
    // if (json['divisions'] != null) {
    //   divisions = <Divisions>[];
    //   json['divisions'].forEach((v) {
    //     divisions!.add(new Divisions.fromJson(v));
    //   });
    // }
    if (json['vendors'] != null) {
      vendors = <Vendors>[];
      json['vendors'].forEach((v) {
        vendors!.add(new Vendors.fromJson(v));
      });
    }
    if (json['clients'] != null) {
      clients = <Clients>[];
      json['clients'].forEach((v) {
        clients!.add(new Clients.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(new Accounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resources != null) {
      data['resources'] = this.resources!.map((v) => v.toJson()).toList();
    }
    if (this.resourceLanguages != null) {
      data['resourceLanguages'] =
          this.resourceLanguages!.map((v) => v.toJson()).toList();
    }
    // if (this.resourceSkillSets != null) {
    //   data['resourceSkillSets'] =
    //       this.resourceSkillSets!.map((v) => v.toJson()).toList();
    // }
    // if (this.resourceTypes != null) {
    //   data['resourceTypes'] =
    //       this.resourceTypes!.map((v) => v.toJson()).toList();
    // }
    if (this.resourceSubTypes != null) {
      data['resourceSubTypes'] =
          this.resourceSubTypes!.map((v) => v.toJson()).toList();
    }
    // if (this.roles != null) {
    //   data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    // }
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    if (this.designations != null) {
      data['designations'] = this.designations!.map((v) => v.toJson()).toList();
    }
    // if (this.divisions != null) {
    //   data['divisions'] = this.divisions!.map((v) => v.toJson()).toList();
    // }
    if (this.vendors != null) {
      data['vendors'] = this.vendors!.map((v) => v.toJson()).toList();
    }
    if (this.clients != null) {
      data['clients'] = this.clients!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResourcesModel {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? name;
  String? mobileCode;
  String? mobileNo;
  String? email;
  bool? isAssignWork;
  bool? isMobileLoginAllowed;
  bool? isWebLoginAllowed;
  String? status;
  String? code;
  int? accountProfileId;
  int? designationId;
  String? designationName;
  int? departmentId;
  String? departmentName;
  int? divisionId;
  String? divisionName;
  String? skillSetIds;
  String? languageIds;
  int? roleId;
  String? roleName;
  int? roleAccessId;
  int? resourceTypeId;
  String? resourceTypeName;
  int? resourceSubTypeId;
  String? resourceSubTypeName;
  int? countryId;
  int? stateId;
  int? cityId;
  String? streetNo;
  String? streetName;
  String? landMark;
  String? postalCode;
  String? imageUrl;
  String? lastLoggedIn;
  String? image;
  int? clientOrVendorSourceId;

  ResourcesModel(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.name,
        this.mobileCode,
        this.mobileNo,
        this.email,
        this.isAssignWork,
        this.isMobileLoginAllowed,
        this.isWebLoginAllowed,
        this.status,
        this.code,
        this.accountProfileId,
        this.designationId,
        this.designationName,
        this.departmentId,
        this.departmentName,
        this.divisionId,
        this.divisionName,
        this.skillSetIds,
        this.languageIds,
        this.roleId,
        this.roleName,
        this.roleAccessId,
        this.resourceTypeId,
        this.resourceTypeName,
        this.resourceSubTypeId,
        this.resourceSubTypeName,
        this.countryId,
        this.stateId,
        this.cityId,
        this.streetNo,
        this.streetName,
        this.landMark,
        this.postalCode,
        this.imageUrl,
        this.lastLoggedIn,
        this.image,
        this.clientOrVendorSourceId});

  ResourcesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    name = json['name'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    isAssignWork = json['isAssignWork'];
    isMobileLoginAllowed = json['isMobileLoginAllowed'];
    isWebLoginAllowed = json['isWebLoginAllowed'];
    status = json['status'];
    code = json['code'];
    accountProfileId = json['accountProfileId'];
    designationId = json['designationId'];
    designationName = json['designationName'];
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    divisionId = json['divisionId'];
    divisionName = json['divisionName'];
    skillSetIds = json['skillSetIds'];
    languageIds = json['languageIds'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    roleAccessId = json['roleAccessId'];
    resourceTypeId = json['resourceTypeId'];
    resourceTypeName = json['resourceTypeName'];
    resourceSubTypeId = json['resourceSubTypeId'];
    resourceSubTypeName = json['resourceSubTypeName'];
    countryId = json['countryId'];
    stateId = json['stateId'];
    cityId = json['cityId'];
    streetNo = json['streetNo'];
    streetName = json['streetName'];
    landMark = json['landMark'];
    postalCode = json['postalCode'];
    imageUrl = json['imageUrl'];
    lastLoggedIn = json['lastLoggedIn'];
    image = json['image'];
    clientOrVendorSourceId = json['clientOrVendorSourceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['name'] = this.name;
    data['mobileCode'] = this.mobileCode;
    data['mobileNo'] = this.mobileNo;
    data['email'] = this.email;
    data['isAssignWork'] = this.isAssignWork;
    data['isMobileLoginAllowed'] = this.isMobileLoginAllowed;
    data['isWebLoginAllowed'] = this.isWebLoginAllowed;
    data['status'] = this.status;
    data['code'] = this.code;
    data['accountProfileId'] = this.accountProfileId;
    data['designationId'] = this.designationId;
    data['designationName'] = this.designationName;
    data['departmentId'] = this.departmentId;
    data['departmentName'] = this.departmentName;
    data['divisionId'] = this.divisionId;
    data['divisionName'] = this.divisionName;
    data['skillSetIds'] = this.skillSetIds;
    data['languageIds'] = this.languageIds;
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    data['roleAccessId'] = this.roleAccessId;
    data['resourceTypeId'] = this.resourceTypeId;
    data['resourceTypeName'] = this.resourceTypeName;
    data['resourceSubTypeId'] = this.resourceSubTypeId;
    data['resourceSubTypeName'] = this.resourceSubTypeName;
    data['countryId'] = this.countryId;
    data['stateId'] = this.stateId;
    data['cityId'] = this.cityId;
    data['streetNo'] = this.streetNo;
    data['streetName'] = this.streetName;
    data['landMark'] = this.landMark;
    data['postalCode'] = this.postalCode;
    data['imageUrl'] = this.imageUrl;
    data['lastLoggedIn'] = this.lastLoggedIn;
    data['image'] = this.image;
    data['clientOrVendorSourceId'] = this.clientOrVendorSourceId;
    return data;
  }
}

class ResourceLanguages {
  int? id;
  String? name;
  String? code;
  String? description;

  ResourceLanguages({this.id, this.name, this.code, this.description});

  ResourceLanguages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class ResourceSubTypes {
  int? resourceTypeId;
  int? id;
  String? name;
  String? code;
  String? description;

  ResourceSubTypes(
      {this.resourceTypeId, this.id, this.name, this.code, this.description});

  ResourceSubTypes.fromJson(Map<String, dynamic> json) {
    resourceTypeId = json['resourceTypeId'];
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceTypeId'] = this.resourceTypeId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class Departments {
  Null? divisionId;
  Null? divisionName;
  int? id;
  String? name;
  String? code;
  String? description;

  Departments(
      {this.divisionId,
        this.divisionName,
        this.id,
        this.name,
        this.code,
        this.description});

  Departments.fromJson(Map<String, dynamic> json) {
    divisionId = json['divisionId'];
    divisionName = json['divisionName'];
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['divisionId'] = this.divisionId;
    data['divisionName'] = this.divisionName;
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}

class Designations {
  int? id;
  String? name;
  String? code;

  Designations({this.id, this.name, this.code});

  Designations.fromJson(Map<String, dynamic> json) {
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

class Vendors {
  int? id;
  Null? uniqueId;
  Null? accountId;
  Null? imageUrl;
  Null? serviceTypeIds;
  Null? vendorTypeId;
  Null? vendorTypeName;
  String? code;
  Null? statusId;
  Null? statusName;
  Null? taxNo;
  String? name;
  Null? isPrimayVendor;
  Null? contactPerson;
  Null? contactPersonEmail;
  Null? contactPersonMobileCode;
  Null? contactPersonMobileNumber;
  Null? countryId;
  Null? countryName;
  Null? stateId;
  Null? stateName;
  Null? cityId;
  Null? cityName;
  Null? streetNo;
  Null? streetName;
  Null? landmark;
  Null? zipCode;
  Null? mainEmail;
  Null? mobileCode;
  Null? mobileNumber;
  Null? landLineCode;
  Null? landLineNumber;
  Null? faxNoCode;
  Null? faxNumber;
  Null? tollFreeNumber;
  Null? latitude;
  Null? longitude;
  Null? isActive;

  Vendors(
      {this.id,
        this.uniqueId,
        this.accountId,
        this.imageUrl,
        this.serviceTypeIds,
        this.vendorTypeId,
        this.vendorTypeName,
        this.code,
        this.statusId,
        this.statusName,
        this.taxNo,
        this.name,
        this.isPrimayVendor,
        this.contactPerson,
        this.contactPersonEmail,
        this.contactPersonMobileCode,
        this.contactPersonMobileNumber,
        this.countryId,
        this.countryName,
        this.stateId,
        this.stateName,
        this.cityId,
        this.cityName,
        this.streetNo,
        this.streetName,
        this.landmark,
        this.zipCode,
        this.mainEmail,
        this.mobileCode,
        this.mobileNumber,
        this.landLineCode,
        this.landLineNumber,
        this.faxNoCode,
        this.faxNumber,
        this.tollFreeNumber,
        this.latitude,
        this.longitude,
        this.isActive});

  Vendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['uniqueId'];
    accountId = json['accountId'];
    imageUrl = json['imageUrl'];
    serviceTypeIds = json['serviceTypeIds'];
    vendorTypeId = json['vendorTypeId'];
    vendorTypeName = json['vendorTypeName'];
    code = json['code'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    taxNo = json['taxNo'];
    name = json['name'];
    isPrimayVendor = json['isPrimayVendor'];
    contactPerson = json['contactPerson'];
    contactPersonEmail = json['contactPersonEmail'];
    contactPersonMobileCode = json['contactPersonMobileCode'];
    contactPersonMobileNumber = json['contactPersonMobileNumber'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    streetNo = json['streetNo'];
    streetName = json['streetName'];
    landmark = json['landmark'];
    zipCode = json['zipCode'];
    mainEmail = json['mainEmail'];
    mobileCode = json['mobileCode'];
    mobileNumber = json['mobileNumber'];
    landLineCode = json['landLineCode'];
    landLineNumber = json['landLineNumber'];
    faxNoCode = json['faxNoCode'];
    faxNumber = json['faxNumber'];
    tollFreeNumber = json['tollFreeNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uniqueId'] = this.uniqueId;
    data['accountId'] = this.accountId;
    data['imageUrl'] = this.imageUrl;
    data['serviceTypeIds'] = this.serviceTypeIds;
    data['vendorTypeId'] = this.vendorTypeId;
    data['vendorTypeName'] = this.vendorTypeName;
    data['code'] = this.code;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['taxNo'] = this.taxNo;
    data['name'] = this.name;
    data['isPrimayVendor'] = this.isPrimayVendor;
    data['contactPerson'] = this.contactPerson;
    data['contactPersonEmail'] = this.contactPersonEmail;
    data['contactPersonMobileCode'] = this.contactPersonMobileCode;
    data['contactPersonMobileNumber'] = this.contactPersonMobileNumber;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['streetNo'] = this.streetNo;
    data['streetName'] = this.streetName;
    data['landmark'] = this.landmark;
    data['zipCode'] = this.zipCode;
    data['mainEmail'] = this.mainEmail;
    data['mobileCode'] = this.mobileCode;
    data['mobileNumber'] = this.mobileNumber;
    data['landLineCode'] = this.landLineCode;
    data['landLineNumber'] = this.landLineNumber;
    data['faxNoCode'] = this.faxNoCode;
    data['faxNumber'] = this.faxNumber;
    data['tollFreeNumber'] = this.tollFreeNumber;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isActive'] = this.isActive;
    return data;
  }
}

class Clients {
  int? id;
  String? name;
  String? code;
  Null? taxNo;
  int? countryId;
  Null? countryName;
  int? stateId;
  Null? stateName;
  int? cityId;
  Null? cityName;
  Null? streetNo;
  Null? streetName;
  Null? landmark;
  Null? zipCode;
  Null? emailAddress;
  Null? mobileCode;
  Null? mobileNo;
  Null? faxCode;
  Null? faxNo;
  Null? statusId;
  Null? statusName;

  Clients(
      {this.id,
        this.name,
        this.code,
        this.taxNo,
        this.countryId,
        this.countryName,
        this.stateId,
        this.stateName,
        this.cityId,
        this.cityName,
        this.streetNo,
        this.streetName,
        this.landmark,
        this.zipCode,
        this.emailAddress,
        this.mobileCode,
        this.mobileNo,
        this.faxCode,
        this.faxNo,
        this.statusId,
        this.statusName});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    taxNo = json['taxNo'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    streetNo = json['streetNo'];
    streetName = json['streetName'];
    landmark = json['landmark'];
    zipCode = json['zipCode'];
    emailAddress = json['emailAddress'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
    faxCode = json['faxCode'];
    faxNo = json['faxNo'];
    statusId = json['statusId'];
    statusName = json['statusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['taxNo'] = this.taxNo;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['streetNo'] = this.streetNo;
    data['streetName'] = this.streetName;
    data['landmark'] = this.landmark;
    data['zipCode'] = this.zipCode;
    data['emailAddress'] = this.emailAddress;
    data['mobileCode'] = this.mobileCode;
    data['mobileNo'] = this.mobileNo;
    data['faxCode'] = this.faxCode;
    data['faxNo'] = this.faxNo;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    return data;
  }
}

class Countries {
  int? id;
  String? name;
  String? dialCode;
  String? code;
  String? shortCode;
  String? currency;
  String? timeZone;
  String? nationality;
  String? refNo1;
  String? refNo2;
  double? latitude;
  double? longitude;
  String? flag;

  Countries(
      {this.id,
        this.name,
        this.dialCode,
        this.code,
        this.shortCode,
        this.currency,
        this.timeZone,
        this.nationality,
        this.refNo1,
        this.refNo2,
        this.latitude,
        this.longitude,
        this.flag});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dialCode = json['dialCode'];
    code = json['code'];
    shortCode = json['shortCode'];
    currency = json['currency'];
    timeZone = json['timeZone'];
    nationality = json['nationality'];
    refNo1 = json['refNo1'];
    refNo2 = json['refNo2'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dialCode'] = this.dialCode;
    data['code'] = this.code;
    data['shortCode'] = this.shortCode;
    data['currency'] = this.currency;
    data['timeZone'] = this.timeZone;
    data['nationality'] = this.nationality;
    data['refNo1'] = this.refNo1;
    data['refNo2'] = this.refNo2;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['flag'] = this.flag;
    return data;
  }
}

class States {
  int? id;
  String? name;
  String? code;
  String? dialCode;
  double? latitude;
  double? longitude;
  int? countryId;
  String? countryName;

  States(
      {this.id,
        this.name,
        this.code,
        this.dialCode,
        this.latitude,
        this.longitude,
        this.countryId,
        this.countryName});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    dialCode = json['dialCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    countryId = json['countryId'];
    countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['dialCode'] = this.dialCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    return data;
  }
}

class Cities {
  int? id;
  String? name;
  String? code;
  String? dialCode;
  double? latitude;
  double? longitude;
  int? countryId;
  String? countryName;
  int? stateId;
  String? stateName;
  String? pinCode;

  Cities(
      {this.id,
        this.name,
        this.code,
        this.dialCode,
        this.latitude,
        this.longitude,
        this.countryId,
        this.countryName,
        this.stateId,
        this.stateName,
        this.pinCode});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    dialCode = json['dialCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['dialCode'] = this.dialCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['pinCode'] = this.pinCode;
    return data;
  }
}

class Accounts {
  int? id;
  Null? imageUrl;
  Null? shortImageUrl;
  String? code;
  String? name;
  Null? cityId;
  Null? utcTimeZoneDiff;
  int? utcDiffInMins;
  Null? currencyCode;

  Accounts(
      {this.id,
        this.imageUrl,
        this.shortImageUrl,
        this.code,
        this.name,
        this.cityId,
        this.utcTimeZoneDiff,
        this.utcDiffInMins,
        this.currencyCode});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    shortImageUrl = json['shortImageUrl'];
    code = json['code'];
    name = json['name'];
    cityId = json['cityId'];
    utcTimeZoneDiff = json['utcTimeZoneDiff'];
    utcDiffInMins = json['utcDiffInMins'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['shortImageUrl'] = this.shortImageUrl;
    data['code'] = this.code;
    data['name'] = this.name;
    data['cityId'] = this.cityId;
    data['utcTimeZoneDiff'] = this.utcTimeZoneDiff;
    data['utcDiffInMins'] = this.utcDiffInMins;
    data['currencyCode'] = this.currencyCode;
    return data;
  }
}

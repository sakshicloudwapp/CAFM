class AutogeneratedResponse {
  List<Buildings>? buildings;
  List<FloorsModel>? floors;
  List<Units>? units;
  List<Rooms>? rooms;
  List<ReporterTypes>? reporterTypes;
  List<ReporterSubTypes>? reporterSubTypes;
  List<Resources>? resources;
  List<CountryCodes>? countryCodes;

  AutogeneratedResponse(
      {this.buildings,
        this.floors,
        this.units,
        this.rooms,
        this.reporterTypes,
        this.reporterSubTypes,
        this.resources,
        this.countryCodes});

  AutogeneratedResponse.fromJson(Map<String, dynamic> json) {
    if (json['buildings'] != null) {
      buildings = <Buildings>[];
      json['buildings'].forEach((v) {
        buildings!.add(new Buildings.fromJson(v));
      });
    }
    if (json['floors'] != null) {
      floors = <FloorsModel>[];
      json['floors'].forEach((v) {
        floors!.add(new FloorsModel.fromJson(v));
      });
    }
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
    if (json['reporterTypes'] != null) {
      reporterTypes = <ReporterTypes>[];
      json['reporterTypes'].forEach((v) {
        reporterTypes!.add(new ReporterTypes.fromJson(v));
      });
    }
    if (json['reporterSubTypes'] != null) {
      reporterSubTypes = <ReporterSubTypes>[];
      json['reporterSubTypes'].forEach((v) {
        reporterSubTypes!.add(new ReporterSubTypes.fromJson(v));
      });
    }
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources!.add(new Resources.fromJson(v));
      });
    }
    if (json['countryCodes'] != null) {
      countryCodes = <CountryCodes>[];
      json['countryCodes'].forEach((v) {
        countryCodes!.add(new CountryCodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.buildings != null) {
      data['buildings'] = this.buildings!.map((v) => v.toJson()).toList();
    }
    if (this.floors != null) {
      data['floors'] = this.floors!.map((v) => v.toJson()).toList();
    }
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    if (this.reporterTypes != null) {
      data['reporterTypes'] =
          this.reporterTypes!.map((v) => v.toJson()).toList();
    }
    if (this.reporterSubTypes != null) {
      data['reporterSubTypes'] =
          this.reporterSubTypes!.map((v) => v.toJson()).toList();
    }
    if (this.resources != null) {
      data['resources'] = this.resources!.map((v) => v.toJson()).toList();
    }
    if (this.countryCodes != null) {
      data['countryCodes'] = this.countryCodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buildings {
  int? id;
  String? name;
  String? code;

  Buildings({this.id, this.name, this.code});

  Buildings.fromJson(Map<String, dynamic> json) {
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


class FloorsModel {
  int? id;
  String? name;
  String? code;

  FloorsModel({this.id, this.name, this.code});

  FloorsModel.fromJson(Map<String, dynamic> json) {
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



class Units {
  int? id;
  String? name;
  String? code;
  int? buildingId;

  Units({this.id, this.name, this.code, this.buildingId});

  Units.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    buildingId = json['buildingId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['buildingId'] = this.buildingId;
    return data;
  }
}

class Resources {
  int? id;
  String? name;
  String? code;
  String? designation;
  String? email;
  String? mobileCode;
  String? mobileNo;

  Resources(
      {this.id,
        this.name,
        this.code,
        this.designation,
        this.email,
        this.mobileCode,
        this.mobileNo});

  Resources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    designation = json['designation'];
    email = json['email'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
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
    return data;
  }
}

class Rooms {
  int? id;
  String? name;
  String? code;
  int? unitId;

  Rooms({this.id, this.name, this.code, this.unitId});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    unitId = json['unitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['unitId'] = this.unitId;
    return data;
  }
}

class ReporterTypes {
  int? id;
  String? name;

  ReporterTypes({this.id, this.name});

  ReporterTypes.fromJson(Map<String, dynamic> json) {
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

class ReporterSubTypes {
  int? id;
  String? name;
  int? reporterTypeId;
  bool? isSelectable;

  ReporterSubTypes(
      {this.id, this.name, this.reporterTypeId, this.isSelectable});

  ReporterSubTypes.fromJson(Map<String, dynamic> json) {
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

class CountryCodes {
  int? id;
  String? name;
  String? mobileCode;

  CountryCodes({this.id, this.name, this.mobileCode});

  CountryCodes.fromJson(Map<String, dynamic> json) {
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
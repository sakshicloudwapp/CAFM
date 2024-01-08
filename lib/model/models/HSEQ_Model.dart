class HseqModel {
  Configuration? configuration;
  Actions? actions;
  List<HseqDataModel>? data;

  HseqModel({this.configuration, this.actions, this.data});

  HseqModel.fromJson(Map<String, dynamic> json) {
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
    actions =
    json['actions'] != null ? new Actions.fromJson(json['actions']) : null;
    if (json['data'] != null) {
      data = <HseqDataModel>[];
      json['data'].forEach((v) {
        data!.add(new HseqDataModel.fromJson(v));
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
  EditConfig? editConfig;

  Columns(
      {this.displayText,
        this.showSort,
        this.mappingColumn,
        this.showColumn,
        this.isRequired,
        this.editConfig});

  Columns.fromJson(Map<String, dynamic> json) {
    displayText = json['displayText'];
    showSort = json['showSort'];
    mappingColumn = json['mappingColumn'];
    showColumn = json['showColumn'];
    isRequired = json['isRequired'];
    editConfig = json['editConfig'] != null
        ? new EditConfig.fromJson(json['editConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayText'] = this.displayText;
    data['showSort'] = this.showSort;
    data['mappingColumn'] = this.mappingColumn;
    data['showColumn'] = this.showColumn;
    data['isRequired'] = this.isRequired;
    if (this.editConfig != null) {
      data['editConfig'] = this.editConfig!.toJson();
    }
    return data;
  }
}

class EditConfig {
  String? fieldType;
  String? mappingData;
  bool? showField;
  bool? isReadOnly;
  String? mappingField;

  EditConfig(
      {this.fieldType,
        this.mappingData,
        this.showField,
        this.isReadOnly,
        this.mappingField});

  EditConfig.fromJson(Map<String, dynamic> json) {
    fieldType = json['fieldType'];
    mappingData = json['mappingData'];
    showField = json['showField'];
    isReadOnly = json['isReadOnly'];
    mappingField = json['mappingField'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldType'] = this.fieldType;
    data['mappingData'] = this.mappingData;
    data['showField'] = this.showField;
    data['isReadOnly'] = this.isReadOnly;
    data['mappingField'] = this.mappingField;
    return data;
  }
}

class Actions {
  bool? canAdd;
  bool? canEdit;
  bool? canDelete;
  bool? canSelect;

  Actions({this.canAdd, this.canEdit, this.canDelete, this.canSelect});

  Actions.fromJson(Map<String, dynamic> json) {
    canAdd = json['canAdd'];
    canEdit = json['canEdit'];
    canDelete = json['canDelete'];
    canSelect = json['canSelect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canAdd'] = this.canAdd;
    data['canEdit'] = this.canEdit;
    data['canDelete'] = this.canDelete;
    data['canSelect'] = this.canSelect;
    return data;
  }
}

class HseqDataModel {
  int? id;
  String? name;
  int? questionTypeId;
  String? questionTypeName;

  HseqDataModel({this.id, this.name, this.questionTypeId, this.questionTypeName});

  HseqDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    questionTypeId = json['questionTypeId'];
    questionTypeName = json['questionTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['questionTypeId'] = this.questionTypeId;
    data['questionTypeName'] = this.questionTypeName;
    return data;
  }
}
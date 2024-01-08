class AdditionalInfoResponse {
  SubTasks? subTasks;
  List<DocumentsDetailModel>? documents;
  List<ImagesDetailModel>? images;
  MasterResources? masterResources;
  List<TaskResourcesModel>? taskResources;
  HseqListItems? hseqListItems;
  CheckListItems? checkListItems;
  MasterResources? performanceMetrics;
  List<Emails>? emails;

  AdditionalInfoResponse(
      {this.subTasks,
        this.documents,
        this.images,
        this.masterResources,
        this.taskResources,
        this.hseqListItems,
        this.checkListItems,
        this.performanceMetrics,
        this.emails});

  AdditionalInfoResponse.fromJson(Map<String, dynamic> json) {
    subTasks = json['subTasks'] != null
        ? new SubTasks.fromJson(json['subTasks'])
        : null;
    if (json['documents'] != null) {
      documents = <DocumentsDetailModel>[];
      json['documents'].forEach((v) {
        documents!.add(new DocumentsDetailModel.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <ImagesDetailModel>[];
      json['images'].forEach((v) {
        images!.add(new ImagesDetailModel.fromJson(v));
      });
    }
    masterResources = json['masterResources'] != null
        ? new MasterResources.fromJson(json['masterResources'])
        : null;
    if (json['taskResources'] != null) {
      taskResources = <TaskResourcesModel>[];
      json['taskResources'].forEach((v) {
        taskResources!.add(new TaskResourcesModel.fromJson(v));
      });
    }
    hseqListItems = json['hseqListItems'] != null
        ? new HseqListItems.fromJson(json['hseqListItems'])
        : null;
    checkListItems = json['checkListItems'] != null
        ? new CheckListItems.fromJson(json['checkListItems'])
        : null;
    performanceMetrics = json['performanceMetrics'] != null
        ? new MasterResources.fromJson(json['performanceMetrics'])
        : null;
    if (json['emails'] != null) {
      emails = <Emails>[];
      json['emails'].forEach((v) {
        emails!.add(new Emails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subTasks != null) {
      data['subTasks'] = this.subTasks!.toJson();
    }
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.masterResources != null) {
      data['masterResources'] = this.masterResources!.toJson();
    }
    if (this.taskResources != null) {
      data['taskResources'] =
          this.taskResources!.map((v) => v.toJson()).toList();
    }
    if (this.hseqListItems != null) {
      data['hseqListItems'] = this.hseqListItems!.toJson();
    }
    if (this.checkListItems != null) {
      data['checkListItems'] = this.checkListItems!.toJson();
    }
    if (this.performanceMetrics != null) {
      data['performanceMetrics'] = this.performanceMetrics!.toJson();
    }
    if (this.emails != null) {
      data['emails'] = this.emails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubTasks {
  Configuration? configuration;
  Actions? actions;
  Null? data;

  SubTasks({this.configuration, this.actions, this.data});

  SubTasks.fromJson(Map<String, dynamic> json) {
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
    actions =
    json['actions'] != null ? new Actions.fromJson(json['actions']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.configuration != null) {
      data['configuration'] = this.configuration!.toJson();
    }
    if (this.actions != null) {
      data['actions'] = this.actions!.toJson();
    }
    data['data'] = this.data;
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
  EditConfig? editConfig;

  Columns(
      {this.displayText,
        this.showSort,
        this.mappingColumn,
        this.showColumn,
        this.isRequired,
        this.columnFormat,
        this.editConfig});

  Columns.fromJson(Map<String, dynamic> json) {
    displayText = json['displayText'];
    showSort = json['showSort'];
    mappingColumn = json['mappingColumn'];
    showColumn = json['showColumn'];
    isRequired = json['isRequired'];
    columnFormat = json['columnFormat'];
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
    data['columnFormat'] = this.columnFormat;
    // if (this.editConfig != null) {
    //   data['editConfig'] = this.editConfig!.toJson();
    // }
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

class MasterResources {
  Configuration? configuration;
  Actions? actions;
  List<Data>? data;

  MasterResources({this.configuration, this.actions, this.data});

  MasterResources.fromJson(Map<String, dynamic> json) {
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
    actions =
    json['actions'] != null ? new Actions.fromJson(json['actions']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

// class Columns {
//   String? displayText;
//   bool? showSort;
//   String? mappingColumn;
//   bool? showColumn;
//   bool? isRequired;
//   int? columnFormat;
//
//   Columns(
//       {this.displayText,
//         this.showSort,
//         this.mappingColumn,
//         this.showColumn,
//         this.isRequired,
//         this.columnFormat});
//
//   Columns.fromJson(Map<String, dynamic> json) {
//     displayText = json['displayText'];
//     showSort = json['showSort'];
//     mappingColumn = json['mappingColumn'];
//     showColumn = json['showColumn'];
//     isRequired = json['isRequired'];
//     columnFormat = json['columnFormat'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['displayText'] = this.displayText;
//     data['showSort'] = this.showSort;
//     data['mappingColumn'] = this.mappingColumn;
//     data['showColumn'] = this.showColumn;
//     data['isRequired'] = this.isRequired;
//     data['columnFormat'] = this.columnFormat;
//     return data;
//   }
// }

class Data {
  int? id;
  String? name;
  String? designation;
  String? email;
  String? mobileCode;
  String? mobileNo;
  bool? isChecked = false;

  Data(
      {this.id,
        this.name,
        this.designation,
        this.email,
        this.mobileCode,
        this.mobileNo,this.isChecked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    designation = json['designation'];
    email = json['email'];
    mobileCode = json['mobileCode'];
    mobileNo = json['mobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['mobileCode'] = this.mobileCode;
    data['mobileNo'] = this.mobileNo;
    return data;
  }
}

class TaskResourcesModel {
  int? id;
  int? resourceId;
  String? resourceName;
  String? designation;
  int? workStatusId;
  String? assignedDate;
  String? acceptedDate;
  String? rejectedDate;
  String? startedDate;
  String? finishedDate;
  String? comments;
  String? containDate;


  TaskResourcesModel(
      {this.id,
        this.resourceId,
        this.resourceName,
        this.designation,
        this.workStatusId,
        this.assignedDate,
        this.acceptedDate,
        this.rejectedDate,
        this.startedDate,
        this.finishedDate,
        this.comments,
      this.containDate});

  TaskResourcesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceId = json['resourceId'];
    resourceName = json['resourceName'];
    designation = json['designation'];
    workStatusId = json['workStatusId'];
    assignedDate = json['assignedDate'];
    acceptedDate = json['acceptedDate'];
    rejectedDate = json['rejectedDate'];
    startedDate = json['startedDate'];
    finishedDate = json['finishedDate'];
    comments = json['comments'];
    containDate = json['containDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['resourceId'] = this.resourceId;
    data['resourceName'] = this.resourceName;
    data['designation'] = this.designation;
    data['workStatusId'] = this.workStatusId;
    data['assignedDate'] = this.assignedDate;
    data['acceptedDate'] = this.acceptedDate;
    data['rejectedDate'] = this.rejectedDate;
    data['startedDate'] = this.startedDate;
    data['finishedDate'] = this.finishedDate;
    data['comments'] = this.comments;
    data['containDate'] = this.containDate;
    return data;
  }
}

class HseqListItems {
  List<Questions>? questions;
  List<Answers>? answers;
  List<QuestionAnswers>? questionAnswers;

  HseqListItems({this.questions, this.answers, this.questionAnswers});

  HseqListItems.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    if (json['questionAnswers'] != null) {
      questionAnswers = <QuestionAnswers>[];
      json['questionAnswers'].forEach((v) {
        questionAnswers!.add(new QuestionAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    if (this.questionAnswers != null) {
      data['questionAnswers'] =
          this.questionAnswers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  int? id;
  String? questionName;

  Questions({this.id, this.questionName});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionName = json['questionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questionName'] = this.questionName;
    return data;
  }
}

class Answers {
  int? id;
  int? answerId;
  String? answerName;

  Answers({this.id, this.answerId, this.answerName});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answerId = json['answerId'];
    answerName = json['answerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answerId'] = this.answerId;
    data['answerName'] = this.answerName;
    return data;
  }
}

class QuestionAnswers {
  int? taskLogId;
  bool? isCheckListItem;
  int? linkId;
  int? answerId;
  String? comments;
  String? imageUrl;

  QuestionAnswers(
      {this.taskLogId,
        this.isCheckListItem,
        this.linkId,
        this.answerId,
        this.comments,
        this.imageUrl});

  QuestionAnswers.fromJson(Map<String, dynamic> json) {
    taskLogId = json['taskLogId'];
    isCheckListItem = json['isCheckListItem'];
    linkId = json['linkId'];
    answerId = json['answerId'];
    comments = json['comments'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskLogId'] = this.taskLogId;
    data['isCheckListItem'] = this.isCheckListItem;
    data['linkId'] = this.linkId;
    data['answerId'] = this.answerId;
    data['comments'] = this.comments;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class CheckListItems {
  List<ChecklistQuestions>? questions;
  List<ChecklistAnswers>? answers;
  List<ChecklistQuestionAnswers>? questionAnswers;

  CheckListItems({this.questions, this.answers, this.questionAnswers});

  CheckListItems.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <ChecklistQuestions>[];
      json['questions'].forEach((v) {
        questions!.add(new ChecklistQuestions.fromJson(v));
      });
    }
    if (json['answers'] != null) {
      answers = <ChecklistAnswers>[];
      json['answers'].forEach((v) {
        answers!.add(new ChecklistAnswers.fromJson(v));
      });
    }
    if (json['questionAnswers'] != null) {
      questionAnswers = <ChecklistQuestionAnswers>[];
      json['questionAnswers'].forEach((v) {
        questionAnswers!.add(new ChecklistQuestionAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    if (this.questionAnswers != null) {
      data['questionAnswers'] =
          this.questionAnswers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


// class QuestionAnswers {
//   int? taskLogId;
//   bool? isCheckListItem;
//   int? linkId;
//   int? answerId;
//   String? comments;
//   String? imageUrl;
//
//   QuestionAnswers(
//       {this.taskLogId,
//         this.isCheckListItem,
//         this.linkId,
//         this.answerId,
//         this.comments,
//         this.imageUrl});
//
//   QuestionAnswers.fromJson(Map<String, dynamic> json) {
//     taskLogId = json['taskLogId'];
//     isCheckListItem = json['isCheckListItem'];
//     linkId = json['linkId'];
//     answerId = json['answerId'];
//     comments = json['comments'];
//     imageUrl = json['imageUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['taskLogId'] = this.taskLogId;
//     data['isCheckListItem'] = this.isCheckListItem;
//     data['linkId'] = this.linkId;
//     data['answerId'] = this.answerId;
//     data['comments'] = this.comments;
//     data['imageUrl'] = this.imageUrl;
//     return data;
//   }
// }

class ChecklistQuestions {
  int? id;
  String? code;
  String? questionName;
  String? standardName;
  String? groupName;
  bool? ischecked = true;

  ChecklistQuestions(
      {this.id,
        this.code,
        this.questionName,
        this.standardName,
        this.groupName,
      this.ischecked});

  ChecklistQuestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    questionName = json['questionName'];
    standardName = json['standardName'];
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['questionName'] = this.questionName;
    data['standardName'] = this.standardName;
    data['groupName'] = this.groupName;
    return data;
  }
}

class ChecklistAnswers {
  int? id;
  int? answerId;
  String? answerName;

  ChecklistAnswers({this.id, this.answerId, this.answerName});

  ChecklistAnswers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answerId = json['answerId'];
    answerName = json['answerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answerId'] = this.answerId;
    data['answerName'] = this.answerName;
    return data;
  }
}


class ChecklistQuestionAnswers {
  int? taskLogId;
  bool? isCheckListItem;
  int? linkId;
  int? answerId;
  String? comments;
  String? imageUrl;

  ChecklistQuestionAnswers(
      {this.taskLogId,
        this.isCheckListItem,
        this.linkId,
        this.answerId,
        this.comments,
        this.imageUrl});

  ChecklistQuestionAnswers.fromJson(Map<String, dynamic> json) {
    taskLogId = json['taskLogId'];
    isCheckListItem = json['isCheckListItem'];
    linkId = json['linkId'];
    answerId = json['answerId'];
    comments = json['comments'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskLogId'] = this.taskLogId;
    data['isCheckListItem'] = this.isCheckListItem;
    data['linkId'] = this.linkId;
    data['answerId'] = this.answerId;
    data['comments'] = this.comments;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
class DataModel {
  String? activityName;
  String? slaDate;
  String? actualDate;
  String? timeVariation;

  DataModel({this.activityName, this.slaDate, this.actualDate, this.timeVariation});

  DataModel.fromJson(Map<String, dynamic> json) {
    activityName = json['activityName'];
    slaDate = json['slaDate'];
    actualDate = json['actualDate'];
    timeVariation = json['timeVariation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activityName'] = this.activityName;
    data['slaDate'] = this.slaDate;
    data['actualDate'] = this.actualDate;
    data['timeVariation'] = this.timeVariation;
    return data;
  }
}

class Emails {
  String? body;
  String? subject;
  String? fromEmail;
  String? toEmail;
  String? sentDate;

  Emails(
      {this.body, this.subject, this.fromEmail, this.toEmail, this.sentDate});

  Emails.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    subject = json['subject'];
    fromEmail = json['fromEmail'];
    toEmail = json['toEmail'];
    sentDate = json['sentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['subject'] = this.subject;
    data['fromEmail'] = this.fromEmail;
    data['toEmail'] = this.toEmail;
    data['sentDate'] = this.sentDate;
    return data;
  }
}

class ImagesDetailModel {
  int? taskLogId;
  bool? isBeforeImage;
  int? id;
  String? resourceUrl;
  String? fileName;
  String? extension;

  ImagesDetailModel(
      {this.taskLogId,
        this.isBeforeImage,
        this.id,
        this.resourceUrl,
        this.fileName,
        this.extension});

  ImagesDetailModel.fromJson(Map<String, dynamic> json) {
    taskLogId = json['taskLogId'];
    isBeforeImage = json['isBeforeImage'];
    id = json['id'];
    resourceUrl = json['resourceUrl'];
    fileName = json['fileName'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskLogId'] = this.taskLogId;
    data['isBeforeImage'] = this.isBeforeImage;
    data['id'] = this.id;
    data['resourceUrl'] = this.resourceUrl;
    data['fileName'] = this.fileName;
    data['extension'] = this.extension;
    return data;
  }
}

class DocumentsDetailModel {
  int? taskLogId;
  bool? isBeforeImage;
  int? id;
  String? resourceUrl;
  String? fileName;
  String? extension;

  DocumentsDetailModel(
      {this.taskLogId,
        this.isBeforeImage,
        this.id,
        this.resourceUrl,
        this.fileName,
        this.extension});

  DocumentsDetailModel.fromJson(Map<String, dynamic> json) {
    taskLogId = json['taskLogId'];
    isBeforeImage = json['isBeforeImage'];
    id = json['id'];
    resourceUrl = json['resourceUrl'];
    fileName = json['fileName'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskLogId'] = this.taskLogId;
    data['isBeforeImage'] = this.isBeforeImage;
    data['id'] = this.id;
    data['resourceUrl'] = this.resourceUrl;
    data['fileName'] = this.fileName;
    data['extension'] = this.extension;
    return data;
  }
}

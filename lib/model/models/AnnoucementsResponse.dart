
class AnnouncementModel {
  int? id;
  String? title;
  String? content;
  String? code;
  String? createdDate;
  String? fileUrl;
  int? attachmentGroup;
  String? referenceNo;
  String? issueDate;
  String? expiredOn;
  String? status;

  AnnouncementModel(
      {this.id,
        this.title,
        this.content,
        this.code,
        this.createdDate,
        this.fileUrl,
        this.attachmentGroup,
        this.referenceNo,
        this.issueDate,
        this.expiredOn,
        this.status});


  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    code = json['code'];
    createdDate = json['createdDate'];
    fileUrl = json['fileUrl'];
    attachmentGroup = json['attachmentGroup'];
    referenceNo = json['referenceNo'];
    issueDate = json['issueDate'];
    expiredOn = json['expiredOn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['code'] = this.code;
    data['createdDate'] = this.createdDate;
    data['fileUrl'] = this.fileUrl;
    data['attachmentGroup'] = this.attachmentGroup;
    data['referenceNo'] = this.referenceNo;
    data['issueDate'] = this.issueDate;
    data['expiredOn'] = this.expiredOn;
    data['status'] = this.status;
    return data;
  }
}

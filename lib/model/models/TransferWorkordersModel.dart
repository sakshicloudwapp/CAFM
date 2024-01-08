class TransferWorkordersModel {
  bool? isSuccess;
  String? message;
  String? id;

  TransferWorkordersModel({this.isSuccess, this.message, this.id});

  TransferWorkordersModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['id'] = this.id;
    return data;
  }
}
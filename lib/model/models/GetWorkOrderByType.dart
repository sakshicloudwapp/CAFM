class GetWorkOrderByTypeModel {
  String? title;
  String? subTitle;
  int? sortOrder;
  String? iconName;
  int? value;
  int? statusId;

  GetWorkOrderByTypeModel(
      {this.title,
        this.subTitle,
        this.sortOrder,
        this.iconName,
        this.value,
        this.statusId});

  GetWorkOrderByTypeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    sortOrder = json['sortOrder'];
    iconName = json['iconName'];
    value = json['value'];
    statusId = json['StatusId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['sortOrder'] = this.sortOrder;
    data['iconName'] = this.iconName;
    data['value'] = this.value;
    data['StatusId'] = this.statusId;
    return data;
  }
}

//
// class GetWorkOrderTypeModel {
//   bool? status;
//   GetWorkOrderTypeDataModel? data;
//   String? message;
//
//   GetWorkOrderTypeModel({this.status, this.data, this.message});
//
//   GetWorkOrderTypeModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? new GetWorkOrderTypeDataModel.fromJson(json['data']) : null;
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class GetWorkOrderTypeDataModel {
//   int? totalPage;
//   List<Items>? items;
//
//   GetWorkOrderTypeDataModel({this.totalPage, this.items});
//
//   GetWorkOrderTypeDataModel.fromJson(Map<String, dynamic> json) {
//     totalPage = json['total_page'];
//     if (json['items'] != null) {
//       items = <GetWorkOrderTypeItemsModel>[];
//       json['items'].forEach((v) {
//         items!.add(new Items.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total_page'] = this.totalPage;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class GetWorkOrderTypeItemsModel {
//   int? id;
//   String? senderId;
//   String? receiverId;
//   String? content;
//   String? seen;
//   String? type;
//   String? timestamp;
//   String? createdAt;
//   String? receiverid;
//   String? receiverImage;
//   String? name;
//   String? isClient;
//
//   GetWorkOrderTypeItemsModel(
//       {this.id,
//         this.senderId,
//         this.receiverId,
//         this.content,
//         this.seen,
//         this.type,
//         this.timestamp,
//         this.createdAt,
//         this.receiverid,
//         this.receiverImage,
//         this.name,
//         this.isClient});
//
//   GetWorkOrderTypeItemsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     senderId = json['sender_id'];
//     receiverId = json['receiver_id'];
//     content = json['content'];
//     seen = json['seen'];
//     type = json['type'];
//     timestamp = json['timestamp'];
//     createdAt = json['created_at'];
//     receiverid = json['receiverid'];
//     receiverImage = json['receiver_image'];
//     name = json['name'];
//     isClient = json['is_client'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['sender_id'] = this.senderId;
//     data['receiver_id'] = this.receiverId;
//     data['content'] = this.content;
//     data['seen'] = this.seen;
//     data['type'] = this.type;
//     data['timestamp'] = this.timestamp;
//     data['created_at'] = this.createdAt;
//     data['receiverid'] = this.receiverid;
//     data['receiver_image'] = this.receiverImage;
//     data['name'] = this.name;
//     data['is_client'] = this.isClient;
//     return data;
//   }
// }
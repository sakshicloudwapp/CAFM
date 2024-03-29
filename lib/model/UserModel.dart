class UserModel {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? userName;
  String? issued;
  String? expires;
  String? name;
  String? designation;
  String? imageUrl;
  String? accountName;
  String? timeZone;
  bool? isBlueCollar;

  UserModel(
      {this.accessToken,
        this.tokenType,
        this.expiresIn,
        this.userName,
        this.issued,
        this.expires,
        this.name,
        this.designation,
        this.imageUrl,
        this.accountName,
        this.timeZone,
        this.isBlueCollar});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    userName = json['userName'];
    issued = json['issued'];
    expires = json['expires'];
    name = json['name'];
    designation = json['designation'];
    imageUrl = json['imageUrl'];
    accountName = json['account_name'];
    timeZone = json['timeZone'];
    isBlueCollar = json['isBlueCollar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['userName'] = this.userName;
    data['issued'] = this.issued;
    data['expires'] = this.expires;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['imageUrl'] = this.imageUrl;
    data['account_name'] = this.accountName;
    data['timeZone'] = this.timeZone;
    data['isBlueCollar'] = this.isBlueCollar;
    return data;
  }
}
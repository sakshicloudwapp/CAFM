class GetMenuModel {
  List<MenuItems>? menuItems;
  List<QuickActions>? quickActions;
  List<AccountsModel>? accounts;

  GetMenuModel({this.menuItems, this.quickActions, this.accounts});

  GetMenuModel.fromJson(Map<String, dynamic> json) {
    if (json['menuItems'] != null) {
      menuItems = <MenuItems>[];
      json['menuItems'].forEach((v) {
        menuItems!.add(new MenuItems.fromJson(v));
      });
    }
    if (json['quickActions'] != null) {
      quickActions = <QuickActions>[];
      json['quickActions'].forEach((v) {
        quickActions!.add(new QuickActions.fromJson(v));
      });
    }
    if (json['accounts'] != null) {
      accounts = <AccountsModel>[];
      json['accounts'].forEach((v) {
        accounts!.add(new AccountsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menuItems != null) {
      data['menuItems'] = this.menuItems!.map((v) => v.toJson()).toList();
    }
    if (this.quickActions != null) {
      data['quickActions'] = this.quickActions!.map((v) => v.toJson()).toList();
    }
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuItems {
  int? groupId;
  String? groupName;
  String? groupImageName;
  int? groupSortOrder;
  bool? hideSection;
  List<GroupedSections>? groupedSections;

  MenuItems(
      {this.groupId,
        this.groupName,
        this.groupImageName,
        this.groupSortOrder,
        this.hideSection,
        this.groupedSections});

  MenuItems.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    groupName = json['groupName'];
    groupImageName = json['groupImageName'];
    groupSortOrder = json['groupSortOrder'];
    hideSection = json['hideSection'];
    if (json['groupedSections'] != null) {
      groupedSections = <GroupedSections>[];
      json['groupedSections'].forEach((v) {
        groupedSections!.add(new GroupedSections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['groupName'] = this.groupName;
    data['groupImageName'] = this.groupImageName;
    data['groupSortOrder'] = this.groupSortOrder;
    data['hideSection'] = this.hideSection;
    if (this.groupedSections != null) {
      data['groupedSections'] =
          this.groupedSections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupedSections {
  int? sectionId;
  String? title;
  bool? showVertical;
  String? iconName;
  List<GroupedSectionsMenuItemsModel>? menuItems;

  GroupedSections(
      {this.sectionId,
        this.title,
        this.showVertical,
        this.iconName,
        this.menuItems});

  GroupedSections.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    title = json['title'];
    showVertical = json['showVertical'];
    iconName = json['iconName'];
    if (json['menuItems'] != null) {
      menuItems = <GroupedSectionsMenuItemsModel>[];
      json['menuItems'].forEach((v) {
        menuItems!.add(new GroupedSectionsMenuItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sectionId'] = this.sectionId;
    data['title'] = this.title;
    data['showVertical'] = this.showVertical;
    data['iconName'] = this.iconName;
    if (this.menuItems != null) {
      data['menuItems'] = this.menuItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupedSectionsMenuItemsModel {
  int? tabId;
  String? tabName;
  String? pageTitle;
  String? pageDescription;
  String? url;
  String? editUrl;
  String? webUrl;
  int? sortOrder;
  int? dataFormat;

  GroupedSectionsMenuItemsModel(
      {this.tabId,
        this.tabName,
        this.pageTitle,
        this.pageDescription,
        this.url,
        this.editUrl,
        this.webUrl,
        this.sortOrder,
        this.dataFormat});

  GroupedSectionsMenuItemsModel.fromJson(Map<String, dynamic> json) {
    tabId = json['tabId'];
    tabName = json['tabName'];
    pageTitle = json['pageTitle'];
    pageDescription = json['pageDescription'];
    url = json['url'];
    editUrl = json['editUrl'];
    webUrl = json['webUrl'];
    sortOrder = json['sortOrder'];
    dataFormat = json['dataFormat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tabId'] = this.tabId;
    data['tabName'] = this.tabName;
    data['pageTitle'] = this.pageTitle;
    data['pageDescription'] = this.pageDescription;
    data['url'] = this.url;
    data['editUrl'] = this.editUrl;
    data['webUrl'] = this.webUrl;
    data['sortOrder'] = this.sortOrder;
    data['dataFormat'] = this.dataFormat;
    return data;
  }
}

class QuickActions {
  int? id;
  String? name;
  String? webUrl;

  QuickActions({this.id, this.name, this.webUrl});

  QuickActions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    webUrl = json['webUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['webUrl'] = this.webUrl;
    return data;
  }
}

class AccountsModel {
  int? id;
  String? imageUrl;
  String? shortImageUrl;
  String? organisation;
  String? code;
  String? name;
  String? shortName;
  String? registrationNo;
  String? taxCode;
  String? mainEmail;
  String? mainMobileCode;
  String? signatoryMobileCode;
  String? signatoryMobileNo;
  int? cityId;
  String? utcTimeZoneDiff;
  int? utcDiffInMins;
  String? currencyCode;
  String? webAdress;

  AccountsModel(
      {this.id,
        this.imageUrl,
        this.shortImageUrl,
        this.organisation,
        this.code,
        this.name,
        this.shortName,
        this.registrationNo,
        this.taxCode,
        this.mainEmail,
        this.mainMobileCode,
        this.signatoryMobileCode,
        this.signatoryMobileNo,
        this.cityId,
        this.utcTimeZoneDiff,
        this.utcDiffInMins,
        this.currencyCode,
        this.webAdress});

  AccountsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    shortImageUrl = json['shortImageUrl'];
    organisation = json['organisation'];
    code = json['code'];
    name = json['name'];
    shortName = json['shortName'];
    registrationNo = json['registrationNo'];
    taxCode = json['taxCode'];
    mainEmail = json['mainEmail'];
    mainMobileCode = json['mainMobileCode'];
    signatoryMobileCode = json['signatoryMobileCode'];
    signatoryMobileNo = json['signatoryMobileNo'];
    cityId = json['cityId'];
    utcTimeZoneDiff = json['utcTimeZoneDiff'];
    utcDiffInMins = json['utcDiffInMins'];
    currencyCode = json['currencyCode'];
    webAdress = json['webAdress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['shortImageUrl'] = this.shortImageUrl;
    data['organisation'] = this.organisation;
    data['code'] = this.code;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['registrationNo'] = this.registrationNo;
    data['taxCode'] = this.taxCode;
    data['mainEmail'] = this.mainEmail;
    data['mainMobileCode'] = this.mainMobileCode;
    data['signatoryMobileCode'] = this.signatoryMobileCode;
    data['signatoryMobileNo'] = this.signatoryMobileNo;
    data['cityId'] = this.cityId;
    data['utcTimeZoneDiff'] = this.utcTimeZoneDiff;
    data['utcDiffInMins'] = this.utcDiffInMins;
    data['currencyCode'] = this.currencyCode;
    data['webAdress'] = this.webAdress;
    return data;
  }
}

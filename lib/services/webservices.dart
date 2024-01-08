import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/main.dart';
import 'package:fm_pro/model/AssignToResponse.dart';
import 'package:fm_pro/model/UserModel.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/AnnoucementsResponse.dart';
import 'package:fm_pro/model/models/AssignedResourceModel.dart';
import 'package:fm_pro/model/models/GetAssignResources.dart';
import 'package:fm_pro/model/models/GetMenuModel.dart';
import 'package:fm_pro/model/models/GetMrDrtailModel.dart';
import 'package:fm_pro/model/models/GetNotificationWorkOrdersModel.dart';
import 'package:fm_pro/model/models/GetWorkModel.dart';
import 'package:fm_pro/model/models/ProjectModel.dart';
import 'package:fm_pro/model/models/SuperViserdResourcesModel.dart';
import 'package:fm_pro/model/models/TaskInfoModel.dart';
import 'package:fm_pro/model/models/TransferWorkordersModel.dart';
import 'package:fm_pro/model/models/resourceModel.dart';
import 'package:fm_pro/model/models/scanModel.dart';
import 'package:fm_pro/model/models/totalPriceModel.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/AuthScreens/forgot_password_screen.dart';
import 'package:fm_pro/views/AuthScreens/signin_screen.dart';
import 'package:fm_pro/views/dashboard_screen_main.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../model/models/BuildingsModel.dart';
import '../model/models/GetResourceModel.dart';
import '../model/models/GetResourceProfile.dart';
import '../model/models/GetUserModel.dart';
import '../model/models/GetWorkOrderByType.dart';
import '../model/models/asset_lookupModel.dart';
import '../model/models/getTaskLogDataModel.dart';
import '../model/models/homePageModel.dart';
import '../utils/list.dart';
import '../views/AuthScreens/authentication_successfull_screen.dart';
import '../views/AuthScreens/enter_passcode_screen.dart';
import '../views/PPM/ppm_hesq_quitionaire.dart';
import 'allApiServices.dart';

List<AccountsModel> accountlist = [];

class Webservices {
  /// Login Api Call.................................

  /// Login Api Call.................................
  static Future<void> RequestLogin(BuildContext context, String email,
      String pass, String deviceId, List<UserModel> userlist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    p.setString("email", email);
    AllApiServices.main_base_url = base_url.toString();
    // Loader True.....................
    CustomLoader.showAlertDialog(context, true);

    String main_url = "${base_url.toString() + AllApiServices.signIn}";
    var request = {};
    request['userName'] = email;
    request['password'] = pass;
    request['deviceId'] =
    "${p.getString("deviceId") == null ? "1234567" : p.getString("deviceId")}";
    request['grantType'] = "Bearer";
    print("request ${request}");

    try {
      var response = await http.post(Uri.parse(main_url),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json"
          });

      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        CustomLoader.showAlertDialog(context, false);
        print("jsonResponse ${jsonResponse}");
        print("jsonResponse tocken...${jsonResponse['access_token']}");
        var authtocken = jsonResponse['access_token'];
        var timezone = base_url == AllApiServices.UAT_Url ||
            base_url == AllApiServices.Prod_Url
            ? "04:00"
            : jsonResponse['timeZone'];
        main_base_url = base_url.toString();

        print("login>> ${main_base_url}");
        p.setBool("isLogin", true);
        p.setString("access_token", authtocken);
        p.setString("timezone", timezone);

        var data = jsonResponse;
        UserModel model = UserModel.fromJson(data);
        p.setString("user_name", model.name.toString());
        p.setString("name", model.userName.toString());
        p.setString("user_profile", model.imageUrl.toString());
        p.setString("designation", model.designation.toString());
        p.setString("isBlueCollar", model.isBlueCollar.toString());
        userlist.add(model);

        /// Navigate other screen...................TaskLog/GetTaskLogGeneralInfo
        RequestGetMenu(context);

        // Loader false.....................
        CustomToast.showToast(msg: "Login Successfully");
      } else {
        CustomLoader.showAlertDialog(context, false);
        p.setBool("isLogin", false);
        CustomToast.showToast(msg: "Login Failed");
      }
    } on SocketException catch (e) {
      await Future<int>.delayed(Duration(seconds: 1));
      CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// Get Menu .................................
  static Future<void> RequestGetMenu(BuildContext context) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    AllApiServices.main_base_url = base_url.toString();
    // Loader True.....................
    CustomLoader.showAlertDialog(context, true);

    String main_url = "${base_url.toString() + AllApiServices.GetMenu}";
    var request = {};
    print("request ${request}");
    print("main_url ${main_url}");

    try {
      var response = await http.post(Uri.parse(main_url),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("ttttt" + response.body);
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        print("Get menu jsonResponse ${jsonResponse}");
        var getmenu = jsonResponse['accounts'];
        accountlist.clear();
        getmenu.forEach((e) {
          AccountsModel model = AccountsModel.fromJson(e);
          accountlist.add(model);
        });
        print("accountlist>> ${accountlist.length}");
        //
        //List<Accounts> accounts
        if (accountlist.length > 1) {
          p.setBool("isLogin", false);
          CustomLoader.Checkuserpopup(context, accountlist);
        } else {
          CustomNavigator.custompushAndRemoveUntil(
              context, DashboardScreenMain());
        }

        CustomToast.showToast(msg: "Get menu Successfully");
      } else {
        p.setBool("isLogin", false);
      }
    } on SocketException catch (e) {
      await Future<int>.delayed(Duration(seconds: 1));
      CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// Regenrate Tocken .................................
  static Future<void> RequestReGenerateToken(
      BuildContext context, String accountId, List<UserModel> userlist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    AllApiServices.main_base_url = base_url.toString();
    CustomLoader.showAlertDialog(context, true);
    String main_url =
        "${base_url.toString() + AllApiServices.ReGenerateToken + "${accountId}"}";
    var request = {};
    print("main_url ${main_url}");

    try {
      var response = await http.post(Uri.parse(main_url),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("ttttt" + response.body);
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        print("ReGenerateToken jsonResponse ${jsonResponse}");
        var authtocken = jsonResponse['access_token'];
        var timezone = base_url == AllApiServices.UAT_Url ||
            base_url == AllApiServices.Prod_Url
            ? "04:00"
            : jsonResponse['timeZone'];
        main_base_url = base_url.toString();

        print("login>> ${main_base_url}");
        p.setBool("isLogin", true);
        p.setString("access_token", authtocken);
        p.setString("timezone", timezone);

        var data = jsonResponse;
        UserModel model = UserModel.fromJson(data);
        p.setString("user_name", model.accountName.toString());
        p.setString("name", model.userName.toString());
        p.setString("user_profile", model.imageUrl.toString());
        p.setString("designation", model.designation.toString());
        userlist.add(model);

        CustomNavigator.custompushAndRemoveUntil(
            context, DashboardScreenMain());

        CustomToast.showToast(msg: "Get menu Successfully");
      } else {
        p.setBool("isLogin", false);
        CustomToast.showToast(msg: "Login Failed");
      }
    } on SocketException catch (e) {
      await Future<int>.delayed(Duration(seconds: 1));
      CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  static Future<void> RequestLogout(
      BuildContext context,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");

    String main_url = "${base_url.toString()}";
    // Loader True.....................
    CustomLoader.showAlertDialog(context, true);

    var request = {};
    print("request ${request}");

    try {
      var response = await http.post(
          Uri.parse(base_url.toString() + AllApiServices.logout),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print(response.body);
      if (response.statusCode == 200) {
        p.clear();
        p.setString("init_screen", '1');
        p.setBool("isLogin", false);

        /// Navigate other screen...................
        CustomNavigator.customfinishpage(context, SigninScreen());

        // Loader false.....................
        CustomToast.showToast(msg: "Login Successfully");
      } else {
        //  p.setBool("isLogin", false);
        CustomToast.showToast(msg: "Login Failed");
        // Loader false.....................
        // await Future<int>.delayed(Duration(seconds: 1));
        CustomLoader.showAlertDialog(context, false);
      }
    } on SocketException catch (e) {
      // await Future<int>.delayed(Duration(seconds: 1));
      CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// DeviceId Api Call.................................
  static Future<void> RequestDeviceId(
      BuildContext context,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();

    print("deviceId>>>>>${p.getString("deviceId")}");
    // Loader True.....................
    await Future<int>.delayed(Duration(seconds: 1));
    CustomLoader.showAlertDialog(context, true);

    var request = {};
    // request['id'] = p.getString("deviceId").toString();

    try {
      var response = await http.post(
          Uri.parse(AllApiServices.deviceId + "?id=${p.getString("deviceId")}"),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json"
          });

      print("jkads" + response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        print("jsonResponse ${jsonResponse}");
        print("jsonResponse tocken...${jsonResponse['access_token']}");
        var authtocken = jsonResponse['access_token'];

        p.setBool("isLogin", true);
        p.setString("access_token", authtocken);
        await Future<int>.delayed(Duration(seconds: 1));
        CustomLoader.showAlertDialog(context, false);

        /// Navigate other screen...................

        await Future<int>.delayed(Duration(seconds: 1));
        CustomNavigator.custompushReplacement(
            context, AuthenticationSuccessfullScreen());

        // Loader false.....................
        CustomToast.showToast(msg: "Login Successfully");
      } else {
        p.setBool("isLogin", false);
        CustomToast.showToast(msg: "Login Failed");
        // Loader false.....................
        CustomLoader.showAlertDialog(context, false);
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  ///not use Get All Assets Data..............................
/*  static Future<void> RequestGetAllAssets(
      BuildContext context, List<GetAllAssetsModel> getAllAssetsList) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);
    var request = {};
    print("request ${request}");
    try {
      var response = await http.get(Uri.parse(AllApiServices.GetAllAssets),
          // body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });
      print("RESPONSE>>>>>>>>>>" + response.headers.toString());

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>>" + jsonResponse.toString());
      print(jsonResponse);
      if (response.statusCode == 200) {
        GetAllAssetsModel model = GetAllAssetsModel.fromJson(jsonResponse);
        getAllAssetsList.add(model);
        CustomLoader.showAlertDialog(context, false);
        print("asset_id>>>" + getAllAssetsList[0].data![0].assetId.toString());
        //  Fluttertoast.showToast(msg: jsonResponse['message']);
      } else {
        CustomLoader.showAlertDialog(context, false);
        // Fluttertoast.showToast(msg: jsonResponse['message']);
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
    // }
  }*/

  ///not use Get Home page Data..............................
  static Future<void> RequestGetHomePage(
      BuildContext context,
      List<HomePageModel> gethomepageList,
      List<HomePageDataModel> gethomepagedataList,
      bool load) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    print("tocken>>>${p.getString("access_token")}");
    //load == true ?   CustomLoader.ProgressloadingDialog(context, true) : Container();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${p.getString("access_token")}'
    };

    try {
      var request = http.Request('GET',
          Uri.parse("http://66.175.233.144/PPMApi/api/Mobile/HomePageData"));
      request.body = '''''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // CustomLoader.ProgressloadingDialog(context, false);
      Map<String, dynamic> jsonResponse =
      convert.jsonDecode(await response.stream.bytesToString());

      print("fgrhjhjd" + jsonResponse.toString());
      if (response.statusCode == 200) {
        HomePageModel model = HomePageModel.fromJson(jsonResponse);
        gethomepageList.add(model);
        var list = jsonResponse['data'];
        list.forEach((e) {
          HomePageDataModel model2 = HomePageDataModel.fromJson(e);
          gethomepagedataList.add(model2);
        });
      } else {
        print(response.reasonPhrase.toString());
      }
    } on SocketException catch (e) {
      CustomToast.showToast(msg: e.toString());
    }
  }

  ///Get Asset Lookup  Data..............................
  static Future<void> RequestGetassetlookupdata(BuildContext context,
      List<AssetLookupDataModel> getassetlookupList, bool load) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";

    CustomLoader.showAlertDialog(context, true);
    var request = {};
    try {
      var response = await http.get(
          Uri.parse(main_url +
              AllApiServices.AssetManagement +
              AllApiServices.Getassetlookup),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      if (response.statusCode == 200) {

        CustomLoader.showAlertDialog(context, false);
      } else {
        CustomLoader.showAlertDialog(context, false);
        Fluttertoast.showToast(msg: "error");
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  ///Get Asset Lookup Detail Data..............................
  static Future<void> RequestGetassetlookupdetail(
      BuildContext context,
      List<AssetLookupDetailModel> getassetlookupdetailList,
      bool load,
      String assetId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";
    var request = {};

    try {
      var response = await http.post(
          Uri.parse(main_url +
              AllApiServices.AssetManagement +
              AllApiServices.Getassetlookupdetail +
              assetId),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        AssetLookupDetailModel model =
        AssetLookupDetailModel.fromJson(jsonResponse);
        getassetlookupdetailList.add(model);
      } else {
        Fluttertoast.showToast(msg: "error");
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  ///Get Asset Lookup Detail Data..............................
  /* static Future<void> RequestGetBuilding(
      BuildContext context,
      List<BuildingAutogeneratedModel> buildinglist,
      bool load,
      String ppmId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);

    var request = {};

    try {
      var response = await http
          .get(Uri.parse(AllApiServices.Getbuilding + ppmId), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${p.getString("access_token")}"
      });

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      CustomLoader.showAlertDialog(context, false);

      if (response.statusCode == 200) {
        BuildingAutogeneratedModel model =
        BuildingAutogeneratedModel.fromJson(jsonResponse);
        buildinglist.add(model);
      } else {
        Fluttertoast.showToast(msg: "error");
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }
*/
  ///Get Asset Lookup Detail Data..............................
  static Future<void> RequestGettask_Logdata(
      BuildContext context,
      //List<GetTaskLogDataResponse> gettasldatalist,
      List<Resources> gettasldatalist,
      bool load,
      String serviceTypeid,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);
    var request = {};

    try {
      var response = await http.get(
          Uri.parse("http://216.48.190.5/CoreApi/api/Resources/GetResource/2"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      var jsonResponse = convert.jsonDecode(response.body);
      CustomLoader.showAlertDialog(context, false);

      if (response.statusCode == 200) {
        gettasldatalist.clear();
        var resource = jsonResponse['resources'];
        resource.forEach((element) {
          Resources model = Resources.fromJson(element);
          gettasldatalist.add(model);
        });
      } else {
        Fluttertoast.showToast(msg: "error");
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  ///Get Asset Lookup Detail Data..............................

  static Future<void> RequestGetWorkOrders(
      BuildContext context,
      List<GetWorkModel> getworklist,
      bool load,
      String serviceId,
      String statusId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    load == true ? CustomLoader.showAlertDialog(context, true) : null;
    var base_url = p.getString("mainurl");
    String status = p.getString("menu_ID").toString();
    String main_url = "${base_url.toString()}";
    var request = {};

    print("GetWorkOrdersByTypeNStatus hfhjgjkgjklg ${status}  "
        "${status == "4" ? main_url + AllApiServices.scheduleapi + AllApiServices.GetWorkOrdersByTypeNStatus + serviceId + "/" + statusId : main_url + AllApiServices.base_name_PPmApi + AllApiServices.GetWorkOrdersByTypeNStatus + serviceId + "/" + statusId}");
    try {
      final response = await http.get(
          Uri.parse(status == "4"
              ? main_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.GetWorkOrdersByTypeNStatus +
              serviceId +
              "/" +
              statusId
              : main_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.GetWorkOrdersByTypeNStatus +
              serviceId +
              "/" +
              statusId),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      getworklist.clear();
      if (response.statusCode == 200) {
        load == true ? CustomLoader.showAlertDialog(context, false) : null;
        final jsonData = json.decode(response.body.toString());

        print("jsonData>>${jsonData}");
        jsonData.forEach((jsonModel) {
          GetWorkModel model = GetWorkModel.fromJson(jsonModel);
          getworklist.add(model);
        });
      }
    } catch (e) {
      load == true ? CustomLoader.showAlertDialog(context, false) : null;
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }

  static Future<void> RequestGetNotificationWorkOrders(
      BuildContext context,
      List<GetNotificationWorkOrdersModel> getNotificationList,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";
    var request = {};

    print(
        "hfhjgjkgjklg${main_url + AllApiServices.base_name_PPmApi + AllApiServices.GetNotificationWorkOrders}");
    try {
      final response = await http.get(
          Uri.parse(main_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.GetNotificationWorkOrders),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      getNotificationList.clear();
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body.toString());

        print("jsonData>>${jsonData}");
        jsonData.forEach((jsonModel) {
          GetNotificationWorkOrdersModel model = GetNotificationWorkOrdersModel.fromJson(jsonModel);
          getNotificationList.add(model);
        });
      }
    } catch (e) {
      print(e);
      throw Exception('Error ${e.toString()}');
    }
    return;
  }

  static Future<void> RequestUpdateWorkOrders(
      BuildContext context, bool load, String taskid, String status) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");

    String main_url = "${base_url.toString()}";

    var request = {};
    try {
      final response = await http.post(
          Uri.parse(main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.update_work_orders +
              taskid),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }

  static String TimeZoneDatefomatToDateTimefgr(String bigTime) {
    DateTime tempDate = DateFormat("HH:mm").parse(bigTime);
    var dateFormat = DateFormat("K"); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    return createdDate;
  }

  /// Accept Reject ........
  static Future<void> RequestAcceptReject(
      BuildContext context,
      bool load,
      int taskLogId,
      int resourceId,
      int actionId,
      String comments,
      DateTime actionDate,
      String status,
      int isFromMobile
      // bool isFromMobile
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String menu_status = p.getString("menu_ID").toString();

    String main_url = "${base_url.toString()}";
    CustomLoader.showAlertDialog(context, true);

    DateTime dateTime = DateTime.now();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${p.getString("access_token")}'
    };
    print("hjbcxjgk>${menu_status == "4"
        ? main_base_url +
        AllApiServices.scheduleapi +
        AllApiServices.accept_reject
        : main_url +
        AllApiServices.base_name_PPmApi +
        AllApiServices.accept_reject}");

    var time = p.getString("timezone").toString().replaceAll("+", "");
    var timezone = TimeZoneDatefomatToDateTimefgr(time);
    try {
      var request = http.Request(
          'POST',
          Uri.parse(menu_status == "4"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.accept_reject
              : main_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.accept_reject));
      request.body = json.encode({
        "taskLogId": taskLogId,
        "resourceId": resourceId,
        "actionId": actionId,
        "actionDate": dateTime
            .toUtc()
            .add(Duration(hours: int.parse(timezone)))
            .toString(),
        "comments": comments,
        "isFromMobile": isFromMobile
      });
      request.headers.addAll(headers);

      print("accept_reject Request>>${json.encode({
        "taskLogId": taskLogId,
        "resourceId": resourceId,
        "actionId": actionId,
        "actionDate": dateTime
            .toUtc()
            .add(Duration(hours: int.parse(timezone)))
            .toString(),
        "comments": comments,
        "isFromMobile": isFromMobile
      })}");
      http.StreamedResponse response = await request.send();
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
      } else {
        Fluttertoast.showToast(msg: response.reasonPhrase.toString());
        response.reasonPhrase.toString() == "Unauthorized"
            ? PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(),
          screen: SigninScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        )
            : null;
      }
    } catch (e) {
      print(e);
      throw Exception('Errorr>>>>> ${e.toString()}');
    }
    return;
  }

  /// Accept Reject ........
  static Future<void> RequestAdditionolInfo(
      BuildContext context,
      bool load,
      String taskLogId,
      List<TaskResourcesModel> taskResourceslist,
      List<HseqListItems> hseqlist,
     ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();

    CustomLoader.showAlertDialog(context, true);
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";

    print(
        "ppm url>>>${status == "schedule" ? main_url.toString() + AllApiServices.scheduleapi + AllApiServices.task_log_additionol_info + taskLogId.toString() : main_url.toString() + AllApiServices.base_name_PPmApi + AllApiServices.task_log_additionol_info + taskLogId.toString()}");
    try {
      final response = await http.get(
          Uri.parse(status == "4"
              ? main_url.toString() +
              AllApiServices.scheduleapi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()
              : main_url.toString() +
              AllApiServices.base_name_PPmApi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        var taskresources = jsonResponse['taskResources'];
        var hseq = jsonResponse['hseqListItems'];
        taskresources.forEach((e) {
          TaskResourcesModel model = TaskResourcesModel.fromJson(e);
          taskResourceslist.add(model);
        });

        ///   hseq.forEach((e){
        HseqListItems model2 = HseqListItems.fromJson(hseq);
        hseqlist.add(model2);
        //  });
      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }

  static Future<void> RequestGetWorkByOrdersType(
      BuildContext context,
      List<GetWorkOrderByTypeModel> getworklist,
      bool load,
      String service_typeId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";
    var request = {};
    print("jjug>${main_url}PMApi/api/Mobile/GetWorkOrdersByType/${service_typeId}");

    try {
    load == true?   CustomLoader.showAlertDialog(context, true) : null;
      final response = await http.get(
          Uri.parse(
              "${main_url}PMApi/api/Mobile/GetWorkOrdersByType/${service_typeId}"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

    load == true?   CustomLoader.showAlertDialog(context, false) : null;
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body.toString());
        jsonData.forEach((jsonModel) {
          GetWorkOrderByTypeModel model =
          GetWorkOrderByTypeModel.fromJson(jsonModel);
          getworklist.add(model);
        });
      }
    } catch (e) {
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }

  static Future<void> Requestscan(BuildContext context, bool load, String code,
      List<ScanModel> scanlist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    load == true ? CustomLoader.showAlertDialog(context, true) : null;

    var request = {};

    try {
      final response = await http.post(
          Uri.parse(main_base_url +
              "AssetMgmtApi/api/Activity/GetAssetInformationByCode?assetCode=${code}"),
          body: convert.jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        ScanModel model = ScanModel.fromJson(jsonResponse);
        scanlist.add(model);
      }
      load == true ? CustomLoader.showAlertDialog(context, false) : null;
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }

  /// GetLocationDetailsByAssetCode Api call.........
  static Future<void> RequestGetLocationDetailsByAssetCode(BuildContext context,
      bool load, String code, List<AssetScanModel> assetscanlist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    load == false ? null : CustomLoader.showAlertDialog(context, true);

    print("url check ${status =="4" ?
    "${main_base_url +
        AllApiServices.scheduleapi+ AllApiServices.GetLocationDetailsByAssetCode +
        code}" :
    main_base_url +
        AllApiServices.base_name_PPmApi+ AllApiServices.GetLocationDetailsByAssetCode +
        "${code}"}");
    var request = {};

    print("terttt ${main_base_url+AllApiServices.GetLocationDetailsByAssetCode + code}");
    try {
      final response = await http.get(
          Uri.parse(  status =="4" ?
          "${main_base_url +
              AllApiServices.scheduleapi+ AllApiServices.GetLocationDetailsByAssetCode +
              code}" :
          main_base_url +
              AllApiServices.base_name_PPmApi+ AllApiServices.GetLocationDetailsByAssetCode +
              "${code}"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      if (response.statusCode == 200) {

        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        print("jsonResponse<<< ${jsonResponse}");
        AssetScanModel model = AssetScanModel.fromJson(jsonResponse);
        assetscanlist.add(model);
      }
      load == false ? null : CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {}
    } catch (e) {
      //   CustomLoader.showAlertDialog(context, false);
      print(e);
      throw Exception('Invalid Asset Code ${e.toString()}');
    }
    return;
  }

  static Future<void> RequestAddPPMHseqlistApi(BuildContext context, bool load,
      List<HESQ_Model> hseqlist2, Function Oncallback, String status) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String menu_status = p.getString("menu_ID").toString();
   // CustomLoader.showAlertDialog(context, true);
    var headers = {'Authorization': 'Bearer ${p.getString("access_token")}'};
    print("hfjdjhgk>${menu_status == "4"
        ? main_base_url +
        AllApiServices.scheduleapi +
        AllApiServices.SaveTaskLogQuestionnaire
        : main_base_url +
        AllApiServices.base_name_PPmApi +
        AllApiServices.SaveTaskLogQuestionnaire}");
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(menu_status == "4"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.SaveTaskLogQuestionnaire
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.SaveTaskLogQuestionnaire
            //main_base_url + AllApiServices.SaveTaskLogQuestionnaire
          ));
      for (int i = 0; i < hseqlist2.length; i++) {
        request.fields.addAll({
          'questionAnswers[$i].taskLogId': hseqlist2[i].taskLogId.toString(),
          'questionAnswers[$i].isCheckListItem':
          hseqlist2[i].isCheckListItem.toString(),
          'questionAnswers[$i].linkId': hseqlist2[i].linkId.toString(),
          'questionAnswers[$i].answerId': hseqlist2[i].answerId.toString(),
          'questionAnswers[$i].comments': hseqlist2[i].comments.toString(),
          'questionAnswers[$i].imageUrl': "",
          'questionAnswers[$i].file': ""
        });

        request.headers.addAll(headers);
      }

      http.StreamedResponse response = await request.send();
     // CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Oncallback();
      } else {}
    } on SocketException catch (e) {
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }
//  http://uatcafm.smrthub.com/SchduledApi/api/TaskLogOperations/AddOrUpdateTaskLogDocuments

  static Future<void> RequeSaveTaskQuestion(BuildContext context, bool load,
      List<HESQ_Model> list, Function Oncallback) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);

    var request = {};

    try {
      final response = await http.post(
          Uri.parse(main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.SaveTaskLogQuestionnaire),
          body: convert.jsonEncode(list),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Oncallback();
      }
    } catch (e) {
      print(e);
      throw Exception('error ${e.toString()}');
    }
    return;
  }

  static Future<void> RequestUpdateTaskLogStatus(
      BuildContext context,
      bool load,
      String taskid,
      String statusId,
      String serviceTypeId,
      Function Oncallback,
      String status) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String menu_status = p.getString("menu_ID").toString();
    CustomLoader.showAlertDialog(context, true);

    var request = {};
    try {
      final response = await http.post(
          Uri.parse(menu_status == "4"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.UpdateTaskLogStatus +
              taskid +
              "&statusId=" +
              statusId +
              "&serviceTypeId=$serviceTypeId" +
              "&isMobile=true"
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.UpdateTaskLogStatus +
              taskid +
              "&statusId=" +
              statusId +
              "&serviceTypeId=$serviceTypeId" +
              "&isMobile=true"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      if (response.statusCode == 200) {
        CustomLoader.showAlertDialog(context, false);
        Oncallback();
        statusId.toString() == "3" ? Navigator.pop(context) : null;
      }
    } catch (e) {
      CustomLoader.showAlertDialog(context, false);
      print(e);
      throw Exception('Download PDF Fail! ${e.toString()}');
    }
    return;
  }

  /// GetResourcesByReporterType ........
  static Future<void> RequestGetResourcesByReporterType(
      BuildContext context,
      bool load,
      String typeId,
      String subTypeId,
      String taskLogId,
      String ProjectId,
      String status,
      List<AssignedResourcesModel> resourcelist,
      ) async {

    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);
    print("hruykhkmju>${main_base_url +
        AllApiServices.base_name_PPmApi +
        AllApiServices.GetResourcesByReporterType +
        "${typeId}/${subTypeId}/${taskLogId}/${ProjectId}"}");
    try {
      final response = await http.get(
          Uri.parse(status == "schedule"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.GetResourcesByReporterType +
              "${typeId}/${subTypeId}/${taskLogId}/${ProjectId}"
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.GetResourcesByReporterType +
              "${typeId}/${subTypeId}/${taskLogId}/${ProjectId}"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        var resources = jsonResponse['resources'];
        print("resources" + resources.toString());
        //var hseq_question = jsonResponse['hseqListItems'];
        if (resources != null) {
          resources.forEach((e) {
            AssignedResourcesModel model = AssignedResourcesModel.fromJson(e);
            resourcelist.add(model);
          });
        }

        print("additionalInfo  response" + response.toString());
      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      //   CustomLoader.showAlertDialog(context, false);
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }

  static Future<void> RequestCustomerEmailNotificarion(
      BuildContext context,
      bool load,
      String taskLogId,
      String comment,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    print("urlhjhk  >>${status == "4"}");
    print(
        "url>>${main_base_url + AllApiServices.CustomerEmailNotificarion + "${taskLogId}&comments=${comment}"}");
    // CustomLoader.showAlertDialog(context, true);
    var request = {};
    try {
      final response = await http.post(
          Uri.parse(
            // status == "4"?
            // main_base_url +AllApiServices.scheduleapi+ AllApiServices.CustomerEmailNotificarion +
            //     "${taskLogId}&comments=${comment}":
              main_base_url +
                  AllApiServices.base_name_PPmApi +
                  AllApiServices.CustomerEmailNotificarion +
                  "${taskLogId}&comments=${comment}"),
          body: convert.jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      print("regasg>${response.body}");
      // CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      print("additionalInfo" + jsonResponse.toString());
      if (response.statusCode == 200) {
        print("jsonResponse" + jsonResponse.toString());
      } else {
        print(response.reasonPhrase);
        // CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }

  static Future<void> RequestGetMRDetailsByTaskId(
      BuildContext context,
      bool load,
      String taskLogId,
      String taskTypeId,
      String projectId,
      List<MrStockModel> mrstocklist,
      List<MrTypes>? mrTypeslist,
      List<StocksModel>? stockslist,
      List<MrDetails>? mrDetailslist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    print(
        "url>>${main_base_url + AllApiServices.StockApi + AllApiServices.GetMRDetailsByTaskId + "${taskLogId}/${taskTypeId}/${projectId}"}");
    CustomLoader.showAlertDialog(context, true);
    var request = {};
    try {
      final response = await http.get(
          Uri.parse(main_base_url +
              AllApiServices.StockApi +
              AllApiServices.GetMRDetailsByTaskId +
              "${taskLogId}/${taskTypeId}/${projectId}"),
          // body: convert.jsonEncode(request),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      print("regasg>${response.body}");
      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      print("additionalInfo" + jsonResponse.toString());
      if (response.statusCode == 200) {
        var mrTypes = jsonResponse['mrTypes'];
        var stocks = jsonResponse['stocks'];
        var mrdetail = jsonResponse['mrDetails'];
        print("stocks>>${stocks}");

        /// Types,,,,
        if (mrTypes != null) {
          mrTypes.forEach((e) {
            MrTypes mrmodel = MrTypes.fromJson(e);
            mrTypeslist!.add(mrmodel);
          });
        }

        /// Stocks,,,,,,,,
        if (mrdetail != null) {
          mrdetail.forEach((e1) {
            MrDetails mrdetailmodel = MrDetails.fromJson(e1);
            mrDetailslist!.add(mrdetailmodel);
          });
        }

        /// Stocks,,,,,,,,
        if (stocks != null) {
          stocks.forEach((e1) {
            StocksModel stockmodel = StocksModel.fromJson(e1);
            stockslist!.add(stockmodel);
          });
        }
      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${""}');
    }
    return;
  }

  static Future<void> RequestGettaskinfodetail(
      BuildContext context,
      List<TaskInfoModel> taskinfolist,
      bool load1,
      String taskLogId,
      String serviceId,
      String projectId,
      bool load,
      String status) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String status = p.getString("menu_ID").toString();

    print("baseurl >> ${base_url}");
    String main_url = "${base_url.toString()}";
    print("murl55 >> ${ "${main_base_url +
        AllApiServices.scheduleapi +
        AllApiServices.GetTaskLogGeneralInfo+
        taskLogId}"}");

    print(
        "GetTaskLogGeneralInfo url>> ${ main_base_url +
            AllApiServices.base_name_PPmApi +
            AllApiServices.GetTaskLogGeneralInfo +
            taskLogId +
            "/${serviceId}/${projectId}"}");
    print("GetTaskLogGeneralInfo url>>${status}");
    load == true ? CustomLoader.showAlertDialog(context, true) : null;
    try {
      var response = await http.get(
          Uri.parse(
              status == "4"
                  ?
              "${main_base_url}SchduledApi/api/TaskLog/GetTaskLogGeneralInfo/$taskLogId"
                  :
              main_base_url +
                  AllApiServices.base_name_PPmApi +
                  AllApiServices.GetTaskLogGeneralInfo +
                  taskLogId +
                  "/${serviceId}/${projectId}"),
          //  body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("jsonResponse>222>>");
      load == true ? CustomLoader.showAlertDialog(context, false) : null;
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>>" + jsonResponse.toString());

      if (response.statusCode == 200) {
        taskinfolist.clear();
        var config_data = jsonResponse;
        TaskInfoModel model = TaskInfoModel.fromJson(config_data);
        taskinfolist.add(model);
      } else {
        Fluttertoast.showToast(msg: "error");
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  /// GetReSource Api call....

  static Future<void> RequestGetResource(BuildContext context,
      String resourceId, List<ResourcesModel> resourcelist) async {
    SharedPreferences p = await SharedPreferences.getInstance();

    var base_url = p.getString("mainurl");

    print("baseurl >> ${base_url}");
    print(
        "get_resource url >> ${main_base_url + AllApiServices.get_resource + resourceId}");

    try {
      var response = await http.get(

          Uri.parse(main_base_url + AllApiServices.get_resource + resourceId),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("jkads" + response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        print("jsonResponse resorce ${jsonResponse}");
        var resource = jsonResponse['resources'];

        if(resource != null){
          resource.forEach((e) {
            ResourcesModel model = ResourcesModel.fromJson(e);
            resourcelist.add(model);
          });
        }
        // resourcelist = resource;


        print("resource resorce ${resource}");

        /// Navigate other screen...................
      } else {}
    } on SocketException catch (e) {
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// GetReSource Api call....
  static Future<void> RequestSaveTaskLogOnHoldReason(
      BuildContext context,
      int taskLogId,
      String onHoldReasonId,
      String comments,
      String status,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String menu_status = p.getString("menu_ID").toString();
    print("baseurl >> ${base_url}");
    String main_url = "${base_url.toString()}";
    print("murl >> ${main_url}");

    print(
        "GetTaskLogGeneralInfo url>>${main_base_url + AllApiServices.SaveTaskLogOnHoldReason}");
    CustomLoader.showAlertDialog(context, true);
    var request = {};

    request['taskLogId'] = taskLogId;
    request['onHoldReasonId'] = onHoldReasonId.toString();
    request['comments'] = comments + "\n";
    // }

    print("request>>>${request}");

    try {
      var response = await http.post(
          Uri.parse(menu_status == "4"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.SaveTaskLogOnHoldReason
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.SaveTaskLogOnHoldReason),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print(response.body);
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        /// Navigate other screen...................
      } else {}
    } on SocketException catch (e) {
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// GetProjectsMasterData Api call....
  static Future<void> RequestGetProjectsMasterData(BuildContext context,
      String taskLogId, List<ProjectsModel> projectlist, bool load) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String status = p.getString("menu_ID").toString();
    print("baseurl >> ${base_url}");
    String main_url = "${base_url.toString()}";
    print("murl >> ${main_url}");

    print(
        "GetProjectsMasterData url>>${status == "4"?
        main_base_url+AllApiServices.scheduleapi+AllApiServices.GetProjectsMasterData +
            "${taskLogId}":
        main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.GetProjectsMasterData +
            "${taskLogId}"}");
    load == true ? CustomLoader.showAlertDialog(context, true) : null;
    var request = {};

    print("request>>>${request}");

    try {
      var response = await http.get(
          Uri.parse(
              status == "4"?
              main_base_url+AllApiServices.scheduleapi+AllApiServices.GetProjectsMasterData +
                  "${taskLogId}":
              main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.GetProjectsMasterData +
                  "${taskLogId}"
            // main_base_url +
            // AllApiServices.GetProjectsMasterData +
            // "${taskLogId}"
          ),
          //   body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print(response.body);
      load == true ? CustomLoader.showAlertDialog(context, false) : null;
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        print(" projects jsonResponse resorce ${jsonResponse}");
        var projects = jsonResponse['projects'];

        print("projects>>>${projects}");
        if (projects != null) {
          projects.forEach((e) {
            ProjectsModel model = ProjectsModel.fromJson(e);
            projectlist.add(model);
          });
        }
      } else {}
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// SaveTaskLogFeedBack Api call....

  /* static Future<void> RequestSaveTaskLogFeedBack(
      BuildContext context,
      int taskLogId,
      int rating,
      String comments,
      Function onupdate,
      var file) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String main_url = "${base_url.toString()}";
    CustomLoader.showAlertDialog(context, true);
    var request = {};
    request['TaskLogId'] = taskLogId;
    request['Rating'] = rating;
    request['Comments'] = comments;
    try {
      var headers = {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer ${p.getString("access_token")}"
      };
      var request = http.MultipartRequest('POST',
          Uri.parse(main_base_url + AllApiServices.SaveTaskLogFeedBack));
      //request.files.add(await http.MultipartFile.fromPath('File',file!.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        CustomLoader.showAlertDialog(context, false);

        await response.stream.transform(convert.utf8.decoder).listen((event) {
          // Map map = convert.jsonDecode(event);
          print(response.reasonPhrase);
          CustomToast.showToast(msg: response.reasonPhrase.toString());
        });

        Navigator.pop(context);
        onupdate();
      } else {
        print(response.reasonPhrase);
        CustomToast.showToast(msg: response.reasonPhrase.toString());
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
  }*/

  static Future<void> RequestSaveTaskLogFeedBack(
      BuildContext context,
      int taskLogId,
      int rating,
      String comments,
      Function onupdate,
      var file) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String menu_status = p.getString("menu_ID").toString();
    // {id: 5, taskLogId: 153, fileName: "", file: null, type: "Do
    String main_url = "${base_url.toString()}";
    CustomLoader.showAlertDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            menu_status == "4"?
            main_base_url+AllApiServices.scheduleapi+AllApiServices.SaveTaskLogFeedBack:
            main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.SaveTaskLogFeedBack
        ),
      );

      Map<String, String> header = {
        "accept": "application/json",
        "Authorization": "Bearer ${p.getString("access_token")}"
      };

      request.headers.addAll(header);

      if (file == null) {
        print("else");
        request.fields['TaskLogId'] = taskLogId.toString();
        request.fields['Rating'] = rating.toString();
        request.fields['Comments'] = comments;
      } else {
        print("image ${file.path}");
        request.fields['TaskLogId'] = taskLogId.toString();
        request.fields['Rating'] = rating.toString();
        request.fields['Comments'] = comments;
        request.files.add(await http.MultipartFile.fromPath('File', file.path));
      }

      print('the request is :${request}');
      print(request.fields);
      print(request.files);

      var response = await request.send();
      print("response.....${response.headers.toString()}");
      CustomLoader.showAlertDialog(context, false);
      response.stream.transform(convert.utf8.decoder).listen((event) {
        print("event.... >>>>>>${event.toString()}");

        if (event.toString() == "false") {
        } else {
          Navigator.pop(context);
          onupdate();
        }

        /// SUCCESS
        //  }
      });
    } catch (e) {
      ///EXCEPTION
      CustomLoader.showAlertDialog(context, false);
      print("error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
  }

  /// Delete Documnet.......
  static Future<void> RequestDeleteTaskLogDocuments(BuildContext context,
      int taskLogId, int id, String resourceUrl, String extension) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String menu_status = p.getString("menu_ID").toString();
    // {id: 5, taskLogId: 153, fileName: "", file: null, type: "Doc",…}
    print(
        "DeleteTaskLogDocuments url>>${main_base_url + AllApiServices.DeleteTaskLogDocuments}");

    CustomLoader.showAlertDialog(context, true);
    // http://216.48.190.5/PMApi/api/TaskLogOperations/DeleteTaskLogDocument

    http: //216.48.190.5/PMApi/api/TaskLogOperations/DeleteTaskLogDocuments

    var request = {};
    request['id'] = id;
    request['taskLogId'] = taskLogId;
    request['fileName'] = "";
    request['file'] = null;
    request['type'] = "Doc";
    request['resourceUrl'] = resourceUrl;
    request['extension'] = extension;

    print("request>>>${request}");

    try {
      var response = await http.post(
          Uri.parse(
              menu_status == "4"?
              main_base_url+AllApiServices.scheduleapi+AllApiServices.DeleteTaskLogDocuments:
              main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.DeleteTaskLogDocuments
          ),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("response>>>>>" + response.body);
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        /// Navigate other screen...................
      } else {
        // CustomLoader.showAlertDialog(context, false);
      }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// Delete Documnet.......
  static Future<void> RequestDeleteTaskLogImages(BuildContext context,
      int taskLogId, int id, String resourceUrl, String extension) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String menu_status = p.getString("menu_ID").toString();
    // {id: 5, taskLogId: 153, fileName: "", file: null, type: "Doc",…}
    print(
        "DeleteTaskLogDocuments url>>${main_base_url + AllApiServices.DeleteTaskLogImages}");

    CustomLoader.showAlertDialog(context, true);

    var request = {};
    request['id'] = id;
    request['taskLogId'] = taskLogId;
    request['fileName'] = "";
    request['file'] = null;
    request['type'] = "Img";
    request['resourceUrl'] = resourceUrl;
    request['extension'] = extension;

    print("request>>>${request}");

    try {
      var response = await http.post(
          Uri.parse(
              menu_status == "4"?
              main_base_url+AllApiServices.scheduleapi+AllApiServices.DeleteTaskLogImages:
              main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.DeleteTaskLogImages
          ),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("response>>>>>" + response.body);
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        /// Navigate other screen...................
      } else {
        // CustomLoader.showAlertDialog(context, false);
      }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// GetUserInformation.......
  static Future<void> RequestGetUserInformation(
      BuildContext context, List<GetUserModel> getuserlist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    // {id: 5, taskLogId: 153, fileName: "", file: null, type: "Doc",…}
    print(
        "DeleteTaskLogDocuments url>>${main_base_url + AllApiServices.GetUserInformation}");

    //  CustomLoader.showAlertDialog(context, true);

    var request = {};

    print("request>>>${request}");

    try {
      var response = await http.post(
          Uri.parse(main_base_url + AllApiServices.GetUserInformation),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("response>>>>>" + response.body);
      //  CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        print(" projects jsonResponse resorce ${jsonResponse}");

        if (jsonResponse != null) {
          GetUserModel model = GetUserModel.fromJson(jsonResponse);
          getuserlist.add(model);

          print(
              "model.resourceSubTypeName.toString()>>${model.resourceSubTypeName.toString()}");
          print(
              "model.resourceSubTypeName.toString()>>${model.resourceSubTypeName.toString()}");
          p.setString("resourceSubTypeId", model.resourceSubTypeId.toString());
          p.setString(
              "resourceSubTypeName", model.resourceSubTypeName.toString());
          //  p.setString("user_img", model.imageUrl.toString());
          p.setString("mobileCode", model.mobileCode.toString());
          p.setString("mobileNo", model.mobileNo.toString());
          p.setString("email", model.email.toString());
          p.setString("code", model.code.toString());
          p.setString("designation", model.designation.toString());
          p.setString("name", model.name.toString());

          print("model.imageUrl.toString()>>${model.imageUrl.toString()}");
        }

        /// Navigate other screen...................
      } else {
        // CustomLoader.showAlertDialog(context, false);
      }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// GetResourcePRofile.......
  static Future<void> RequestGetResourceProfile(BuildContext context,
      List<GetResorcePRofile> getresorceprofileList) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    // {id: 5, taskLogId: 153, fileName: "", file: null, type: "Doc",…}
    print(
        "DeleteTaskLogDocuments url>>${main_base_url + AllApiServices.GetResourceProfile}");

    //  CustomLoader.showAlertDialog(context, true);

    var request = {};

    print("request>>>${request}");
    // CustomLoader.showAlertDialog(context, true);

    try {
      var response = await http.get(
          Uri.parse(main_base_url + AllApiServices.GetResourceProfile),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>>" + jsonResponse.toString());
      print(jsonResponse);
      if (response.statusCode == 200) {
        GetResorcePRofile model = GetResorcePRofile.fromJson(jsonResponse);
        getresorceprofileList.add(model);

        // CustomLoader.showAlertDialog(context, false);
        print("getresorceprofileList>>>" +
            getresorceprofileList.length.toString());
      } else {
        //  CustomLoader.showAlertDialog(context, false);
      }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  /// GetResourcePRofile.......
  static Future<void> RequestGetTermsAndCondtions(
      BuildContext context, String data) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    print(
        "DeleteTaskLogDocuments url>>${main_base_url + AllApiServices.GetResourceProfile}");


    var request = {};

    print("request>>>${request}");

    try {
      var response = await http.get(
          Uri.parse(main_base_url + AllApiServices.GetTermsAndCondtions),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("response>>${response.body}");
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>>" + jsonResponse.toString());
      print(jsonResponse);
      if (response.statusCode == 200) {
        data = jsonResponse.toString();
        print("getresorceprofileList>>>" + jsonResponse.toString());
      } else {
        //  CustomLoader.showAlertDialog(context, false);
      }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  /// SuperVisedResources  .......
  static Future<void> RequestSuperVisedResources(BuildContext context,
      List<SuperVisedResourcesModel> superviserdresourceslist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    print("timezone >>${status}");
    print(
        "GetSupervisedResources url>>${status == "4" ? main_base_url + AllApiServices.scheduleapi + AllApiServices.GetSupervisedResources : main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.GetSupervisedResources}");

    //CustomLoader.showAlertDialog(context, true);

    var request = {};

    print("request>>>${request}");
    // CustomLoader.showAlertDialog(context, true);
    try {
      var response = await http.get(
          Uri.parse(

            // status == "4"?
            //    main_base_url + AllApiServices.scheduleapi+AllApiServices.GetSupervisedResources
            // :
              main_base_url +
                  AllApiServices.base_name_PPmApi +
                  AllApiServices.GetSupervisedResources),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      parsed.forEach((e) {
        SuperVisedResourcesModel model = SuperVisedResourcesModel.fromJson(e);
        superviserdresourceslist.add(model);
      });

      //superviserdresourceslist =  parsed.map<SuperVisedResourcesModel>((json) => SuperVisedResourcesModel.fromJson(json)).toList();
      print("getresorceprofileList>>>" +
          superviserdresourceslist.length.toString());
      //  } else {
      //  CustomLoader.showAlertDialog(context, false);
      // }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  /// SuperVisedResources  .......
  static Future<void> RequestTransferWorkOrders(
      BuildContext context,
      List<TransferWorkordersModel> transferworkorderslist,
      String taskLogIds,
      String comments,
      String resourceId,
      String serviceTypeId,
      bool isMobile) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    print("status >>${status}");
    print(
        "GetSupervisedResources url>>${main_base_url + AllApiServices.TransferWorkOrders}");

    var request = {};
    request['taskLogIds'] = taskLogIds;
    request['comments'] = comments;
    request['resourceId'] = resourceId;
    request['serviceTypeId'] = serviceTypeId;
    request['isMobile'] = isMobile;

    print("transferworkorderslist request>>>${request}");
    ;
    try {
      CustomLoader.showAlertDialog(context, true);
      var response = await http.post(
          Uri.parse(
            // status == "4"?
            // main_base_url + AllApiServices.scheduleapi+AllApiServices.TransferWorkOrders
            // :
              main_base_url +
                  AllApiServices.base_name_PPmApi +
                  AllApiServices.TransferWorkOrders),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      CustomLoader.showAlertDialog(context, false);

      parsed.forEach((e) {
        TransferWorkordersModel model = TransferWorkordersModel.fromJson(e);
        transferworkorderslist.add(model);
      });
      if (transferworkorderslist.isNotEmpty) {
        if (transferworkorderslist.first.isSuccess.toString() == "true") {
          CustomToast.showToast(
              msg: transferworkorderslist.first.message.toString());
        }
      }
      print("transferworkorderslistList>>>" +
          transferworkorderslist.length.toString());
      //  } else {
      //
      // }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }


  /// Announcements.......
  static Future<void> RequestAnnouncements(
      BuildContext context,
      bool load,
      List<AnnouncementModel> announcementlist) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    try {
      // Loader True.....................
      load == true ? CustomLoader.ProgressloadingDialog(context, true) : null;

      var request = {};
      String main_url = "${main_base_url + AllApiServices.base_name_HrmsmgmtApi + AllApiServices.Announcement_Announcements}";

      print("main url <<< ${main_url}");
      print("request url <<< ${request}");
      var response = await http.get(Uri.parse(main_url),
          headers: {
            "Content-Type": "application/json",
            "accept": "application/json",
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });


      print(response.body);
      load == true ? CustomLoader.ProgressloadingDialog(context, false) : null;
      if (response.statusCode == 200) {
       // final data = json.decode(response.body);
      //  print("Mobile_GetWorkOrdersByServiceType data>>${data}");

        // List<Map<String, dynamic>> jsonResponse =
        // List<Map<String, dynamic>>.from(data);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
        announcementlist.clear();
        print(
            "AnnouncementModel jsonResponse ${jsonResponse}");
        var data = jsonResponse['data'];
        if (data != null) {
          data.forEach((e) {
            AnnouncementModel model = AnnouncementModel.fromJson(e);
            announcementlist.add(model);
            print(
                "announcementlist >>>${announcementlist.length}");
          });
        }

      } else {
      }
    } on SocketException catch (e) {
      await Future<int>.delayed(Duration(seconds: 1));
      load == true ? CustomLoader.ProgressloadingDialog(context, false) : null;
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// TaskLogOperations/AddOrUpdateTaskLogImages Api call....
  static Future<void> RequestTaskLogOperationsAddOrUpdateTaskLogImages(
      BuildContext context,
      String task_logId,
      String isbefor_aftercheck,
      var _image) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();

    String main_url =
        "${status == "4"?
    main_base_url+AllApiServices.scheduleapi+AllApiServices.AddOrUpdateTaskLogImages:
    main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.AddOrUpdateTaskLogImages}";
    print("TaskLog_GetProjectsMasterData murl >> ${main_url}");

    // CustomLoader.ProgressloadingDialog(context, true);
    List<String> imagenamelist = [];
    List<String> imagetaglist = [];
    var tag;
    var image;
    String savename = "";
    print("_image>>${_image.length}");

    for (int i = 0; i < _image.length; i++) {
      image = _image[i]!.toString().split(".");
      tag = image[1];
      imagetaglist.add(tag);
      for (int j = 0; j < imagetaglist.length; j++) {
        print("imagetaglist>${imagetaglist[j]}");
        var rng = Random();
        for (var i = 0; i < 20; i++) {
          print(rng.nextInt(100));
        }
        savename = imagetaglist[j] == "pdf"
            ? "${rng.nextInt(100)}.pdf"
            : "${rng.nextInt(100)}.png";
        imagenamelist.add(savename);
        print("savename>>${imagenamelist.length}");
      }
    }

    var headers = {'Authorization': 'Bearer ${p.getString("access_token")}'};
    // 22372
    try {
      var request = http.MultipartRequest('POST', Uri.parse(main_url));
      for (int i = 0; i < _image.length; i++) {
        request.fields.addAll({
          'images[$i].id': '0',
          'images[$i].taskLogId': task_logId,
          'images[$i].fileName': '${imagenamelist[0]}',
          'images[$i].attachmentType': 'Img',
          'images[$i].resourceUrl': '',
          'images[$i].extension': imagetaglist[i],
          'images[$i].isBeforeImage': isbefor_aftercheck.toString()
        });
        request.files.add(await http.MultipartFile.fromPath(
            'images[$i].file', _image[i]!.path));
      }
      print("request image>> ${request.fields}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      //  CustomLoader.ProgressloadingDialog(context, false);
      if (response.statusCode == 200) {
        print("add image response>>" + await response.stream.bytesToString());
        CustomToast.showToast(msg: e.toString());
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }

  /// RequestWODetailScreenscan..................
  static Future<void> RequestWODetailScreenscan(BuildContext context, bool load, String taskLogIds,
      String assetCode,Function oncallback,String resourceId,String startdate,String containdate,String finishdate) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    load == true ? CustomLoader.showAlertDialog(context, true) : null;

    var request = {};
    try {
      final response = await http.get(
          Uri.parse(main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.Mobile_ValidateWorkOrderAsset + "/" + taskLogIds + "/" + assetCode),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });
      print("URLSCanCode.............${main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.Mobile_ValidateWorkOrderAsset + "/" + taskLogIds + "/" + assetCode}");

      if (response.statusCode == 200) {
        print("jsonResponse.....${response.body}");
        if (response.body == "false"){
          Fluttertoast.showToast(msg: "Invalid Asset Code");
        }else{
          oncallback(response.body.toString(),resourceId,startdate,containdate,finishdate);
        }
      }
      else {
        Fluttertoast.showToast(msg: "Invalid Asset Code");
      }
    } on SocketException catch (e) {
      CustomLoader.showAlertDialog(context, false);
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  /// RequestAssignResources  .......
  static Future<void> RequestAssignResources(BuildContext context,
      List<GetAssignResourcesData> getAssignsourceslist,
      String projectId ,
      String taskLogId,
      String serviceTypeId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    print("timezone >>${status}");

    var requestAssign = {};
    try {
      final response = await http.get( Uri.parse(
          status == "4"?
          main_base_url + AllApiServices.scheduleapi + AllApiServices.GetAdditionalResourcesforWorkOrder +
              "${"/"}${projectId }/${taskLogId}/${serviceTypeId}"
              :
          main_base_url +
              AllApiServices.base_name_PPmApi + AllApiServices.GetAdditionalResourcesforWorkOrder +
              "${"/"}${projectId }/${taskLogId}/${serviceTypeId}"

      ),

        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          'Authorization': 'Bearer ${p.getString("access_token")}'
        }
        ,);

      print('Status code: ${response.statusCode}');
      print('Response body======: ${response.body}');
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data = jsonResponse['data'];
        data.forEach((e) {
          GetAssignResourcesData model = GetAssignResourcesData.fromJson(e);
          getAssignsourceslist.add(model);
        });

      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    return;
  }

  /// Reassign orkOrder.......
  static Future<void> RequestReassignWorkOrder(
      BuildContext context,String taskLogId,String resourceId,String comments,Function OnCallBackReassign) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    var request = {};
    request['taskLogId'] = taskLogId;
    request['resourceId'] = resourceId;
    request['comments'] = comments;
    try {
      CustomLoader.showAlertDialog(context, true);
      var response = await http.post(
          Uri.parse(
              status == "4"?
              main_base_url + AllApiServices.scheduleapi +AllApiServices.Mobile_ReassignWorkOrder
                  :
              main_base_url + AllApiServices.base_name_PPmApi +AllApiServices.Mobile_ReassignWorkOrder
          ),
          body: convert.jsonEncode(request),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("response>>${response.body}");

      if (response.statusCode == 200) {
        String status = response.body.toString();
        if(status == "true"){
          OnCallBackReassign(status);
        }
      } else {
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }


  /// TaskLogOperations/AddOrUpdateTaskLogImages Api call....
  static Future<void> AddOrUpdateTaskLogImages(
      BuildContext context,
      String task_logId,
      String isbefor_aftercheck,
      var _image) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var base_url = p.getString("mainurl");
    String status = p.getString("menu_ID").toString();
    CustomLoader.showAlertDialog(context, true);
    String main_url =
        "${status == "4"?
    main_base_url+AllApiServices.scheduleapi+AllApiServices.AddOrUpdateTaskLogImages:
    main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.AddOrUpdateTaskLogImages}";
    print("TaskLog_GetProjectsMasterData murl >> ${main_url}");

    // CustomLoader.ProgressloadingDialog(context, true);
    List<String> imagenamelist = [];
    List<String> imagetaglist = [];
    var tag;
    var image;
    String savename = "";

    var headers = {'Authorization': 'Bearer ${p.getString("access_token")}'};
    try {
      var request = http.MultipartRequest('POST', Uri.parse(main_url));
      for (int i = 0; i < _image.length; i++) {

        image = _image![i].path.toString().split(".");
        var str_image = "${image[image.length-2]}";
        tag = "${image[image.length-1]}";
        imagetaglist.add(tag);


        var imagename = str_image.toString().split("/");
        String savename = "${imagename[imagename.length-1]}";
        imagenamelist.add(savename);


        request.fields.addAll({
          'images[$i].id': '0',
          'images[$i].taskLogId': task_logId,
          'images[$i].fileName': savename,
          'images[$i].attachmentType': 'Img',
          'images[$i].resourceUrl': '',
          'images[$i].extension': tag,
          'images[$i].isBeforeImage': isbefor_aftercheck.toString()
        });

        var stream = new http.ByteStream(_image![i].openRead());
        var length = await _image![i].length();
        request.files.add(await http.MultipartFile('images[$i].file',stream,length,filename:"${savename}.${tag}",
          contentType: MediaType("Image",tag),
        ));
      }
      print("request image>> ${request.fields}");

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        // CustomToast.showToast(msg: e.toString());
      } else {
        print(response.reasonPhrase);
      }
    } on SocketException catch (e) {
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }


  /// Assign To.......
  static Future<void> RequestAssignTo(
      BuildContext context, List<AssignToModel> assigntolist,String projectId,String taskLogId,String serviceTypeId) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    var request = {};
    try {
      CustomLoader.showAlertDialog(context, true);
      var response = await http.get(
          Uri.parse(
              status == "4"?
              main_base_url + AllApiServices.scheduleapi +AllApiServices.GetAdditionalResourcesforWorkOrder+"/${projectId}/${taskLogId}/${serviceTypeId}"
                  :
              main_base_url + AllApiServices.base_name_PPmApi +AllApiServices.GetAdditionalResourcesforWorkOrder+"/${projectId}/${taskLogId}/${serviceTypeId}"
          ),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${p.getString("access_token")}"
          });

      print("response>>${response.body}");
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse>>>" + jsonResponse.toString());
      CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        if(jsonResponse != null){
          var data = jsonResponse['data'];

          if(data != null){
            data.forEach((e){
              AssignToModel model = AssignToModel.fromJson(e);
              assigntolist.add(model);
            });
          }
        }
      } else {
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }


  /// AdditionolInfo ........
static  Future<void> RequestAdditionolInfoo(BuildContext context, bool load,List<AdditionalInfoResponse> additionalInfoResponse,
      String taskLogId
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();

    CustomLoader.showAlertDialog(context, true);

    print("ur........${status == "4"
        ? main_base_url +
        AllApiServices.scheduleapi +
        AllApiServices.task_log_additionol_info +
        taskLogId.toString()
        : main_base_url +
        AllApiServices.base_name_PPmApi +
        AllApiServices.task_log_additionol_info +
        taskLogId.toString()}");
    try {
      final response = await http.get(
          Uri.parse(status == "4"
              ? main_base_url +
              AllApiServices.scheduleapi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()
              : main_base_url +
              AllApiServices.base_name_PPmApi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      print("test jsonResponse........${jsonResponse}");
     if(jsonResponse != null){
       AdditionalInfoResponse mainresponse = AdditionalInfoResponse.fromJson(jsonResponse);
       additionalInfoResponse.add(mainresponse);

      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }


}


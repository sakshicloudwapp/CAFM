import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/NewScreens/NoticeScreen.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/model/models/AnnoucementsResponse.dart';
import 'package:fm_pro/model/models/GetNotificationWorkOrdersModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/signin_screen.dart';
import 'package:fm_pro/views/PPM/ppm_new_workorder_screen.dart';
import 'package:fm_pro/views/PPM/ppm_screen.dart';
import 'package:fm_pro/views/Reactive/reactive_workorders_screen.dart';
import 'package:fm_pro/views/announcement/AnnouncementScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/home_list_model.dart';
import '../model/models/GetResourceModel.dart';
import '../model/models/GetUserModel.dart';
import '../model/models/homePageModel.dart';
import '../services/webservices.dart';
import '../utils/list.dart';
import 'notification_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

List<HomeListModel> homeModelList = [];
String card_title = "";

///chart.............................
class ChartData {
  ChartData(this.x, this.y1, this.y2, this.y3, this.y4);

  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
}

class TabHomeScreen extends StatefulWidget {
  String pagename;

  Function updatestatus;

  TabHomeScreen({Key? key, required this.pagename, required this.updatestatus})
      : super(key: key);
  final String title = "Charts Demo";

  @override
  _TabHomeScreenState createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {
  late PageController controller;

  int currentIndex = 0;
  List<String> staticList = <String>[];
  bool is_hide = true;

  ///chart
  late TooltipBehavior _tooltip;
  late List<ChartData> chartData;
  List<HomePageModel> gethomepageList = [];
  List<GetUserModel> getuserlist = [];
  List<GetNotificationWorkOrdersModel> getNotificationList = [];
  List<AnnouncementModel> announcementlist = [];

  List<HomePageDataModel> gethomepagedataList = [];
  String name = "";
  String user_name = "";
  String user_img = "";
  String user_designation = "";
  String Getmenuid = "";
  String body_status = "home";
  String displayName = "";
  String title = "";
  String serviceTypeId = "";

  /// Api Calling..........
  Future<void> RequestGetHomePage(
      BuildContext context,
      List<HomePageModel> gethomepageList,
      List<HomePageDataModel> gethomepagedataList,
      bool load) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    print("tocken>>>${p.getString("access_token")}");

    var base_url = p.getString("mainurl");

    print("baseurl >> ${base_url}");

    // Loader True.....................
    //  CustomLoader.showAlertDialog(context, true);

    String main_url = "${base_url.toString() + AllApiServices.Gethomepage}";
    print("url >> ${main_url}");
    widget.pagename == "3" ? null : CustomLoader.showAlertDialog(context, true);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${p.getString("access_token")}'
    };

    try {
      // http://216.48.190.5/PMAPI/api/Mobile/GetWorkOrderCount
      // http://216.48.190.5/PMApi/api/GetWorkOrderCount
      var request = http.Request('GET', Uri.parse(main_url));
      request.body = '''''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // Future.delayed(Duration(seconds: 0),(){
      widget.pagename == "3"
          ? null
          : CustomLoader.showAlertDialog(context, false);

      //  });
      // await Future<int>.delayed(Duration(seconds: 0));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse =
        convert.jsonDecode(await response.stream.bytesToString());

        print("fgrhjhjd" + jsonResponse.toString());
        // print("jsonResponse>>>"+await response.stream.bytesToString().toString());
        HomePageModel model = HomePageModel.fromJson(jsonResponse);
        gethomepageList.add(model);

        this.setState(() {});
        var list = jsonResponse['data'];

        list.forEach((e) {
          HomePageDataModel model2 = HomePageDataModel.fromJson(e);
          gethomepagedataList.add(model2);
          setState(() {});
        });

        print("list>>${gethomepagedataList.length}");
        print("gethomepageList>>${gethomepageList.length}");
      } else {
        print("jfbjjgfc");
        //  await Future<int>.delayed(Duration(seconds: 1));
        response.reasonPhrase.toString() == "Unauthorized"
            ? p.setBool("isLogin", false)
            : null;

        response.reasonPhrase.toString() == "Unauthorized"
            ? PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(),
          screen: SigninScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        )

        //   CustomNavigator.custompushAndRemoveUntil(context, SigninScreen())
            : null;
        print(response.reasonPhrase.toString());
      }
    } on SocketException catch (e) {
      widget.pagename == "3"
          ? null
          : CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
  }

  gethome() async {
    gethomepageList.clear();
    setState(() {});
    // await Webservices.RequestGetWorkByOrdersType(context, getworklist, load, service_typeId)
    await RequestGetHomePage(
        context, gethomepageList, gethomepagedataList, true);
    setState(() {});
  }

  late PageController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    getSharedprefences();
    _controller = PageController(initialPage: 0);
    is_hide = true;
    Future.delayed(Duration.zero, () {
      getannouncementApi();
      getNotificationApi();
    });

    ///chart
    chartData = [
      ChartData('PPM', 80, 60, 0, 0),
      ChartData('RM', 30, 18, 0, 0),
      ChartData('Contractor', 50, 35, 0, 0),
      ChartData('Reactive', 78, 50, 0, 0)
    ];
    _tooltip = TooltipBehavior(enable: true);

    controller = new PageController();
    staticList.add("1");
    staticList.add("2");
    staticList.add("3");
    staticList.add("4");
    gethome();
  }

  SharedPreferences? pre;

  getSharedprefences() async {
    getuserApi();
    pre = await SharedPreferences.getInstance();
    user_name = pre!.getString("user_name").toString();
    user_img = pre!.getString("user_profile").toString();
    user_designation = pre!.getString("designation").toString();
    print("username>>${user_img}");

    setState(() {});
  }

  onCallBack(String title,String back) {
    card_title = title;
    body_status = back;
    print("body_status");
    setState(() {});
  }

  getuserApi() async {
    await Webservices.RequestGetUserInformation(context, getuserlist);
    setState(() {});
  }

  getannouncementApi() async {
    announcementlist.clear();
    setState(() {});
    await Webservices.RequestAnnouncements(context, false, announcementlist);
    setState(() {});
  }

  getNotificationApi() async {
    getNotificationList.clear();
    setState(() {});
    await Webservices.RequestGetNotificationWorkOrders(context,getNotificationList);
    setState(() {});

}

  List<ResourcesModel> resourceslist = [];

  getResorce() async {
    resourceslist.clear();
    await Webservices.RequestGetResource(context, "2", resourceslist);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuerryData.copyWith(
          textScaleFactor: 1.0,
          devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
      child: Scaffold(
        appBar:  body_status == "dash_home"? null:  PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            backgroundColor: myColors.app_theme,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: myColors.app_theme,
              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: Container(
              color: myColors.app_theme,
              padding: EdgeInsets.fromLTRB(10, 18, 10, 0),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    child: CircleAvatar(
                      radius: 60,
                      child: user_img.toString() == "null"
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/user_img.png",
                            fit: BoxFit.cover,
                            width: 45,
                            height: 45,
                          ))
                          : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            user_img,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                  loadingProgress.expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, exception, stackTrace) {
                              return Image.asset(
                                "assets/images/user_img.png",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              );
                            },
                            width: 45,
                            height: 45,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //  height: 45,
                      padding: EdgeInsets.fromLTRB(10, 13, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                               user_name.toString() == "null"
                                  ? ""
                                  : "Hi," + user_name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily:
                                "assets/fonts/DM_Sans/DMSans-Bold.ttf",
                                color: myColors.white,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              user_designation.toString() == "null"
                                  ? ""
                                  : user_designation,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily:
                                "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                                color: myColors.yellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Notification Icon.........
                  InkWell(
                    onTap: () {

                      //  CustomLoader.showAlertDialog(context);
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: NotifiicationScreen(getworklist: getNotificationList,),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: 130,
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/images/ic_notification.svg",
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.fromLTRB(15, 1, 0, 0),
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                                color: myColors.color_red,
                                shape: BoxShape.circle),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${getNotificationList.length.toString()}",
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 9,

                                  fontWeight: FontWeight.w700,
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: 'assets/font/poppins_regular.ttf',
                                  color: myColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: body_status == "home"?
        homebody():
        body_status == "dash_home"?
        ReactiveWorkordersScreen(
          callback: onCallBack,
          serviceTypeId: serviceTypeId,
          updatestatus: widget.updatestatus,
          title: title,
          appbartitle: displayName,
        )
            :Container(),
      ),
    );
  }


  homebody(){
    return Container(
       child: RefreshIndicator(
         onRefresh: () {
           return Future.delayed(
             Duration(seconds: 0),
                 () {
               WidgetsBinding.instance
                   .addPostFrameCallback((_) => getResorce());
               setState(() {});
             },
           );
         },
         child: Container(
           // padding: EdgeInsets.only(bottom: 8),
           height: MediaQuery.of(context).size.height,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.only(
                 topRight: Radius.circular(30),
                 topLeft: Radius.circular(30),
                 bottomRight: Radius.circular(0),
                 bottomLeft: Radius.circular(0)),
             color: myColors.white,
           ),
           child: SingleChildScrollView(
             child: Column(
               children: [
                 /// Search------------................

                 /*Container(
                    margin: EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontFamily: "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                              color: Color(0xffAAA6B9)
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff1f1f1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "assets/fonts/DM_Sans/DMSans-Regular.ttf",
                                  color: Color(0xffAAA6B9)),
                              prefixIcon:  InkWell(
                                onTap: (){
                                },
                                child: Icon(Icons.search,color: Colors.grey,)
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: (){

                          },
                          child: Image.asset("assets/images/filter_icon.png",height: 25,width: 25,),
                        )
                      ],
                    ),
                  ),*/

                 /// Gradient Container..............
                 /*   is_hide == true ? Container(
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                   // height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFFF8B806),
                            const Color(0xFFFF8C04),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                      borderRadius: BorderRadius.circular(10.0
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 25, 20),
                          child: Image.asset("assets/images/esclamation_icon.png",height: 30,width: 30,),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Plumbing Issue",
                            style: TextStyle(
                              fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Bold.ttf",
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Request raised  , will get back you soon",
                              style: TextStyle(
                                  fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Regular.ttf",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10
                              , 20),
                          child: Text("27-08-2023",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 8,
                            fontFamily: "assets/fonts/Plus_Jakarta_Sans/PlusJakartaSans-Bold.ttf",
                            color: myColors.white
                          ),
                          )
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: (){
                                is_hide = false;
                                print("is_hide........$is_hide");
                                setState(() {
                                });
                              },
                              child: Image.asset("assets/images/cross_icon.png",height: 20,width: 20,)),
                        ),

                      ],
                    ),
                  ) : Container(),*/
                 ///Workorders...........................................................................................................
                 /*   Container(
                    padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      MyString.Home,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: "assets/fonts/Poppins/Poppins-SemiBold.ttf",
                        color: myColors.dark_grey_txt,
                      ),
                    ),
                  ),
                  */
                 ///Grids..............................................................................................................

                 gethomepagedataList.isEmpty
                     ? Container()
                     : Container(
                   padding: EdgeInsets.fromLTRB(0, 20, 0, 16),
                   child: GridView.count(
                       physics: ClampingScrollPhysics(),
                       shrinkWrap: true,
                       crossAxisCount: 3,
                       childAspectRatio: 2.1 / 2,
                       crossAxisSpacing: 2 / 2,
                       mainAxisSpacing: 4 / 2.5,
                       children: List.generate(
                           gethomepagedataList.length, (index) {
                         return InkWell(
                           onTap: () async {
                             SharedPreferences p =
                             await SharedPreferences.getInstance();

                             card_title = gethomepagedataList[index]
                                 .displayName
                                 .toString();
                             Getmenuid = gethomepagedataList[index]
                                 .id
                                 .toString();
                             p.setString(
                                 "menu_ID", Getmenuid.toString());
                             print("Getmenuid>>${Getmenuid}");
                             setState(() {});

                             print(
                                 "displayname>>${gethomepagedataList[index].displayName.toString()}");
                             if (Getmenuid.toString() == "2") {
                               body_status = "dash_home" ;
                               displayName =  gethomepagedataList[index].displayName.toString();
                               serviceTypeId = "2";
                               title = 'Reactive Workorder';
                               setState(() {});
                             } else if (Getmenuid.toString() == "3") {
                               body_status = "dash_home" ;
                               displayName =  gethomepagedataList[index].displayName.toString();
                               serviceTypeId = "3";
                               title = 'Corrective Workorder';
                               setState(() {});
                             } else if (Getmenuid.toString() == "1") {
                               body_status = "dash_home" ;
                               displayName =  gethomepagedataList[index].displayName.toString();
                               serviceTypeId = "1";
                               title = 'PPM Workorder';
                               setState(() {});
                             } else if (Getmenuid.toString() == "4") {
                               body_status = "dash_home" ;
                               displayName =  gethomepagedataList[index].displayName.toString();
                               serviceTypeId = "4";
                               title = 'Soft Services PM';
                               setState(() {});
                             }else if (Getmenuid.toString() == "6") {
                               body_status = "dash_home" ;
                               displayName =  gethomepagedataList[index].displayName.toString();
                               serviceTypeId = "6";
                               title = gethomepagedataList[index].displayName.toString();
                               setState(() {});
                             }
                           },
                           child: HomeGridList(
                             index: index,
                             model: gethomepagedataList[index],
                           ),
                         );
                       })),
                 ),

                 /// Comment all Ui


                 //Announcements................................................................................................................................................................................................
                 /*Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
                        alignment: Alignment.topLeft,
                        child: CustomText.CustomBoldText(
                            MyString.Announcements,
                            myColors.dark_grey_txt,
                            FontWeight.w600,
                            16,
                            1,
                            TextAlign.center),
                      ),


                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: (){
                          CustomNavigator.custompush(context, AnnounceMentScreen(),true);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(24, 24, 16, 0),
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomMediumText(
                              MyString.View_All,
                              myColors.app_theme,
                              FontWeight.w500,
                              14,
                              1,
                              TextAlign.center),
                        ),
                      ),
                    ],
                  ),*/

                 //Announcement List................................................................................................
                 /* Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Container(
                                child: AnnouncementList(
                                  index: index,
                                ),
                              ),
                            );
                          })),*/

                 //Any New Issue..................................................................................................
                 InkWell(
                   onTap: () {
                     CustomNavigator.pushNavigate(
                         context,PPM_New_Workorder_Screen(title:   MyString.Create_reactiveWork_order, appbartitle: "",assetcode: '', ServiceId: '2', ppmId: '', parentId: 0,));
                   },
                   child: Container(
                     margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
                     alignment: Alignment.center,
                     width: MediaQuery.of(context).size.width / 1.7,
                     padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(30)),
                       color: myColors.app_theme,
                     ),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                           height: 35,
                           width: 35,
                           alignment: Alignment.centerLeft,
                           child: Image.asset(
                             "assets/images/issue_icon.png",
                             height: 25,
                             width: 25,
                           ),
                         ),
                         Container(
                           alignment: Alignment.center,
                           child: Text(
                             MyString.RiseAIssue,
                             style: TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.w600,
                               fontFamily: MyString.PlusJakartaSansregular,
                               color: myColors.white,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),

                 //Analytics.................................................................................................

                 Container(
                   padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
                   alignment: Alignment.topLeft,
                   child: Text(
                     MyString.Analytics,
                     style: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w700,
                       fontFamily: MyString.PlusJakartaSansBold,
                       color: myColors.blue_1,
                     ),
                   ),
                 ),

                 //Graph............................................................................................................
                 Container(
                     padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                     child: graphui()),

                 ///Announcements,.................................................................................................
                 Container(
                   width: double.infinity,
                   child: Container(
                     padding: EdgeInsets.fromLTRB(0, 8, 0, 10),
                     margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                     color: myColors.white,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                               alignment: Alignment.topLeft,
                               child: CustomText.CustomBoldText(
                                   MyString.Announcements,
                                   myColors.blue_1,
                                   FontWeight.w700,
                                   16,
                                   1,
                                   TextAlign.center),
                             ),
                             announcementlist.isNotEmpty?   InkWell(
                               onTap: () {
                                 PersistentNavBarNavigator.pushNewScreen(
                                   context,
                                   screen: NoticeScreen(),
                                   withNavBar: false,
                                   // OPTIONAL VALUE. True by default.
                                   pageTransitionAnimation:
                                   PageTransitionAnimation.fade,
                                 );
                                 setState(() {});
                               },
                               child: Container(
                                 padding: EdgeInsets.fromLTRB(24, 0, 16, 0),
                                 alignment: Alignment.topLeft,
                                 child: CustomText.CustomRegularText(
                                     MyString.View_All,
                                     myColors.app_theme,
                                     FontWeight.w500,
                                     14,
                                     1,
                                     TextAlign.center),
                               ),
                             ) : Container(),
                             // Container(
                             //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                             //   alignment: Alignment.topLeft,
                             //   child: CustomText.CustomBoldText(
                             //       announcementlist.length.toString(),
                             //       myColors.blue_1,
                             //       FontWeight.w700,
                             //       16,
                             //       1,
                             //       TextAlign.center),
                             //   ),
                           ],
                         ),

                         //Notification list................................................................................................................................
                         announcementlist.isEmpty?Container(
                           margin: EdgeInsets.only(top: 20),
                           child: Center(
                             child: NoAnnouncement(),
                           ),
                         ):
                         Container(
                             width: double.infinity,
                             margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                             child: SingleChildScrollView(
                                 padding: EdgeInsets.zero,
                                 scrollDirection: Axis.horizontal,
                                 child: Row(
                                   children: List.generate(
                                       announcementlist.length,
                                           (index) => Container(
                                         padding: EdgeInsets.only(right: 10),
                                         width: MediaQuery.of(context)
                                             .size
                                             .width /
                                             1.12,
                                         child: NotificationList(
                                           index: index,
                                           model:
                                           announcementlist[index],
                                         ),
                                       )),
                                 ))),
                       ],
                     ),
                   ),
                 ),

                 ///Notification view all................................................................................................................................................................................................
                 /*  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
                        alignment: Alignment.topLeft,
                        child: CustomText.CustomSemiBoldText(
                            MyString.Notifications,
                            myColors.blue_1,
                            FontWeight.w700,
                            16,
                            1,
                            TextAlign.center),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: NoticeScreen(),
                            withNavBar: false,
                            // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                            PageTransitionAnimation.fade,
                          );
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(24, 24, 16, 0),
                          alignment: Alignment.topLeft,
                          child: CustomText.CustomBoldText(
                              MyString.View_All,
                              myColors.app_theme,
                              FontWeight.w500,
                              14,
                              1,
                              TextAlign.center),
                        ),
                      ),
                    ],
                  ),

                  ///Notification list 2............................................................................................
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                getNotificationList.length,
                                    (index) => Container(
                                  width: MediaQuery.of(context).size.width /
                                      1.1,
                                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: NotificationTwoList(index: index,
                                  model: getNotificationList[index],
                                  ),
                                )),
                          ))),*/

                 SizedBox(
                   height: 20,
                 ),

                 /// Comment
                 //Latest  Workorders.................................................................................................
                 /* Container(
                    padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
                    alignment: Alignment.topLeft,
                    child: CustomText.CustomBoldText(
                        MyString.Latest_Workorders,
                        myColors.dark_grey_txt,
                        FontWeight.w700,
                        15,
                        1,
                        TextAlign.center),
                  ),*/

                 //Latest  Workorders list................................................................................................................................
                 /*  Container(
                      height: 85,
                      margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                staticList.length,
                                (index) => Container(
                                      width: 250,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: LatestWorkordersList(index: index),
                                    )),
                          ))),*/
               ],
             ),
           ),
         ),
       )
    );
  }
  NoAnnouncement(){
    return Container(

      width: double.infinity,
      child: Image.asset("assets/new_images/mask_group.png",width: double.infinity,),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 15,
      margin: EdgeInsets.only(right: 4, left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? myColors.yellow : myColors.grey_bar1,
      ),
    );
  }

  void NavigateFunction(var page) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: curveList[4], parent: animation);
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }));
  }

  /// graph ui.......

  graphui() {
    return SfCartesianChart(
        borderWidth: 0,
        plotAreaBorderColor: myColors.mytransparent,
        enableSideBySideSeriesPlacement: true,
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
          labelPlacement: LabelPlacement.betweenTicks,
          interval: 1,
          placeLabelsNearAxisLine: false,
          // arrangeByIndex: true
          labelAlignment: LabelAlignment.end,
          axisLine: AxisLine(
            color: myColors.color_bar_bg,
            width: 0,
          ),
          title: AxisTitle(
              text: 'Workorders per type',
              textStyle: TextStyle(
                  color: myColors.black,
                  fontFamily: "assets/fonts/Poppins/Poppins-Regular.ttf",
                  fontSize: 10,
                  fontWeight: FontWeight.w500)),

          labelStyle: TextStyle(
              color: myColors.label_bar,
              fontFamily: "assets/fonts/Poppins/Poppins-Regular.ttf",
              fontSize: 8,
              fontWeight: FontWeight.w400),

          majorTickLines: MajorTickLines(
            size: 0,
            width: 0,
          ),

          minorTickLines: MinorTickLines(
            size: 0,
            width: 0,
          ),

          majorGridLines: MajorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
            // dashArray: <double>[5,5]
          ),
          minorGridLines: MinorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
          ),
        ),
        primaryYAxis: CategoryAxis(
          minimum: 0,
          maximum: 100,
          maximumLabels: 6,
          placeLabelsNearAxisLine: false,
          // labelFormat: '{value} ',
          labelPlacement: LabelPlacement.betweenTicks,
          interval: 20,
          axisLine: AxisLine(
            color: myColors.color_bar_bg,
            width: 0,
          ),
          title: AxisTitle(
              text: '',
              textStyle: TextStyle(
                  color: myColors.black,
                  fontFamily: "assets/fonts/Poppins/Poppins-Regular.ttf",
                  fontSize: 11,
                  fontWeight: FontWeight.w400)),
          labelStyle: TextStyle(
              color: myColors.grey_seven,
              fontFamily: "assets/fonts/Poppins/Poppins-Regular.ttf",
              fontSize: 8,
              fontWeight: FontWeight.w400),

          majorTickLines: MajorTickLines(
            size: 0,
            width: 0,
          ),
          minorTickLines: MinorTickLines(
            size: 0,
            width: 0,
          ),
          majorGridLines: MajorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
            // dashArray: <double>[5,5]
          ),
          minorGridLines: MinorGridLines(
            color: myColors.color_bar_bg,
            width: 1,
          ),
        ),
        series: <ChartSeries>[
          StackedColumnSeries<ChartData, String>(
              groupName: 'Group A',
              dataSource: chartData,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: myColors.newBar_1,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1),
          StackedColumnSeries<ChartData, String>(
              groupName: 'Group B',
              dataSource: chartData,
              color: myColors.app_theme,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2),
        ]);
  }
}

///Char...........................................

///Notification List.....................................................................................................................
class NotificationList extends StatefulWidget {
  int index;
  AnnouncementModel model;

  NotificationList({required this.index, required this.model});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
      margin: EdgeInsets.only(bottom: 10, left: 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            color: Color.fromRGBO(0, 0, 0, 0.15),
          )
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: myColors.bg_border_blue.withOpacity(0.40)),
        color: myColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /*Container(
            alignment: Alignment.center,
            child: Image.asset(
              width: MediaQuery.of(context).size.width,
              height: 200,
              "assets/images/notify_img.png",
              fit: BoxFit.contain
            ),
          ),*/
          Row(
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: CustomText.CustomSemiBoldText(
                            widget.model.title.toString(),
                            myColors.blue_1,
                            FontWeight.w500,
                            14,
                            1,
                            TextAlign.center),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 8, 0, 0),
                        child: CustomText.CustomRegularText(
                            widget.model.issueDate.toString() == "null"
                                ? ""
                                : DateFormat('EEEE MMM dd, yyyy')
                                .format(DateTime.parse(widget.model.issueDate.toString())),
                            // "Monday Jan 20 , 2020",
                            myColors.blue_1,
                            FontWeight.w400,
                            10,
                            1,
                            TextAlign.center),
                      ),
                    ],
                  )),
            ],
          ),
          widget.model.content.toString() == "null" ? Container(
            height: 8,
          ):
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Html(
                shrinkWrap: true,
                data: widget.model.content.toString().trim(),
                style: {
                  "html":Style(
                    // textAlign: TextAlign.left,
                    //  whiteSpace: WhiteSpace.pre,
                      color: myColors.grey_six,
                      fontSize:FontSize.small,
                      fontFamily: "PlusJakartaSansregular"
                  ),
                },
              )
            // CustomText.CustomLightText(
            //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare pretium placerat ut platea. Purus blandit integer sagittis massa vel est hac. ",
            //     myColors.grey_six,
            //     FontWeight.w400,
            //     10,
            //     3,
            //     TextAlign.start),
          ),
        ],
      ),
    );
  }
}

///Latest_Workorders List........................................................................................................................
class LatestWorkordersList extends StatefulWidget {
  int index;

  LatestWorkordersList({required this.index});

  @override
  _LatestWorkordersListState createState() => _LatestWorkordersListState();
}

class _LatestWorkordersListState extends State<LatestWorkordersList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: myColors.blue_light,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: CustomText.CustomSemiBoldText(
                      "PPM ID : #143268",
                      myColors.grey_three,
                      FontWeight.w600,
                      10,
                      1,
                      TextAlign.center),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 16,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: myColors.blue,
                ),
                child: CustomText.CustomBoldText(MyString.New, myColors.white,
                    FontWeight.w700, 8, 1, TextAlign.center),
              )
            ],
          ),
          Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
              child: CustomText.CustomRegularText(
                  "Bur Dubai DXB - stand alone / Electrical",
                  myColors.black,
                  FontWeight.w400,
                  12,
                  1,
                  TextAlign.center),
            ),
          ),
          Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: CustomText.CustomMediumText("Distribution  Board",
                  myColors.grey_four, FontWeight.w500, 10, 1, TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}

///HomeModelList...................................................................................................................
class HomeGridList extends StatefulWidget {
  int index;
  HomePageDataModel model;

  HomeGridList({Key? key, required this.index, required this.model})
      : super(key: key);

  @override
  _HomeGridListState createState() => _HomeGridListState();
}

class _HomeGridListState extends State<HomeGridList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addicon();
  }

  /// Add Icon.................
  addicon() {
    widget.model.iconName.toString() == "settings-icon"
        ? homeModelList.add(HomeListModel(widget.model.displayName.toString(),
        "assets/images/reactive_img.png"))
        : null;

    widget.model.iconName.toString() == "tools-icon"
        ? homeModelList.add(HomeListModel(widget.model.displayName.toString(),
        "assets/images/corrective.png"))
        : null;

    widget.model.iconName.toString() == "calendar-icon"
        ? homeModelList.add(HomeListModel(
        widget.model.displayName.toString(), "assets/images/ppm_img.png"))
        : null;

    widget.model.iconName.toString() == "contact-icon"
        ? homeModelList.add(HomeListModel(widget.model.displayName.toString(),
        "assets/images/contractor.png"))
        : homeModelList.add(HomeListModel(widget.model.displayName.toString(),
        "assets/images/contractor.png"));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              color: myColors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: myColors.app_theme, width: 0.6),
              boxShadow: [
                BoxShadow(
                    color: myColors.app_theme.withOpacity(0.05),
                    spreadRadius: 2),
              ]),
          child: Center(
              child: Image.asset(
                homeModelList[widget.index].image,
                height: 30,
                width: 30,
              )),
        ),
        Container(
          alignment: Alignment.center,
          child: CustomText.CustomSemiBoldText(
              widget.model.displayName.toString(),
              // == "PPM" ? "Hard Service PM" : widget.model.displayName.toString() == "SubContractor" ? "Soft Services PM" : widget.model.displayName.toString(),
              myColors.blue_1,
              FontWeight.w600,
              12,
              2,
              TextAlign.start),
        ),
      ],
    );
  }
}

///Announcement List...........................................................................................................
class AnnouncementList extends StatefulWidget {
  int index;

  AnnouncementList({Key? key, required this.index}) : super(key: key);

  @override
  _AnnouncementListState createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
      // height: 380,
      child: Column(
        children: [
          ///Name..........
          Container(
            child: Row(
              children: [
                Container(
                  width: 29,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Image.asset("assets/images/img_phone.png"),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: CustomText.CustomQuickBoldText(
                                "Name Last name",
                                myColors.grey_33,
                                FontWeight.w700,
                                12,
                                1,
                                TextAlign.center)),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                            child: CustomText.CustomBoldText(
                                "3:45 PM",
                                myColors.grey_two,
                                FontWeight.w400,
                                10,
                                1,
                                TextAlign.center)),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  height: 30,
                  child: Center(
                      child: Image.asset(
                        "assets/images/img_three_dots.png",
                        height: 15,
                        width: 5,
                      )),
                ),
              ],
            ),
          ),

          Container(
            child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 12, right: 8),
                child: CustomText.CustomLightText(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    myColors.black,
                    FontWeight.w300,
                    12,
                    3,
                    TextAlign.start)),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
            height: 236,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  "assets/images/img1.png",
                  height: 236,
                )),
          ),

          Container(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 12, 8, 12),
                  child: Center(
                      child: Image.asset(
                        "assets/images/img_heart.png",
                        height: 18,
                        width: 18,
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: Center(
                      child: Image.asset(
                        "assets/images/img_chat.png",
                        height: 18,
                        width: 18,
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: Center(
                      child: Image.asset(
                        "assets/images/img_arrow.png",
                        height: 18,
                        width: 18,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///Notification 2 List............................................................................................................
class NotificationTwoList extends StatefulWidget {
  int index;
  GetNotificationWorkOrdersModel model;

  NotificationTwoList({Key? key, required this.index, required this.model}) : super(key: key);

  @override
  _NotificationTwoListState createState() => _NotificationTwoListState();
}

class _NotificationTwoListState extends State<NotificationTwoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 50,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  child: CustomText.CustomLightText("12", myColors.grey_33,
                      FontWeight.w400, 30, 1, TextAlign.center),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: CustomText.CustomLightText("sep", myColors.grey_33,
                      FontWeight.w300, 12, 1, TextAlign.center),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: myColors.bg_border_blue),
                color: myColors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: myColors.bg_grey),
                        child: Image.asset(
                          "assets/images/img_notification2.png",
                          height: 20,
                          width: 22,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: CustomText.CustomSemiBoldText(
                                    widget.model.workStatusName.toString(),
                                    myColors.grey_33,
                                    FontWeight.w600,
                                    12,
                                    1,
                                    TextAlign.center),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                child: CustomText.CustomRegularText(
                                    DateFormat('hh:mm a')
                                        .format(DateTime.parse(widget.model.reportedDate.toString())),
                                    myColors.grey_two,
                                    FontWeight.w400,
                                    10,
                                    1,
                                    TextAlign.center),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: CustomText.CustomLightText(
                        widget.model.problem.toString(),
                        myColors.grey_one,
                        FontWeight.w300,
                        12,
                        2,
                        TextAlign.left),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

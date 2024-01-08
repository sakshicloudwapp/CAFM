import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:get/get.dart';
import '../../global/sizedbox.dart';
import '../../model/NotificationItemModel.dart';
import '../../widgets/customNavigator.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool is_allnotification = false;
   List<NotificationItemModel> notificationitemlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    additem();
  }

  additem() {
    notificationitemlist = [
      NotificationItemModel(MyString.Cases_notifications, false),
      NotificationItemModel(MyString.Payments_notifications, false),
      NotificationItemModel(MyString.Booking_notifications, false),
      NotificationItemModel(MyString.Offers_notifications, false),
      NotificationItemModel(MyString.Classifieds_notifications, false),
      NotificationItemModel(MyString.Direct_messages, false),
      NotificationItemModel(MyString.Likes_comments_shares, false),
      NotificationItemModel(MyString.Status_updates, false),
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
        data: data.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: myColors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: myColors.white,
                  //ios
                  statusBarBrightness: Brightness.light,
                  // android
                  statusBarIconBrightness: Brightness.dark),
              leading: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconButton(
                  onPressed: () {
                    CustomNavigator.popNavigate(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: myColors.arrow_Color,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Notifications.........................................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "Notifications".tr,
                      style: TextStyle(
                          color: myColors.black,
                          fontSize: 24,
                          fontFamily: MyString.PlusJakartaSansSemibold),
                    ),
                  ),

                  /// This is your Notification centre.........................................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 25, top: 15),
                    child: Text(
                      "This is your Notification centre. You can choose which Noknok notifications you wish to receive as push notifications.",
                      style: TextStyle(
                          color: myColors.black,
                          fontSize: 12,
                          height: 1.5,
                          fontFamily: MyString.PlusJakartaSansregular),
                    ),
                  ),

                  /// Divider..........................
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 0.9,
                    color: myColors.grey_38,
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 20, right: 25, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                          MyString.All_notifications,
                            style: TextStyle(
                                color: myColors.black,
                                fontSize: 12,
                                height: 1.5,
                                fontFamily: MyString.PlusJakartaSansSemibold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            is_allnotification = !is_allnotification;
                            setState(() {});
                          },
                          child: Container(
                            child: SvgPicture.asset(is_allnotification
                                ? "assets/images/fill_switch.svg"
                                : "assets/images/switch.svg"),
                          ),
                        )
                      ],
                    ),
                  ),

                  /// Divider..........................
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    height: 0.9,
                    color: myColors.grey_38,
                  ),

                  /// Or select one type of notifications you wish to manage..............................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 25, top: 15),
                    child: Text(
                      "Or select one type of notifications \n you wish to manage.",
                      style: TextStyle(
                          color: myColors.black,
                          fontSize: 12,
                          height: 1.5,
                          fontFamily: MyString.PlusJakartaSansregular),
                    ),
                  ),

                  /// Divider..........................
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    height: 0.9,
                    color: myColors.grey_38,
                  ),

                  Container(
                    child: ListView.builder(
                        itemCount: notificationitemlist.length,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 25, top: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        notificationitemlist[index].title,
                                        style: TextStyle(
                                            color: myColors.black,
                                            fontSize: 12,
                                            height: 1.5,
                                            fontFamily:
                                            MyString.PlusJakartaSansSemibold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        notificationitemlist[index]
                                                .is_notification =
                                            !notificationitemlist[index]
                                                .is_notification;
                                        setState(() {});
                                      },
                                      child: Container(
                                        child: SvgPicture.asset(
                                            notificationitemlist[index]
                                                    .is_notification
                                                ? "assets/images/switch_on.svg"
                                                : "assets/images/switch_off.svg"),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              /// Divider..........................
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                height: 0.9,
                                color: myColors.grey_38,
                              ),
                            ],
                          );
                        }),
                  ),

                  hsized80
                ],
              ),
            ),
          ),
        ));
  }
}

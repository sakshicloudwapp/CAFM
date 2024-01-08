import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/views/profile_screens/AddEmailAdressScreen.dart';
import 'package:fm_pro/views/profile_screens/AddPhoneNumberScreen.dart';
import 'package:fm_pro/views/profile_screens/ChangePasswordScreen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:get/get.dart';

class LoginAccessibilityScreen extends StatefulWidget {
  const LoginAccessibilityScreen({super.key});

  @override
  State<LoginAccessibilityScreen> createState() =>
      _LoginAccessibilityScreenState();
}

class _LoginAccessibilityScreenState extends State<LoginAccessibilityScreen> {
  List<String> emaillist = ['@mailinator.com'];
  List<String> phonelist = ['3698521456'];


  updatelist(String status,String value){
    print("value>>${value}");
    print("status>>${status}");
    if(status == "email"){
      emaillist.add(value);
      setState(() {});
    }else if(status == "phone"){
      phonelist.add(value);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emaillist.clear();
    phonelist.clear();
    setState(() {});
    emaillist.add('@mailinator.com');
    phonelist.add('3698521456');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
        data: data,
        child: Scaffold(
          backgroundColor: myColors.white,

          appBar: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: AppBar(
              backgroundColor: myColors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: myColors.white,
                  //ios
                  statusBarBrightness: Brightness.dark,
                  // android
                  statusBarIconBrightness: Brightness.light),
              leading: IconButton(
                onPressed: () {
                  CustomNavigator.popNavigate(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: myColors.arrow_Color,
                  size: 26,
                ),
              ),
            ),
          ),

          body: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Login Accessibility.........................................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      MyString.Login_Accessibility,
                      style: TextStyle(
                          color: myColors.black,
                          fontSize: 24,
                          fontFamily: MyString.PlusJakartaSansSemibold),
                    ),
                  ),

                  /// Divider..........................
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 0.9,
                    color: myColors.grey_38,
                  ),

                  /// Email Address.........................................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            MyString.Email_Address,
                            style: TextStyle(
                                color: myColors.black,
                                fontSize: 12,
                                fontFamily: MyString.PlusJakartaSansSemibold),
                          ),
                        ),

                        /// Add ..................
                        GestureDetector(
                          onTap: (){
                            CustomNavigator.pushNavigate(context, AddEmailAddressScreen(oncallback: updatelist,));
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              // color: MyColor.grey2,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Add".tr,
                              style: TextStyle(
                                  color: myColors.app_theme,
                                  fontSize: 12,
                                  fontFamily: MyString.PlusJakartaSansSemibold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Primary email will be used for login and all important emails will be sent to that address.................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 9),
                    child: Text(
                      MyString.Primary_email_can_not_be_changed,
                      style: TextStyle(
                          color: myColors.grey_two,
                          fontSize: 12,
                          fontFamily: MyString.PlusJakartaSansregular),
                    ),
                  ),

                  ListView.builder(
                      itemCount: emaillist.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context,int index){
                    return  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 23),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: SvgPicture.asset("assets/icons/ic_email.svg"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: Text(
                                  emaillist[index],
                                  style: TextStyle(
                                      color: myColors.black,
                                      fontSize: 12,
                                      fontFamily: MyString.PlusJakartaSansregular),
                                ),
                              ),
                            ],
                          ),

                          index == 0 ?
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: myColors.light_blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                             MyString.Primary,
                              style: TextStyle(
                                  color: myColors.app_theme,
                                  fontSize: 10,
                                  fontFamily: MyString.PlusJakartaSansregular),
                            ),
                          )
                          :   SvgPicture.asset("assets/icons/ic_more.svg"),
                        ],
                      ),
                    );
                  }),


                  Container(
                    margin: EdgeInsets.only(top: 23),
                    height: 0.6,
                    color: myColors.grey_38,
                  ),

                  /// Change Password..........................
                  GestureDetector(
                    onTap: (){
                      CustomNavigator.pushNavigate(context, ChangePasswordScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                      child: Text(MyString.change_password,style: TextStyle(color:  myColors.black,fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold),),
                    ),
                  ),



                  Container(
                    margin: EdgeInsets.only(top: 23),
                    height: 0.6,
                    color:myColors.grey_38,
                  ),

                  /// Accessibility Method..................................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          child: Text(MyString.Accepted,style: TextStyle(color:  myColors.black,fontSize: 12,fontFamily: MyString.PlusJakartaSansSemibold),),
                        ),


                        /// Accessibility method is used to easily access your Noknok account......................
                        Container(
                          padding: EdgeInsets.only(top: 9),
                          child: Text(
                            MyString.Accessibility_method_is_used_to_easily_access,
                            style: TextStyle(
                                color:myColors.grey_one,
                                fontSize: 12,
                                fontFamily: MyString.PlusJakartaSansmedium),
                          ),
                        ),

                        /// Face Recognition.............................
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                   MyString.Face_Recognition,
                                    style: TextStyle(
                                        color:  myColors.black,
                                        fontSize: 12,
                                        fontFamily: MyString.PlusJakartaSansregular),
                                  ),
                                ),
                              ),

                             Container(
                               padding: EdgeInsets.only(top: 10),
                                 alignment: Alignment.centerRight,
                                 child: SvgPicture.asset("assets/icons/ic_more.svg",height: 16,width: 16,))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 23),
                    height: 0.6,
                    color:myColors.grey_38,
                  ),



                  /// Phone Number.........................................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            MyString.Phone_Number,
                            style: TextStyle(
                                color:  myColors.black,
                                fontSize: 12,
                                fontFamily: MyString.PlusJakartaSansSemibold),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            CustomNavigator.pushNavigate(context, AddPhoneNumberScreen(oncallback: updatelist));
                          },
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              // color: MyColor.grey2,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  color: myColors.app_theme,
                                  fontSize: 12,
                                  fontFamily: MyString.PlusJakartaSansSemibold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Primary number can not be changed. You can always add another one...............................
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 30, top: 9),
                    child: Text(
                     MyString.Primary_number_can_not_be_changed,
                      style: TextStyle(
                          color:myColors.grey_two,
                          fontSize: 12,
                          fontFamily: MyString.PlusJakartaSansmedium),
                    ),
                  ),

                  ListView.builder(
                      itemCount: phonelist.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context,int index){
                        return  Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 23),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: SvgPicture.asset("assets/icons/ic_phone.svg"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Container(
                                    child: Text(
                                      phonelist[index],
                                      style: TextStyle(
                                          color:  myColors.black,
                                          fontSize: 12,
                                          fontFamily: MyString.PlusJakartaSansregular),
                                    ),
                                  ),
                                ],
                              ),

                              index == 0 ?
                              Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color:myColors.light_blue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  MyString.Primary,
                                  style: TextStyle(
                                      color: myColors.app_theme,
                                      fontSize: 10,
                                      fontFamily: MyString.PlusJakartaSansregular),
                                ),
                              )
                                  :   SvgPicture.asset("assets/icons/ic_more.svg"),
                            ],
                          ),
                        );
                      }),


                  Container(
                    margin: EdgeInsets.only(top: 23),
                    height: 0.6,
                    color: myColors.grey_38,
                  ),



                ],
              ),
            ),
          ),
        ));
  }
}

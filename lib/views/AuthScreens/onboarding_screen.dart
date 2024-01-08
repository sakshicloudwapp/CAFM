

import 'package:flutter/material.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/onboarding_data.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/Signup_screen.dart';
import 'package:fm_pro/views/AuthScreens/signin_screen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:fm_pro/widgets/custom_texts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  /// SharedPrefences.............
  SharedPreferences? p;

  getPrefences() async {
    p = await SharedPreferences.getInstance();
  }

  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    getPrefences();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: Stack(
          children: [
            /// Page view.......
            PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Container(
                    child: Stack(
                      children: [
                        Container(
                          height: mediaQuerryData.size.height,
                          width: mediaQuerryData.size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(contents[i].image),
                                  fit: BoxFit.fitWidth)),
                        ),


                        Container(
                          margin: EdgeInsets.only(
                              top: mediaQuerryData.size.height / 1.8),
                          padding: EdgeInsets.only(top: 95),
                          height: mediaQuerryData.size.height,
                          width: mediaQuerryData.size.width,
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: AssetImage(context.isDarkMode
                            //         ? "assets/images/onboarding_bottom_bg_dark.png"
                            //         : "assets/images/onboarding_bottom_bg.png"),
                            //     fit: BoxFit.fill)
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: CustomText.CustomSemiBoldText(
                                        contents[i].title,
                                       myColors.white,
                                        FontWeight.w700,
                                        23,
                                        1,
                                        TextAlign.center)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 16, 0, 10),
                                    width: mediaQuerryData.size.width / 1.2,
                                    child: CustomText.CustomRegularText(
                                        contents[i].description,
                                        myColors.white,
                                        FontWeight.w500,
                                        12,
                                        3,
                                        TextAlign.center)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          // margin: EdgeInsets.only(
                          //     top: mediaQuerryData.size.height / 9),
                          height: mediaQuerryData.size.height,
                          alignment: Alignment.center,
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              height: MediaQuery.of(context).size.height,
                              // width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: context.isDarkMode
                                //     ? MyColor.white_color
                                //     : MyColor.black_color,
                              ),
                              child: Image.asset("assets/icons/processed-0a8559a5-4a39-4246-a3b8-2a28c361fd35_Lorj6OVX-removebg-preview.png",height: 100,width: 100,),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

            /// Bottom Ui.................................

            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 1.24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Previous Button.......................................
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: currentIndex == 0
                                  ? Container()
                                  : TextButton(
                                  onPressed: () {
                                    _controller.previousPage(
                                        duration:
                                        const Duration(seconds: 1),
                                        curve: Curves.ease);
                                  },
                                  child: Text(
                                    'Prev'.tr,
                                    style: TextStyle(
                                        color: myColors.white,
                                        fontSize: 12,
                                        fontFamily: "PlusJakartaSansmedium",
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                          ),

                          /// Dot Row............................
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                contents.length,
                                    (index) => buildDot(index, context),
                              ),
                            ),
                          ),

                          /// Next Button.....................................
                          Expanded(
                            flex: 1,
                            child: currentIndex == 2
                                ? Container()
                                : TextButton(
                                onPressed: () {
                                  _controller.nextPage(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.ease);
                                },
                                child: Text(
                                  'Next'.tr,
                                  style: TextStyle(
                                      color: myColors.white,
                                      fontSize: 12,
                                      fontFamily: "PlusJakartaSansmedium",
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ],
                      ),
                    ),

                    /// Skip Button.....................................

                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () async{
                            SharedPreferences p =     await SharedPreferences.getInstance();
                            p.setString("init_screen", "1");
                            setState(() {});
                            CustomNavigator.custompushAndRemoveUntil(context, SigninScreen());
                          },
                          child: Text(
                            'SKIP'.tr,
                            style: TextStyle(
                                color: myColors.white,
                                fontSize: 12,
                                fontFamily: "PlusJakartaSansmedium",
                                fontWeight: FontWeight.w600),
                          )),
                    ),

                    /// Image.....................................

                    Container(
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/onboard_share.png",height: 30,width: 30,)
                    ),

                    /// Copy right.......................................
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Text(
                        "All rights reserved@ryna 2023".tr,
                        style: TextStyle(
                            color: myColors.white,
                            fontSize: 12,
                            fontFamily: "PlusJakartaSansmedium",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container(
            //   decoration: BoxDecoration(
            //     /*  color: Color(int.parse(contents[currentIndex].color_bottom))
            //         .withOpacity(1),*/
            //   ),
            //   child: Column(
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           p!.setString("init_screen", '1');
            //           setState((){});
            //           // Navigator.of(context).pushReplacement(PageRouteBuilder(
            //           //     pageBuilder:
            //           //         (context, animation, anotherAnimation) {
            //           //       return SigninScreen();
            //           //     },
            //           //     transitionDuration: Duration(milliseconds: 1000),
            //           //     transitionsBuilder:
            //           //         (context, animation, anotherAnimation, child) {
            //           //       animation = CurvedAnimation(
            //           //           curve: curveList[4], parent: animation);
            //           //       return SlideTransition(
            //           //         position: Tween(
            //           //             begin: Offset(1.0, 0.0),
            //           //             end: Offset(0.0, 0.0))
            //           //             .animate(animation),
            //           //         child: child,
            //           //       );
            //           //     }));
            //         },
            //         child: Container(
            //           margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            //           child: GlobalThemeButton(
            //             buttonName: "MyString.SIGN_IN",
            //             buttonColor:context.isDarkMode ?  MyColor.yellow :  MyColor.white_color,
            //           ),
            //         ),
            //       ),
            //      /* InkWell(
            //         onTap: () {
            //           Navigator.of(context).push(PageRouteBuilder(
            //               pageBuilder:
            //                   (context, animation, anotherAnimation) {
            //                 return ForgotPasswordScreen();
            //               },
            //               transitionDuration: Duration(milliseconds: 1000),
            //               transitionsBuilder:
            //                   (context, animation, anotherAnimation, child) {
            //                 animation = CurvedAnimation(
            //                     curve: curveList[4], parent: animation);
            //                 return SlideTransition(
            //                   position: Tween(
            //                       begin: Offset(1.0, 0.0),
            //                       end: Offset(0.0, 0.0))
            //                       .animate(animation),
            //                   child: child,
            //                 );
            //               }));
            //         },
            //         child: Container(
            //           padding: EdgeInsets.fromLTRB(0, 12, 0, 16),
            //           child: Text(
            //             MyString.Forgot_Your_Account,
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               color: context.isDarkMode
            //                   ? myColors.white
            //                   : myColors.black,
            //               fontSize: 12,
            //               fontFamily: "assets/fonts/KoHo-Light.ttf",
            //               fontWeight: FontWeight.w400,
            //             ),
            //           ),
            //         ),
            //       ),*/
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 15,
      margin: EdgeInsets.only(right: 4,left: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? myColors.yellow : myColors.grey_bar1,
      ),
    );
  }
}

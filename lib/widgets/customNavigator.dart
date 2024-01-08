import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../utils/list.dart';


class CustomNavigator{

  /// pushAndRemoveUntil.............
  static  custompushAndRemoveUntil(BuildContext context, var pagename) async{
    /// Similar to **Navigation.push()**
    return  Navigator.of(context).pushAndRemoveUntil(

        PageRouteBuilder(

        pageBuilder:
            (context, animation, anotherAnimation) {
          return pagename;
        },


        transitionDuration:
        Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation,
            anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: curveList[4], parent: animation);
          return SlideTransition(
            position: Tween(
                begin: Offset(1.0, 0.0),
                end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,

          );
        }),  ModalRoute.withName('/'));

  }


  /// push.............
  static  custompush(BuildContext context, var pagename,bool bottom_ishide) async{
    return  PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: pagename,
      withNavBar: bottom_ishide, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.fade,
    );
  }



  /// pushReplacement.............
  static  custompushReplacement(BuildContext context, var pagename) async{
    return   Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder:
            (context, animation, anotherAnimation) {
          return pagename;
        },
        transitionDuration:
        Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation,
            anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: curveList[4], parent: animation);
          return SlideTransition(
            position: Tween(
                begin: Offset(1.0, 0.0),
                end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }));

  }


  /// finish all page.........
static  customfinishpage(BuildContext context, var pagename){
  return PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
    context,
    settings: RouteSettings(),
    screen: pagename,
    withNavBar: false,
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
  );

}

  static popNavigate(BuildContext context){
    return Navigator.pop(context);
  }

  static pushreplacementNavigate(BuildContext context,var page){
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder:
            (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder:
            (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: curveList[4], parent: animation);
          return SlideTransition(
            position: Tween(
                begin: Offset(1.0, 0.0),
                end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }));
  }

  static pushNavigate(BuildContext context,var page){
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder:
            (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder:
            (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: curveList[4], parent: animation);
          return SlideTransition(
            position: Tween(
                begin: Offset(1.0, 0.0),
                end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }));
  }

  static PushRemoveuntil(BuildContext context, var page){
    Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
        pageBuilder:
            (context, animation, anotherAnimation) {
          return page;
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder:
            (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: curveList[4], parent: animation);
          return SlideTransition(
            position: Tween(
                begin: Offset(1.0, 0.0),
                end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        }), (route) => false);
  }


}
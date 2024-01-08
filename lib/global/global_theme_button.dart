import 'package:flutter/material.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';


class GlobalThemeButton extends StatelessWidget {
  String buttonName ;
  Color buttonColor ;
    GlobalThemeButton({Key? key, required this.buttonName, required this.buttonColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(12, 15, 12, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10)),
        color: buttonColor,
      ),
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: MyString.PlusJakartaSansBold,
          color: myColors.white,
        ),
      ),
    );
  }
}


class GlobalThemeButton2 extends StatelessWidget {
  String buttonName ;
  Color buttonColor ;
  GlobalThemeButton2({Key? key, required this.buttonName, required this.buttonColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50)),
        color: buttonColor,
      ),
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: MyString.PlusJakartaSansBold,
          color: myColors.white,
        ),
      ),
    );
  }
}

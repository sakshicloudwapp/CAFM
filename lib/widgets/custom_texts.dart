import 'package:flutter/cupertino.dart';
import 'package:fm_pro/global/my_string.dart';

class CustomText {

  ///Popins.................................................................................................................
  static CustomBoldText(String title, Color txt_color, FontWeight fontweight,
      double fontsize, int maxlines,TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.1,
            fontFamily: MyString.PlusJakartaSansBold,
            overflow: TextOverflow.ellipsis),
        maxLines: maxlines,
      ),
    );
  }

  static CustomSemiBoldText(String title, Color txt_color,
      FontWeight fontweight, double fontsize, int maxlines,
      TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.1,
            fontFamily: MyString.PlusJakartaSansSemibold,
            overflow: TextOverflow.ellipsis),
        maxLines: null,
      ),
    );
  }

  static CustomMediumText(String title, Color txt_color, FontWeight fontweight,
      double fontsize, int maxlines,
      TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.1,
            fontFamily: MyString.PlusJakartaSansmedium,
            overflow: TextOverflow.ellipsis),
        maxLines: maxlines,
      ),
    );
  }

  static CustomRegularText(String title, Color txt_color, FontWeight fontweight,
      double fontsize, int maxlines,TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.1,
            fontFamily: MyString.PlusJakartaSansregular,
            overflow: TextOverflow.ellipsis),
        maxLines: null,
      ),
    );
  }

  static CustomLightText(String title, Color txt_color, FontWeight fontweight,
      double fontsize, int maxlines,TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.3,
            height: 1.3,
            fontFamily: MyString.PlusJakartaSanslight,
            overflow: TextOverflow.ellipsis),
        maxLines: maxlines,
      ),
    );
  }

  ///DM Sans................................................................................................................
  static CustomBoldTextDM(String title, Color txt_color, FontWeight fontweight,
      double fontsize, int maxlines,TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.1,
            fontFamily: MyString.PlusJakartaSansBold,
            overflow: TextOverflow.ellipsis),
        maxLines: maxlines,
      ),
    );
  }

  static CustomMediumTextDM(String title, Color txt_color, FontWeight fontweight,
      double fontsize, int maxlines,TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.1,
            fontFamily: MyString.PlusJakartaSansmedium,
            overflow: TextOverflow.ellipsis),
        maxLines: maxlines,
      ),
    );
  }

  static CustomRegularTextDM(String title, Color txt_color, FontWeight fontweight,
      double fontsize, int maxlines,TextAlign textAlign) {
    return Container(
      child: Text(
        title,
        textAlign: textAlign,
        style: TextStyle(
            color: txt_color,
            fontWeight: fontweight,
            fontSize: fontsize,
            wordSpacing: 0.1,
            fontFamily: MyString.PlusJakartaSansregular,
            overflow: TextOverflow.ellipsis),
        maxLines: maxlines,
      ),
    );
  }


  /// QuickSand ..............
static CustomQuickBoldText(String title, Color txt_color, FontWeight fontweight,
    double fontsize, int maxlines,TextAlign textAlign){
  return Container(
    child: Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
          color: txt_color,
          fontWeight: fontweight,
          fontSize: fontsize,
          wordSpacing: 0.1,
          fontFamily: MyString.PlusJakartaSansBold,
          overflow: TextOverflow.ellipsis),
      maxLines: maxlines,
    ),
  );
}

}

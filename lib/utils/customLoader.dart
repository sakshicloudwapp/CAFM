import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/models/GetMenuModel.dart';
import 'package:fm_pro/model/models/SuperViserdResourcesModel.dart';
import 'package:fm_pro/model/models/getLocationResourceMasterModel.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../views/PPM/wo_detail_screen.dart';
import '../widgets/custom_texts.dart';
import 'package:fm_pro/model/UserModel.dart';

class CustomLoader {

  static nodata() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child: Image.asset("assets/new_images/no_data.gif")),
          //  hsized10,
          Text(
            "NO WORK ORDERS",
            style: TextStyle(
                color: myColors.app_theme,
                fontSize: 16,
                fontFamily: MyString.PlusJakartaSansBold),
          ),
          hsized10,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Currently you dont have any workorders",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: myColors.grey_27,
                  fontSize: 16,
                  fontFamily: MyString.PlusJakartaSansregular),
            ),
          ),
        ],
      ),
    );
  }

  static SearchNotfound(){
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          hsized40,
          Image.asset("assets/images/search_not_found.gif"),

          Text("NO RESULTS",style: TextStyle(color: myColors.app_theme,fontFamily: "PlusJakartaSansBold",fontSize: 16),),
          hsized5,
          Text("We din’t find any search results",style: TextStyle(color: myColors.grey_27,fontFamily: "PlusJakartaSansBold",fontSize: 16),),
        ],
      ),
    );
  }

  static void Checkuserpopup(BuildContext context,
      List<AccountsModel> accountlist) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: accountlist.length > 3 ? 500 : 340,
            child: SizedBox.expand(
                child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 20),
                    child: UserCountPopup(
              accountlist: accountlist,
            ))),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static ProgressloadingDialog(BuildContext context, bool status) {
    if (status) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
                child: Container(
                    height: 55,
                    width: 55,
                    child:Image.asset("assets/new_images/loader.gif")));
          });
      // return pr.show();
    } else {
      Navigator.pop(context);
      // return pr.hide();
    }
  }

  static ProgressloadingDialog2(BuildContext context, bool status) {
    if (status) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Center(
                child: Container(
                    height: 35,
                    width: 35,
                    child: Image.asset("assets/new_images/loader.gif")));
          });
      // return pr.show();
    } else {
      Navigator.pop(context);
      // return pr.hide();
    }
  }

  static void displayPersistentBottomSheet(BuildContext context) {
    Scaffold.of(context).showBottomSheet<void>((BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: const Text(' My Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: const Text(' My Course '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.workspace_premium),
            title: const Text(' Go Premium '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.video_label),
            title: const Text(' Saved Videos '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: const Text(' Edit Profile '),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }

  final dialogContextCompleter = Completer<BuildContext>();

  static Future<void> showAlertDialog(BuildContext context, bool status) async {
    if (status) {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => Center(
          child:Image.asset("assets/new_images/loader.gif",height: 140,width: 140,)
        ),
      );
    } else {
      //  await Future<int>.delayed(Duration(seconds: 1));

      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  static void RejectDialog(
      {required BuildContext context,
      title,
      haeding,
       // required List<SuperVisedResourcesModel> superviserdresourceslist,
      required Function onCallback,
      required Function onTapofYes,
      required TextEditingController controller}) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.20),
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (dialogContext, anim1, anim2) {
        return Container();
      },
      transitionBuilder: (dialogContext, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: RejectAcceptDialog(
              title: title,
              onCallback: onCallback,
              onTapofYes: onTapofYes,
              controller: controller,
              heading: haeding,
            ),
          ),
        );
      },
    );
  }

  static void RemoveOnHoldDialog(
      {required BuildContext context,
      title,
      haeding,
      val,
      required Function onCallback,
      required Function onTapofYes}) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.20),
      transitionDuration: Duration(milliseconds: 200),
      context: context,
      pageBuilder: (dialogContext, anim1, anim2) {
        return Container();
      },
      transitionBuilder: (dialogContext, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: RemoveOnHoldDialogg(
              title: title,
              onCallback: onCallback,
              onTapofYes: onTapofYes,
              heading: haeding,
              val: val,
            ),
          ),
        );
      },
    );
  }
}

class RemoveOnHoldDialogg extends StatefulWidget {
  String title;
  String heading;
  Function onCallback;
  Function onTapofYes;
  bool val;

  RemoveOnHoldDialogg(
      {Key? key,
      required this.title,
      required this.heading,
      required this.val,
      required this.onCallback,
      required this.onTapofYes})
      : super(key: key);

  @override
  State<RemoveOnHoldDialogg> createState() => _RemoveOnHoldDialogState();
}

class _RemoveOnHoldDialogState extends State<RemoveOnHoldDialogg> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Material(
            elevation: 5.0,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText.CustomSemiBoldText(
                        widget.heading,
                        myColors.color2,
                        FontWeight.w600,
                        14,
                        1,
                        TextAlign.start),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1.7,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText.CustomSemiBoldText(
                        widget.title,
                        myColors.app_theme,
                        FontWeight.w600,
                        14,
                        1,
                        TextAlign.start),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  /// Button......
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      widget.onCallback();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: myColors.app_theme,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Remove On-Hold",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class RejectAcceptDialog extends StatefulWidget {
  String title;
  String heading;
  Function onCallback;
  Function onTapofYes;
  TextEditingController controller;
  //List<SuperVisedResourcesModel> superviserdresourceslist;

  RejectAcceptDialog(
      {Key? key,
      required this.title,
      required this.heading,
      required this.onCallback,
      required this.onTapofYes,
      required this.controller,
    //  required this.superviserdresourceslist
      })
      : super(key: key);

  @override
  State<RejectAcceptDialog> createState() => _RejectAcceptDialogState();
}

class _RejectAcceptDialogState extends State<RejectAcceptDialog> {

  List<SuperVisedResourcesModel> superviserdresourceslist = [];
  SuperVisedResourcesModel? superVisedResourcesModel;
  String resourceId = "";
  String resourcename = "Select Resources";
  TextEditingController searchController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      getsupervisedResourcesApi();
    });
  }

  getsupervisedResourcesApi() async{
    superviserdresourceslist.clear();
    await Webservices.RequestSuperVisedResources(context, superviserdresourceslist);
    setState(() {});
    print("superviserdresourceslist2222>>${superviserdresourceslist.length}");
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Material(
            elevation: 5.0,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                     // widget.onTapofYes();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 5,top: 5),
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.clear),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText.CustomSemiBoldText(
                        widget.heading,
                        myColors.color2,
                        FontWeight.w600,
                        14,
                        1,
                        TextAlign.start),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Divider(
                    thickness: 1.7,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText.CustomSemiBoldText(
                        widget.title,
                        myColors.black,
                        FontWeight.w600,
                        14,
                        1,
                        TextAlign.start),
                  ),

            SizedBox(
              height: 20,
            ),

                  widget.heading == "Transfer" ?
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        child:buildingdropdown(),
                      ),

                      Container(
                        height: 0.5,width: double.infinity,color: Colors.grey,
                      )
                    ],
                  ) : Container(),

                  SizedBox(
                    height: 30,
                  ),

                  /// Textfield/..........
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: DottedBorder(
                        color: myColors.grey_two,
                        borderType: BorderType.Rect,
                        dashPattern: [5, 2],
                        strokeWidth: 1.5,
                        child: Container(
                          color: myColors.bg_grey.withOpacity(0.30),
                          child: TextField(
                            maxLines: 4,
                            cursorColor: myColors.app_theme,
                            controller: widget.controller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                hintText: 'Reason Of ${widget.heading}',
                                hintStyle: TextStyle(
                                    fontFamily:
                                        "assets/fonts/Poppins/Poppins-Medium.ttf",
                                    fontSize: 12,
                                    color: myColors.grey_two)),
                          ),
                        ),
                      )),

                  SizedBox(
                    height: 30,
                  ),

                  /// Button......
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      if(widget.heading == "Transfer" ){
                        widget.onCallback(widget.controller.text,resourceId);
                      }else{
                        widget.onCallback(widget.controller.text);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: myColors.app_theme,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  buildingdropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<SuperVisedResourcesModel>(
        isExpanded: true,
        hint: Text(
          'Select Resources',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none,
            fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
            color:resourcename == "Select Resources" ? myColors.grey_27 : Colors.black,
          ),
        ),
        onChanged: (value) {
          // This is called when the user selects an item.
          if (value!.name.toString() != "Select Resources"){
            setState(() {
              resourceId = value.id.toString();
              resourcename = value.name.toString();
              superVisedResourcesModel = value;
              });

          }
          else{
            resourceId = "";
            resourcename = "Select Resources";
            superVisedResourcesModel = value;
            setState(() {});
          }

          print("fdjhgjkgjk>>${resourcename}");

        },
        selectedItemBuilder: (BuildContext context) {
          return superviserdresourceslist.map((e) {
            return Container(
              //    padding: EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text(
                e.code.toString() == "null" || e.code.toString() == ""?
                e.name.toString():
                e.code.toString() +" - "+ e.name.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                  color:resourcename == "Select Resources" ? myColors.grey_27 : Colors.black,
                ),
              ),
            );
          }).toList();
        },
        items: superviserdresourceslist
            .map((value) => DropdownMenuItem(
          value: value,
          child:Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                resourceId == value.id.toString() ?
                Padding(
                  padding:  EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.check,size: 15,),
                ):
                Container(),

                Expanded(
                  child: Text(
                    value.code.toString() + " - " + value.name.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                      fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                      color:value.name.toString() == "Select Resources" ? myColors.grey_27 : myColors.grey_one.withOpacity(0.90),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
            .toList(),
        value: superVisedResourcesModel,

        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 1),
          height: 40,
          width: 400,
        ),
        dropdownStyleData:  DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          maxHeight: 400,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: searchController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: searchController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle:  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontFamily: 'assets/fonts/Poppins/Poppins-Regular.ttf',
                  color: myColors.grey_27,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value!.name.toString().toLowerCase().contains(searchValue) ||  item.value!.name.toString().toUpperCase().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            searchController.clear();
          }
        },
      ),
    );
  }
}

class UserCountPopup extends StatefulWidget {
  List<AccountsModel> accountlist;

  UserCountPopup({super.key, required this.accountlist});

  @override
  State<UserCountPopup> createState() => _UserCountPopupState();
}

class _UserCountPopupState extends State<UserCountPopup> {
  List<UserModel> userlist = [];
  String accountId = "";

  regenratetokenApi(String accountId) async{
    await Webservices.RequestReGenerateToken(context, accountId, userlist);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();
  }
  setdata(){
    if(widget.accountlist.isNotEmpty){
      accountId = widget.accountlist.first.id.toString();
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Text(
                "Users",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 0.3,
              color: myColors.app_theme.withOpacity(0.50),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: accountlist.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: (){
                        accountId = accountlist[index].id.toString();
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:accountId == accountlist[index].id.toString() ? myColors.light: myColors.app_theme.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.only(top: 5, bottom: 8),
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 13, bottom: 13),
                        child: Text(
                          "${accountlist[index].shortName}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: "assets/fonts/KoHo-Medium.ttf",
                              fontSize: 15),
                        ),
                      ),
                    );
                  }),
            ),

            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        regenratetokenApi(accountId);
                      },
                      child: Container(
                        height: 40,
                       // padding: EdgeInsets.only(top: 10,bottom: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: myColors.app_theme,
                        borderRadius: BorderRadius.circular(8)),
                          child: Text(
                        "OK",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      )),
                    ),
                  ),

                  SizedBox(width: 25,),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: myColors.app_theme,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "CANCEL",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

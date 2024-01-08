import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:get/get.dart';

import '../../global/global_theme_button.dart';
import '../../global/sizedbox.dart';
import '../../widgets/customNavigator.dart';

class AddEmailAddressScreen extends StatefulWidget {
  Function oncallback;
   AddEmailAddressScreen({super.key,required this.oncallback});

  @override
  State<AddEmailAddressScreen> createState() => _AddEmailAddressScreenState();
}

class _AddEmailAddressScreenState extends State<AddEmailAddressScreen> {
  /// Controllers
  TextEditingController emailController = TextEditingController();

  /// FocusNode...
  final emailFocus = FocusNode();

  bool is_btn = false;
  bool is_email = false;
  String email_error_str = "";

  unfocusTextfield() {
    emailFocus.unfocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    unfocusTextfield();
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
              actions: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.clear,
                        color: myColors.arrow_Color,
                        size: 30,
                      )),
                )
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              unfocusTextfield();
              setState(() {});
            },
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Add Email.........................
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Text(
                        MyString.Add_Email_Address,
                        style: TextStyle(
                            color: myColors.black,
                            fontSize: 24,
                            fontFamily:  MyString.PlusJakartaSansBold),
                      ),
                    ),

                    /// Email textfield..............................
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                      height: 53,
                      decoration: BoxDecoration(),
                      alignment: Alignment.topCenter,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.top,
                        controller: emailController,
                        focusNode: emailFocus,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            is_btn = true;
                            setState(() {});
                          } else {
                            is_btn = false;
                            setState(() {});
                          }
                        },
                        style: TextStyle(
                            color:myColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            fontFamily:  MyString.PlusJakartaSansmedium),
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: myColors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: myColors.grey_39)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color:myColors.grey_39, width: 0.4)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: myColors.grey_39, width: 0.4)),
                            hintText: "Type here",
                            hintStyle: TextStyle(
                                color: myColors.grey_one,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily:  MyString.PlusJakartaSansregular,),
                            contentPadding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 10)),
                      ),
                    ),

                    /// Email error message....................................
                    is_email == true
                        ? Container(
                            padding:
                                EdgeInsets.only(left: 25, right: 2, top: 8),
                            child: Text(
                              email_error_str,
                              style: TextStyle(
                                  color: myColors.medium_red,
                                  fontSize: 12,
                                  fontFamily:  MyString.PlusJakartaSansmedium),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              checkvalidation();
            },
            child: Container(
                height: 80,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 60),
                child: GlobalThemeButton2(
                    buttonName: "Save".tr,
                    buttonColor: is_btn == false
                        ? myColors.medium_blue
                        : myColors.app_theme)),
          ),
        ));
  }

  checkvalidation() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    print("emailValid${emailValid}");
    if (emailController.text.trim().isEmpty) {
      is_email = true;
      email_error_str = "Please enter email";
      setState(() {});
      // Utility.CustomToast("Please enter email");
    } else if (!emailValid) {
      is_email = true;
      email_error_str = "Somethings_not_right".tr;
      setState(() {});
      // Utility.CustomToast("Please valid email");
    } else {
      is_email = false;
      setState(() {});
      _handleprimaryemail();
    }
  }

  void _handleprimaryemail() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            height: 280,
            color: myColors.white,
            child: SetPrimaryEmailPopup(status: 'setprimary', oncallback: widget.oncallback, value: emailController.text,));
      },
    );
  }
}

class SetPrimaryEmailPopup extends StatefulWidget {
  String status,value;
  Function oncallback;
   SetPrimaryEmailPopup({super.key,required this.status,required this.oncallback,required this.value});

  @override
  State<SetPrimaryEmailPopup> createState() => _SetPrimaryEmailPopupState();
}

class _SetPrimaryEmailPopupState extends State<SetPrimaryEmailPopup> {
  List<String> list = [MyString.Set_as_primary_address, MyString.Remove];
  List<String> locklist = [MyString.Passcode, MyString.Face_Recognition,MyString.Fingerprint];

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //     hsized20,
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      CustomNavigator.popNavigate(context);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                      size: 20,
                    )),
              ),

              hsized15,

              Container(
                height: 1,
                color: myColors.grey_38,
              ),

              hsized15,
              widget.status == "setprimary"?
              setprimarywidget()
              : lockwidget(),
              hsized20,
            ],
          ),
        ),
      ),
    );
  }

  setprimarywidget(){
    return  Container(
      child: ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                if (list[index] == MyString.Set_as_primary_address) {
                  CustomNavigator.popNavigate(context);
                  setprimarypopup();
                }else  if (list[index] == MyString.Remove) {
                  CustomNavigator.popNavigate(context);
                  removepopup();
                }
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        list[index],
                        style: TextStyle(
                            color:myColors.black,
                            fontFamily:  MyString.PlusJakartaSansSemibold,
                            fontSize: 15),
                      ),
                    ),
                    hsized15,
                    Container(
                      height: 1,
                      color: myColors.grey_38,
                    ),
                    hsized15,
                  ],
                ),
              ),
            );
          }),
    );
  }

  lockwidget(){
    return  Container(
      child: ListView.builder(
          itemCount: locklist.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, int index) {
            return GestureDetector(
              onTap: () {
                CustomNavigator.popNavigate(context);
                if(widget.value != ""){
                  widget.oncallback('email',widget.value);
                  setState(() {});
                }
                CustomNavigator.popNavigate(context);
              },
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        locklist[index],
                        style: TextStyle(
                            color:myColors.black,
                            fontFamily:  MyString.PlusJakartaSansSemibold,
                            fontSize: 15),
                      ),
                    ),
                    hsized15,
                    Container(
                      height: 1,
                      color:myColors.grey_38,
                    ),
                    hsized15,
                  ],
                ),
              ),
            );
          }),
    );
  }

  void setprimarypopup() {
    showModalBottomSheet<int>(
      barrierColor: Colors.black.withOpacity(0.80),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
             child: SetPrimaryAndRemovePopup(title: MyString.Set_the_following_address_as_a_primaryone, status: 'set', email: widget.value, oncallback: widget.oncallback,));
      },
    );
  }

  void removepopup() {
    showModalBottomSheet<int>(
      barrierColor: Colors.black.withOpacity(0.80),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            child:  SetPrimaryAndRemovePopup(title: MyString.Are_you_sure_you_wish_to_remove_the_following_address, status: 'remove', email: widget.value, oncallback: widget.oncallback,));

      },
    );
  }
}






class SetPrimaryAndRemovePopup extends StatefulWidget {
  String title,status,email;
  Function oncallback;
  SetPrimaryAndRemovePopup({super.key,required this.title,required this.status,required this.email,required this.oncallback});

  @override
  State<SetPrimaryAndRemovePopup> createState() => _SetPrimaryAndRemovePopupState();
}

class _SetPrimaryAndRemovePopupState extends State<SetPrimaryAndRemovePopup> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor:Colors.transparent,

        bottomNavigationBar: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: myColors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              margin: EdgeInsets.only(bottom: 0,left: 20,right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //     hsized20,
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            CustomNavigator.popNavigate(context);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.grey,
                            size: 20,
                          )),
                    ),

                    hsized15,

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: myColors.black,
                            fontFamily:  MyString.PlusJakartaSansBold,
                            fontSize: 15),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: SvgPicture.asset("assets/icons/email.svg"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              widget.email,
                              style: TextStyle(
                                  color: myColors.black,
                                  fontSize: 13,
                                  fontFamily:  MyString.PlusJakartaSansregular,),
                            ),
                          ),
                        ],
                      ),
                    ),

                    hsized40,
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                CustomNavigator.popNavigate(context);
              if(widget.status == 'set'){
                _handleprimaryemail();
              }else if(widget.status == 'remove'){
                _handleprimaryemail();
              }
              },
              child: Container(
                  height: 80,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 60),
                  child: GlobalThemeButton2(
                      buttonName: "Save".tr,
                      buttonColor:  myColors.app_theme)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleprimaryemail() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            height: 330,
            color: myColors.white,
            child: SetPrimaryEmailPopup(status: 'remove', oncallback: widget.oncallback, value:widget.status == 'remove' ?'' : widget.email ,));
      },
    );
  }
}

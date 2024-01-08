import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../global/global_theme_button.dart';


class AddPhoneNumberScreen extends StatefulWidget {
  Function oncallback;
  AddPhoneNumberScreen({super.key,required this.oncallback});

  @override
  State<AddPhoneNumberScreen> createState() => _AddPhoneNumberScreenState();
}

class _AddPhoneNumberScreenState extends State<AddPhoneNumberScreen> {
  /// Controllers
  TextEditingController phoneController = TextEditingController();

  /// FocusNode...
  final phoneFocus = FocusNode();

  bool is_btn = false;
  bool is_phone = false;
  String phone_error_str = "";
  String countrucode = "";

  unfocusTextfield() {
    phoneFocus.unfocus();
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
              backgroundColor:  myColors.white,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor:  myColors.white,
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
                        MyString.Add_Phone_Number,
                        style: TextStyle(
                            color: myColors.black,
                            fontSize: 24,
                            fontFamily:  MyString.PlusJakartaSansBold),
                      ),
                    ),

                    /// Phone textfield..............................
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                    height: 56,
                    decoration: BoxDecoration(),
                    alignment: Alignment.topCenter,
                    child: Material(
                      elevation: 1,
                      color: myColors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: IntlPhoneField(
                        dropdownIcon: Icon(Icons.arrow_drop_down,color: myColors.arrow_Color,),
                        textInputAction: TextInputAction.done,
                        focusNode: phoneFocus,
                       // dropdownIconPosition: IconPosition.values.lastIndexOf(1,),

                        onTap: (){

                        },
                        pickerDialogStyle: PickerDialogStyle(
                          width: 330,
                          padding: EdgeInsets.only(top: 10,left: 5,right: 10),
                          listTilePadding: EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 0),
                          listTileDivider: Container(
                            height: 0,
                            color: Colors.grey.withOpacity(0.10),
                          ),

                          countryNameStyle: TextStyle(color: Colors.black,fontSize: 14),
                          countryCodeStyle: TextStyle(color: Colors.black,fontSize: 13),
                          searchFieldInputDecoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            labelText: "Search here..",
                            labelStyle: TextStyle(color: Colors.grey,fontSize: 13),
                          ),
                          // searchFieldPadding: EdgeInsets.only(bottom: 0)
                        ),

                        disableLengthCheck: false,
                        dropdownDecoration: BoxDecoration(

                        ),
                        style:  TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            // color: MainColor.ColorBlack,
                            fontWeight: FontWeight.w400,
                            fontFamily:  MyString.PlusJakartaSansmedium),
                        decoration: InputDecoration(
                            counterText: '',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:
                                 BorderSide(color: myColors.grey_38)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:  BorderSide(
                                  color:myColors.grey_38,
                                  width: 2
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: myColors.grey_38,
                              ),
                            ),
                            errorStyle: const TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontFamily:  MyString.PlusJakartaSansregular,
                              color: myColors.medium_red,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: myColors.grey_38,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: myColors.grey_38,
                              ),
                            ),
                            hintText: "Type here",
                            hintStyle: TextStyle(
                                color: myColors.grey_one,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily:  MyString.PlusJakartaSansregular,),
                          ),
                        initialCountryCode: 'IN',
                        onChanged: (value) {
                          countrucode = value.countryCode;
                          phoneController.text = value.number;

                          print("country code >>>" + value.countryCode);
                          print("kjxcfjkgjkj"+value.number);
                          setState(() {});
                          if (phoneController.text.trim().isNotEmpty) {
                            is_btn = true;
                            setState(() {});
                          } else {
                            is_btn = false;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ),

               /*     Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                      height: 56,
                      decoration: BoxDecoration(),
                      alignment: Alignment.topCenter,
                      child: Material(
                        elevation: 1,
                        color: myColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          controller: phoneController,
                          focusNode: phoneFocus,
                          keyboardType: TextInputType.number,
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
                              color: myColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              fontFamily: "PlusJakartaSansmedium"),
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor:  myColors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: myColors.grey_38)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: myColors.grey_38, width: 0.4)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: myColors.grey_38, width: 0.4)),
                              hintText: "Type here",
                              hintStyle: TextStyle(
                                  color: myColors.grey_one,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontFamily: "PlusJakartaSansregular"),
                              contentPadding: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 0)),
                        ),
                      ),
                    ),*/

                    /// Email error message....................................
                    is_phone == true
                        ? Container(
                      padding:
                      EdgeInsets.only(left: 25, right: 2, top: 8),
                      child: Text(
                        phone_error_str,
                        style: TextStyle(
                            color:myColors.medium_red,
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
        .hasMatch(phoneController.text);
    print("emailValid${emailValid}");
    if (phoneController.text.trim().isEmpty) {
      is_phone = true;
      phone_error_str = "Please enter email";
      setState(() {});
      // Utility.CustomToast("Please enter email");
    }
    // else if (!emailValid) {
    //   is_phone = true;
    //   phone_error_str = "Somethings_not_right".tr;
    //   setState(() {});
    //   // Utility.CustomToast("Please valid email");
    // }
    else {
      is_phone = false;
      setState(() {});
      _handleprimaryphone();
    }
  }

  void _handleprimaryphone() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            height: 280,
            color:  myColors.white,
            child: SetPrimaryPhonePopup(status: 'setprimary', oncallback: widget.oncallback, value: phoneController.text,));
      },
    );
  }
}

class SetPrimaryPhonePopup extends StatefulWidget {
  String status,value;
  Function oncallback;
  SetPrimaryPhonePopup({super.key,required this.status,required this.oncallback,required this.value});

  @override
  State<SetPrimaryPhonePopup> createState() => _SetPrimaryPhonePopupState();
}

class _SetPrimaryPhonePopupState extends State<SetPrimaryPhonePopup> {
  List<String> list = [MyString.Set_as_primary_address, MyString.Remove];
  List<String> locklist = ['Passcode', 'Face Recognition','Fingerprint'];

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
                            color: myColors.black,
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
                            color: myColors.black,
                            fontFamily: MyString.PlusJakartaSansSemibold,
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

  void setprimarypopup() {
    showModalBottomSheet<int>(
      barrierColor: Colors.black.withOpacity(0.80),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            child: SetPrimaryAndRemovePopup(title: "Set the following address as a primary one?", status: 'set', phone:  widget.value, oncallback: widget.oncallback,));
      },
    );
  }

  void removepopup() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            child:  SetPrimaryAndRemovePopup(title: "Are you sure you wish to remove the following address?s", status: 'remove', phone: widget.value, oncallback: widget.oncallback,));

      },
    );
  }
}






class SetPrimaryAndRemovePopup extends StatefulWidget {
  String title,status,phone;
  Function oncallback;
  SetPrimaryAndRemovePopup({super.key,required this.title,required this.status,required this.phone,required this.oncallback});

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
                  color:  myColors.white,
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
                            fontFamily:  MyString.PlusJakartaSansSemibold,
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
                              widget.phone,
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
                  Navigator.pop(context);
                  widget.oncallback("phone",widget.phone);
                  //_handleprimaryphone();

                }else if(widget.status == 'remove'){
                  // _handleprimaryphone();
                  widget.oncallback("phone",'');
                }
              },
              child: Container(
                  height: 80,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 60),
                  child: GlobalThemeButton2(
                      buttonName: "Save",
                      buttonColor:  myColors.app_theme)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleprimaryphone() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            height: 330,
            color:  myColors.white,
            child: SetPrimaryPhonePopup(status: 'remove', oncallback: widget.oncallback, value:widget.status == 'remove' ?'' : widget.phone ,));
      },
    );
  }
}

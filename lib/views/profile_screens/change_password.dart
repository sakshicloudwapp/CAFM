import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/AuthScreens/password_changed_successfull_screen.dart';
import 'package:fm_pro/views/profile_screens/password_changed_successfully.dart';

import '../../global/my_string.dart';
import '../../widgets/customNavigator.dart';
import '../../widgets/custom_texts.dart';

class TextfieldModel{
  String? hinttext;
  bool? is_hide;

  TextfieldModel(this.hinttext, this.is_hide);
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  bool is_current_pass = true;
  bool is_new_pass = true;
  bool is_retype_pass = true;

  String pass1= "";
  String pass2= "";
  String pass3= "";

  List<TextEditingController> _controllers = [];
TextEditingController type_current_passContrller = TextEditingController();
TextEditingController type_new_passContrller = TextEditingController();
TextEditingController retype_current_passContrller = TextEditingController();
  List<TextfieldModel> textfieldList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textfieldList = [
      TextfieldModel(MyString.type_current_pass,true),
      TextfieldModel(MyString.type_new_pass,true),
      TextfieldModel(MyString.retype_new_pass,true),
    ];

  }

  hidepass1(){
    is_current_pass = !is_current_pass;
    setState((){});
  }
  hidepass2(){
    is_new_pass = !is_new_pass;
    setState((){});
  }
  hidepass3(){
    is_retype_pass = !is_retype_pass;
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: data,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: myColors.app_theme,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            backgroundColor: myColors.app_theme,
            elevation: 0,
            flexibleSpace: Container(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
              alignment: Alignment.center,
              child: SafeArea(
                child: Column(
                  children: [
                    //Header..............................................................................................................
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 50,
                            child: SvgPicture.asset(
                              "assets/images/back_white.svg",
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: CustomText.CustomBoldTextDM(
                                  MyString.change_password,
                                  myColors.white,
                                  FontWeight.w700,
                                  16,
                                  1,
                                  TextAlign.center)),
                          flex: 1,
                        ),
                        Container(
                          height: 30,
                          width: 60,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),),


        body: bodywidget() ,
      ),
    );
  }

  bodywidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [

            /// Type current password..........
            SizedBox(height: 20,),
           /* ListView.builder(
              itemCount: textfieldList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  _controllers.add(new TextEditingController());

                  return Container(
                    child: _textfield(textfieldList[index],index),
                  );

                }),*/

            _textfield(MyString.type_current_pass),

            ///Type new password...............
            SizedBox(height: 10,),
            _textfield1(MyString.type_new_pass),

            /// Retype new password...........
            SizedBox(height: 10,),
            _textfield2(MyString.retype_new_pass),


            SizedBox(height: 150,),
          pass1 == "" ||  pass2 == "" ||  pass3 == "" ? Container() :
                GestureDetector(
                  onTap: (){
                    CustomNavigator.custompush(context, PasswordChangedSuccessfully(),false);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: myColors.app_theme,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child: Text("Submit",style: TextStyle(color: myColors.white,fontSize: 14,fontFamily: MyString.PlusJakartaSansmedium,fontWeight: FontWeight.w600),)),
                  ),
                )


          ],
        ),
      ),
    );
  }


  _textfield(String text){
    return Container(
    child:  TextFormField(
     controller: type_current_passContrller,
      showCursor: true,
        obscureText:is_current_pass,
        cursorColor: myColors.app_theme,
        onChanged: (String value){
       pass1 = value;
          setState((){});
        },
        decoration:  InputDecoration(
          suffixIcon:GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              is_current_pass = !is_current_pass;
              setState((){});
            },
            child:  Padding(
              padding: EdgeInsets.only(left: 12,right: 12),
              child: is_current_pass == true?  SvgPicture.asset("assets/images/hidepass.svg") : Icon(Icons.remove_red_eye_outlined,color: myColors.grey_two,),
            ),
          ),
          
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: myColors.app_theme,width: 1)
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: myColors.grey_five,width: 0.3)
          ),
          hintStyle: TextStyle(fontSize: 12,color: myColors.grey_two),
          hintText: text,
        ),
      ),
    );
  }

  _textfield1(String text){
    return Container(
      child:  TextFormField(
        //  controller: _controllers[index],
        showCursor: true,
        obscureText:is_new_pass,
        cursorColor: myColors.app_theme,
        onChanged: (String value){
          pass2 = value;
          setState((){});
        },
        decoration:  InputDecoration(
          suffixIcon:GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              is_new_pass = !is_new_pass;
              setState((){});
            },
            child:  Padding(
              padding: EdgeInsets.only(left: 12,right: 12),
              child: is_new_pass == true?  SvgPicture.asset("assets/images/hidepass.svg") : Icon(Icons.remove_red_eye_outlined,color: myColors.grey_two,),
            ),
          ),

          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: myColors.app_theme,width: 1)
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: myColors.grey_five,width: 0.3)
          ),
          hintStyle: TextStyle(fontSize: 12,color: myColors.grey_two),
          hintText: text,
        ),
      ),
    );
  }


  _textfield2(String text){
    return Container(
      child:  TextFormField(
        //  controller: _controllers[index],
        showCursor: true,
        obscureText:is_retype_pass,
        cursorColor: myColors.app_theme,
        onChanged: (String value){
          pass3 = value;
          setState((){});
        },
        decoration:  InputDecoration(
          suffixIcon:GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              is_retype_pass = !is_retype_pass;
              setState((){});
            },
            child:  Padding(
              padding: EdgeInsets.only(left: 12,right: 12),
              child: is_retype_pass == true?  SvgPicture.asset("assets/images/hidepass.svg") : Icon(Icons.remove_red_eye_outlined,color: myColors.grey_two,),
            ),
          ),

          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: myColors.app_theme,width: 1)
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: myColors.grey_five,width: 0.3)
          ),
          hintStyle: TextStyle(fontSize: 12,color: myColors.grey_two),
          hintText: text,
        ),
      ),
    );
  }






}

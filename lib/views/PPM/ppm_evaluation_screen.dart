import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/PPM/ppm_signature.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';

class PPM_Evaluation_Screen extends StatefulWidget {
  String TasklogId;
  String feedBackComment;
  Function oncallback;
   PPM_Evaluation_Screen({Key? key,required this.TasklogId,required this.oncallback,required this.feedBackComment}) : super(key: key);

  @override
  _PPM_Evaluation_ScreenState createState() => _PPM_Evaluation_ScreenState();
}

class _PPM_Evaluation_ScreenState extends State<PPM_Evaluation_Screen> {
  bool is_red = false;
  bool is_white = false;
  bool is_green = false;
   String signature = "";
   int rating = 0;
   File? imagefile;
   TextEditingController commentController = TextEditingController();
   final commentFocus = FocusNode();


   OnCallBack(String signature1){
     signature = signature1;
     setState(() {});
     _createFileFromString();
     setState(() {});
   }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  void initState (){
     widget.feedBackComment == "null"?
     commentController.text = "Enter your comments":
     commentController.text = widget.feedBackComment.toString();

     setState(() {

     });
  }


   Future<File> imageToFile() async {
    var bytes = await rootBundle.load('$signature');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    print("file<<${file}");

    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    imagefile =file;
    setState(() {});
    return file;
  }

  Future<String> _createFileFromString() async {
    final encodedStr = signature.replaceAll("data:image/jpeg;base64,", "");
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".png");
    await file.writeAsBytes(bytes);
    imagefile = file;
    setState(() {});
    return file.path;
  }

  addfeedbackapi() async{

    commentFocus.unfocus();
    setState(() {});
     if(widget.TasklogId.trim().isEmpty){
       CustomToast.showToast(msg: " tasklogid in null");
     }else if(rating.toString().isEmpty || rating == 0){
       CustomToast.showToast(msg: "Please select emoji");
     }else if( is_green == false &&  is_white == false &&  is_red == false){
       CustomToast.showToast(msg: "Please select emoji");
     }
     else if(commentController.text.isEmpty){
       CustomToast.showToast(msg: "Please enter comment");
     }
     else if(imagefile == null){
       CustomToast.showToast(msg: "Please enter signature");
     }
     else{
       print("img><${imagefile!.path}");

     //  await Webservices.postWithMultiImage(context,int.parse(widget.TasklogId), rating, commentController.text,widget.oncallback,imagefile);
       await Webservices.RequestSaveTaskLogFeedBack(context,int.parse(widget.TasklogId), rating, commentController.text,widget.oncallback,imagefile);

     }
    setState(() {});
       }

  List<String> subjectList = [
    "ACCE - Accelerator Building",
    "ACCE - Accelerator ",
    "ACCE -  Building",
  ];
  String? selectBuilding;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    commentFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: myColors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
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
                              child: CustomText.CustomBoldText(
                                  "Evaluation",
                                  myColors.white,
                                  FontWeight.w700,
                                  16,
                                  1,
                                  TextAlign.center)),
                          flex: 1,
                        ),
                       /* Container(
                          height: 30,
                          width: 70,
                          child: GestureDetector(
                            onTap: (){
                              _createFileFromString();
                              addfeedbackapi();
                            },
                            child: Image.asset("assets/images/color_CheckCircle-img.png",height: 30,width: 30,color: myColors.white,) ,
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ),
        body: GestureDetector(
          onTap: (){
            commentFocus.unfocus();
            setState(() {});
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Center(
                    child: CustomText.CustomBoldText(MyString.PleaseRateYourExp,
                        myColors.black, FontWeight.w700, 18, 1, TextAlign.center) ,
                  )
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Center(
                      child: CustomText.CustomRegularText(MyString.EvalutionDescrip,
                          myColors.grey_43, FontWeight.w400, 14, 0, TextAlign.center) ,
                    )
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(30, 38, 30, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if(is_green ==  true){
                            is_green = false;
                            rating = 0;
                          }else{
                            is_green = true;
                            is_white = false;
                            is_red = false;
                            rating = 1;
                          }
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(spreadRadius: 0.5,color: myColors.grey_22.withOpacity(0.60))
                              ]
                          ),
                          child: Material(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              child: Image.asset(is_green == true? "assets/images/fill_good.png" : "assets/images/good1.png", )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if(is_white ==  true){
                            is_white = false;
                            rating = 0;
                          }else{
                            is_white = true;
                            is_red = false;
                            is_green = false;
                            rating = 2;
                          }
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(spreadRadius: 0.5,color: myColors.grey_22.withOpacity(0.60))
                              ]
                          ),
                          child: Material(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(200)
                              ),child: Image.asset( is_white == true ? "assets/images/fill_nature.png" : "assets/images/nature1.png" )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if(is_red ==  true){
                            is_red = false;
                            rating = 0;
                          }else{
                            is_red = true;
                            is_white = false;
                            is_green = false;
                            rating = 3;
                          }
                          setState(() {

                          });
                        },
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(spreadRadius: 0.5,color: myColors.grey_22.withOpacity(0.60))
                              ]
                          ),
                          child: Material(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200)
                            ),
                            child: Image.asset(is_red == true ? "assets/images/fill_agrey.png" : "assets/images/angrey1.png",
                              //  is_red== true ? "assets/images/img_smily_red.png" : "assets/images/img_smily_grey.png"
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                ///Comments.......................................................
                /*Container(
                  padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.CustomSemiBoldText(MyString.Comments,
                          myColors.grey_28, FontWeight.w400, 12, 1, TextAlign.center),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText.CustomRegularText("Select Completed Jobs",
                          myColors.grey_28, FontWeight.w500, 12, 1, TextAlign.center),
                    ],
                  )
                ),
                Container(
                    decoration: DottedDecoration(
                  shape: Shape.line, linePosition: LinePosition.bottom,dash: [1,0],color: myColors.grey_eight,strokeWidth: 1.5 //remove this to get plane rectange
                ),
                    padding: EdgeInsets.fromLTRB(0,5,0,5),
                    margin: EdgeInsets.only(top: 10,bottom: 20,left: 20,right: 20),
                    alignment: Alignment.center,
                    child:  subjectDropDown()
                ),*/

                Container(
                  height: 95,
                  margin: EdgeInsets.fromLTRB(20, 16, 20, 16),
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: myColors.grey_29),
                    color: myColors.bg_bottom,
                  ),
                  child: TextField(
                    readOnly: widget.feedBackComment == "null"?false:true,
                    controller: commentController,
                    focusNode: commentFocus,
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      print("TAG" + value);
                      setState(() {});
                    },
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: MyString.PlusJakartaSansregular,
                      color: myColors.grey_21,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: MyString.Ente_your_comments,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: myColors.grey_21,
                          fontFamily:
                          MyString.PlusJakartaSansregular,),
                      counter: Offstage(),
                      isDense: true,
                      // this will remove the default content padding
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                    ),
                    maxLines: 5,
                    cursorColor: myColors.grey_21 ,
                  ),
                ),

                /*Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomText.CustomSemiBoldText(MyString.Signature,
                      myColors.grey_28, FontWeight.w400, 12, 1, TextAlign.center),
                ),*/

                ///Singnature.......................................................
                GestureDetector(

                  onTap: widget.feedBackComment == "null"? (){
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PPM_Signature(OnCallBack: OnCallBack,),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                    setState(() {});
                  }:(){} ,
                  child: Container(
                    height: 95,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 16),
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: myColors.grey_29),
                      color: myColors.bg_bottom,
                    ),
                    child:
                    signature.trim().isEmpty?
                    CustomText.CustomRegularText(MyString.Click_Here_to_sign,
                        myColors.grey_21, FontWeight.w400, 12, 1, TextAlign.center)
                    : Center(child: Image.memory(dataFromBase64String(signature.toString().replaceAll("data:image/jpeg;base64,", "")),fit: BoxFit.fill,)),

                  ),
                ),
               /* Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Signed by :- ",style: TextStyle(fontFamily: MyString.PlusJakartaSansmedium,fontSize: 16),),
                          Text("Signed by :- ",style: TextStyle(fontFamily: MyString.PlusJakartaSansmedium,fontSize: 16),)

                        ],
                      )
                    ],
                  ),
                )*/

                ///Comments.......................................................


              ],
            ),
          ),
        ),

        bottomNavigationBar: GestureDetector(
          onTap: widget.feedBackComment== "null"?  (){
            _createFileFromString();
         //  imageToFile(signature);
            addfeedbackapi();
          }:(){} ,
          child: Container(
            alignment: Alignment.center,
            height: 50,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: myColors.app_theme,
            ),
            child: CustomText.CustomBoldText(MyString.UPDATE, myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
          ),
        ),
      ),
    );
  }
  subjectDropDown(){
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          'CAG-IFM',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Theme
                .of(context)
                .hintColor,
          ),
        ),
        items: subjectList
            .map((String cityTypList) =>
            DropdownMenuItem<String>(
              value: cityTypList,
              child: Text(
                cityTypList.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ))
            .toList(),
        value: selectBuilding,
        onChanged: (String? value) {
          setState(() {
            selectBuilding = value;
          });
        },
        buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 0),
            height: 40,
            width: 400
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 35,
        ),

      ),
    );
  }
}


/*
static Future<void> RequestSaveTaskLogFeedBack(
BuildContext context,
    int taskLogId,
int rating,
    String comments,
Function onupdate,
var file) async {
SharedPreferences p = await SharedPreferences.getInstance();
var base_url = p.getString("mainurl");
String main_url = "${base_url.toString()}";
CustomLoader.showAlertDialog(context, true);
try {
var request = http.MultipartRequest(
'POST',
Uri.parse(main_base_url + AllApiServices.SaveTaskLogFeedBack),
);

Map<String, String> header = {
"accept": "application/json",
"Authorization": "Bearer ${p.getString("access_token")}"
};

request.headers.addAll(header);

if (file == null) {
print("else");
request.fields['TaskLogId'] = taskLogId.toString();
request.fields['Rating'] = rating.toString();
request.fields['Comments'] = comments;

} else {
// print("image ${file}");
request.fields['TaskLogId'] = taskLogId.toString();
request.fields['Rating'] = rating.toString();
request.fields['Comments'] = comments;
var stream =
http.ByteStream(DelegatingStream.typed(file.openRead()));
var length = await file.length();
print(length);
var multipartFile = http.MultipartFile("File",stream, length, filename: basename(file.path));
request.files.add(multipartFile);
print(file.path);
// request.files
//     .add(await http.MultipartFile.fromPath('File', file.path));
}

CustomLoader.showAlertDialog(context, false);
var myRequest = await request.send();
var response = await http.Response.fromStream(myRequest);
if(myRequest.statusCode == 200){
//return jsonDecode(response.body);
print('upload sucess');
}else{
print("Error ${myRequest.statusCode}");
}
print('the request is :${request}');
print(request.fields);
print(request.files);

// var response = await request.send();
print("response.....${response.headers.toString()}");

// response.stream.transform(convert.utf8.decoder).listen((event) {
//   print("event.... >>>>>>${event.toString()}");
//
//
//   Navigator.pop(context);
//   onupdate();
//     /// SUCCESS
// //  }
//
//
// }
// );
} catch (e) {
///EXCEPTION
CustomLoader.showAlertDialog(context, false);
print("error: $e");
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('error: $e')),
);
}
}


static Future<Map<String, dynamic>> postWithMultiImage(
BuildContext context,
    int taskLogId,
int rating,
    String comments,
Function onupdate,
var file) async {
SharedPreferences p = await SharedPreferences.getInstance();
var base_url = p.getString("mainurl");
String main_url = "${base_url.toString()}";
CustomLoader.showAlertDialog(context, true);
Map<String, String> headers = {
  "accept": "application/json",
  "Authorization": "Bearer ${p.getString("access_token")}"
};
Map<String, String> _params = {
  'TaskLogId' :taskLogId.toString(),
  'Rating' : rating.toString(),
  'Comments' : comments.toString(),

};
if (headers != null) {
print('_headers => $headers');
}
print('_params => $_params');

var request = http.MultipartRequest("POST", Uri.parse(AllApiServices.SaveTaskLogFeedBack));
if (headers != null) {
request.headers.addAll(headers);
}
if (_params != null) {
request.fields.addAll(_params);
}
if (file != null) {
// for (int i = 0; i < imagefile.length; i++) {
final _type = lookupMimeType(file.path);
print("_type>>>${_type}");
final _name =
'${DateTime.now().toIso8601String()}.${_type!.split('/').last}';
print("_name>>>${_name}");
final _partFile = http.MultipartFile(
"File",
File(file.path).openRead(),
File(file.path).lengthSync(),
filename: _name);
request.files.add(_partFile);
}

print('request files: ${request.files}');

var response = await request.send();
final code = response.statusCode;
print('response code => $code');
final responseBody = await http.Response.fromStream(response);
final body = responseBody.body;
final jsonBody = json.decode(body);
Map<String, dynamic> _resDic;
if (code == 200) {
CustomLoader.showAlertDialog(context, false);
_resDic = Map<String, dynamic>.from(jsonBody);
print("SUCCESS");
//_resDic[STATUS] = _resDic[SUCCESS] == 1;
} else {
CustomLoader.showAlertDialog(context, false);
_resDic = Map<String, dynamic>();
print("Something went wrong");

}
CustomLoader.showAlertDialog(context, false);
print("error");
//_resDic[HTTP_CODE] = code;
return _resDic;
}*/

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/PPM/ppm_hesq_quitionaire.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ImageFileModel {
  String? questionId;
  File? file;

  ImageFileModel(
      {this.questionId,
        this.file});

  ImageFileModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['file'] = this.file;
    return data;
  }
}

List<HESQ_Model> checkListadd = [];

class PPM_Checklist_Screen extends StatefulWidget {
  String taskId;
  Function onCallback;
  CheckListItems checkListItems;
  // Function Oncallback;
  String categoryName;
  String title;
  String appbartitle;
  String isquestionanswer;
  String screent_title;
  List<ChecklistQuestionAnswers> checkquestionAnswerlist;

  PPM_Checklist_Screen(
      {Key? key,
        required this.taskId,
        required this.onCallback,
        required this.checkListItems,
        required this.categoryName,
        required this.title,
        required this.appbartitle,
        required this.isquestionanswer,
        required this.checkquestionAnswerlist,
        required this.screent_title,

      })
      : super(key: key);

  @override
  _PPM_Checklist_ScreenState createState() => _PPM_Checklist_ScreenState();
}

class _PPM_Checklist_ScreenState extends State<PPM_Checklist_Screen> {
  String checklist_questionanswer = "";
  List<ChecklistQuestionAnswers> checkquestionAnswerlist = [];
  List<CheckListItems> checklist = [];
  @override
  void initState() {
    checkListadd.clear();
    imagefilelist!.clear();
    setState(() {});
    additionolinfo();
    super.initState();
  }

  additionolinfo() async {
    checkquestionAnswerlist.clear();
    checklist.clear();
    setState(() {});
    Future.delayed(Duration.zero, () async {
      await RequestAdditionolInfo(
          context, true, widget.taskId.toString());
      setState(() {});
    });

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
                            widget.onCallback();
                            setState(() {

                            });
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
                                  widget.screent_title,
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
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: CustomText.CustomSemiBoldText(MyString.Task_instructions,
                        myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 28, 16, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 120,
                          child: CustomText.CustomMediumText(
                              MyString.Title,
                              myColors.black,
                              FontWeight.w600,
                              12,
                              1,
                              TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "${widget.title}",
                                  style: TextStyle(
                                    color: myColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ))),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 120,
                          child: CustomText.CustomMediumText(
                              MyString.Frequency,
                              myColors.black,
                              FontWeight.w600,
                              12,
                              1,
                              TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              child: CustomText.CustomMediumText("", myColors.black,
                                  FontWeight.w400, 12, 1, TextAlign.center),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 120,
                          child: CustomText.CustomMediumText(
                              MyString.Category,
                              myColors.black,
                              FontWeight.w600,
                              12,
                              1,
                              TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              child: CustomText.CustomMediumText(
                                  "${widget.categoryName}",
                                  myColors.black,
                                  FontWeight.w400,
                                  12,
                                  1,
                                  TextAlign.center),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 30, 16, 0),
                    alignment: Alignment.topLeft,
                    width: 120,
                    child: CustomText.CustomMediumText(MyString.Checklist,
                        myColors.black, FontWeight.w600, 12, 1, TextAlign.center),
                  ),

                  Container(
                    child: SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Container(
                            height: 44,
                            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: myColors.orange),
                              color: myColors.light_orange,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.S_no,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    child: CustomText.CustomMediumText(
                                        MyString.Details,
                                        myColors.grey_twenty,
                                        FontWeight.w500,
                                        12,
                                        1,
                                        TextAlign.center),
                                  ),
                                ),

                                ///Status.............
                                Container(
                                  width: 40,
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.Status,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                                Container(
                                  width: 15,
                                  height: 15,
                                  margin: EdgeInsets.only(left: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                      child: Image.asset(
                                          "assets/images/img_orange_check.png")),
                                ),
                              ],
                            ),
                          ),

                          /*    Container(
                            height: 44,
                            margin: EdgeInsets.fromLTRB(2, 16, 2, 0),
                            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: myColors.orange),
                              color: myColors.light_orange,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.S_no,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                                Container(
                                  width: 105,
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.Details,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                                ///Standards...........
                                Container(
                                  width: 70,
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.Standards,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                                ///Status.............
                                Container(
                                  width: 40,
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.Status,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                                Container(
                                  width: 15,
                                  height: 15,
                                  margin: EdgeInsets.only(left: 8),
                                  alignment: Alignment.centerLeft,
                                  child: Center(child: Image.asset("assets/images/checkbox2_uncheck.png")),

                                ),

                                ///Comments..................
                                Container(
                                  width: 135,
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.Comments,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),

                                ///Image..................
                                Container(
                                  width: 50,
                                  margin: EdgeInsets.only(left: 20),
                                  alignment: Alignment.centerLeft,
                                  child: CustomText.CustomMediumText(
                                      MyString.Image,
                                      myColors.grey_twenty,
                                      FontWeight.w500,
                                      12,
                                      1,
                                      TextAlign.center),
                                ),
                              ],
                            ),
                          ),*/

                          ///List................................................
                         widget.checkListItems.toString() == "null" ?
                         Container(): widget.checkListItems.questions == null
                              ? Container()
                              : Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                  widget.checkListItems.questions!.length,
                                  itemBuilder: (context, int index) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 1, vertical: 3),
                                        child: CheckList(
                                          index: index,
                                          questionsModel: widget
                                              .checkListItems.questions![index],
                                          HseqModel: widget.checkListItems,
                                          tasklogId: widget.taskId.toString(),
                                          isquestionanswer:
                                          widget.isquestionanswer,
                                          checkquestionAnswerlist:
                                          widget.checkquestionAnswerlist,
                                        ),
                                      ),
                                    );
                                  })),

                          /*   Container(
                            width: 555,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: checkList.length,
                                  itemBuilder: (context, int index) {
                                    return InkWell(
                                      onTap: () {
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 1, vertical: 3),
                                        child: CheckList(index: index),
                                      ),
                                    );
                                  })),*/
                        ],
                      ),
                    ),
                  ),

                  ///SAVE..........................................
                  InkWell(
                    onTap: () {
                      //  focusNode.unfocus();
                      setState(() {});
                      if(widget.checkListItems.questions == null){
                        CustomToast.showToast(msg: "Question  is null");
                        Navigator.pop(context);
                      }else if(widget.checkListItems.answers == null){
                        CustomToast.showToast(msg: "Answers  is null");
                        Navigator.pop(context);
                      }else{
                        ChecklistApi();
                      }

                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(24, 10, 24, 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: myColors.app_theme,
                      ),
                      child: CustomText.CustomBoldText(MyString.SAVE,
                          myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
            is_true? Container(
              color: Colors.black.withOpacity(0.10),
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: myColors.app_theme,),
            ):Container()
          ],
        ),
      ),
    );
  }


  /// AdditionInfo Api call
  Future<void> RequestAdditionolInfo(BuildContext context,
      bool load,
      String taskLogId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);
    print("timezone${p.getString("timezone")}");
    try {
      final response = await http.get(Uri.parse(
          widget.appbartitle =="schedule"?
          main_base_url + AllApiServices.scheduleapi+ AllApiServices.task_log_additionol_info +
              taskLogId.toString():
          main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.task_log_additionol_info +
              taskLogId.toString()
          //main_base_url+AllApiServices.task_log_additionol_info+taskLogId.toString()
      ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });

      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      print("additionalInfo" + jsonResponse.toString());
      if (response.statusCode == 200) {
        var taskresources = jsonResponse['taskResources'];
        var masterResources = jsonResponse['masterResources']['data'];
        var checklist_question = jsonResponse['checkListItems'];
        var checklist_questionanswer2 = jsonResponse['checkListItems']['questionAnswers'];
        print("checklist_questionanswer2>>${checklist_questionanswer2}");

        // CheckListItems model3 = CheckListItems.fromJson(checklist_question);
        // checklist.add(model3);
        // checklist_questionanswer = model3.questionAnswers.toString();

        if (checklist_questionanswer2 == null) {

        } else {
          checklist_questionanswer2.forEach((e) {
            ChecklistQuestionAnswers model4 = ChecklistQuestionAnswers.fromJson(
                e);
            checkquestionAnswerlist.add(model4);

            setState(() {

            });
            print("checkquestionAnswer >>${checklist_questionanswer2}");
            print("checkquestionAnswer >>${checklist_questionanswer2}");
          });
        }


        checklist_questionanswer = checklist_questionanswer2.toString();
        setState(() {});

        // print("checklist_questionanswer>>${checklist_questionanswer}");

        print("additionalInfo  response" + response.toString());
      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      //   CustomLoader.showAlertDialog(context, false);
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }

  bool is_true = false;

  ChecklistApi() async {
    String json = jsonEncode(checkListadd);
    if (checkListadd.isEmpty || widget.checkListItems.questions!.isEmpty) {
      Fluttertoast.showToast(msg: "Please select answer");
    } else {
      if (checkListadd.length.toString() != widget.checkListItems.questions!.length.toString()) {
        Fluttertoast.showToast(msg: "Please select All questions answer");
      } else {
        for (int j = 0; j < checkListadd.length; j++) {
          if (checkListadd[j].answerId.toString().isEmpty ||
              checkListadd[j].answerId.toString() == "null" ||
              checkListadd[j].answerId.toString() == "") {
            Fluttertoast.showToast(msg: "Please select answer");
          } else {
            is_true = true;
            await RequestAddPPMChecklistApi();
            setState(() {});
            // break;
          }
        }
      }
    }
  }

 /* HseqApi() async {
    String json = jsonEncode(checkListadd);
    print("jsonresponse gjkhkghkhkgl>>${json}");
    print("checkListadd>>${checkListadd.length}");
    if (is_true == false) {
      if (checkListadd.isEmpty || widget.checkListItems.questions!.isEmpty) {
        Fluttertoast.showToast(msg: "Please select answer");
      } else {
        for (int i = 0; i < widget.checkListItems.questions!.length; i++) {
          if (checkListadd.length.toString() !=
              widget.checkListItems.questions!.length.toString()) {
            Fluttertoast.showToast(msg: "Please select All questions answer");
          } else {
            for (int j = 0; j < checkListadd.length; j++) {
              // if (questionanserlist[j].questionId.toString() == widget.hseqlist.questions![i].id.toString()) {
              //   Fluttertoast.showToast(msg: "Please select All questions answer");
              // }
              if (checkListadd[i].answerId.toString().isEmpty ||
                  checkListadd[i].answerId.toString() == "null" ||
                  checkListadd[i].answerId.toString() == "") {
                Fluttertoast.showToast(msg: "Please select answer");
              } else {
                is_true = true;
                setState(() {});
                break;
              }
            }
          }
        }
      }
    } else {
      await RequestAddPPMChecklistApi();
      // await Webservices.RequeSaveTaskQuestion(
      //     context, true, checkListadd, widget.Oncallback);
    }
    // await add(context, true, checkListadd, widget.Oncallback);
  }*/




  Future<void> RequestAddPPMChecklistApi(
      ) async {

    SharedPreferences p = await SharedPreferences.getInstance();
    String menu_status = p.getString("menu_ID").toString();
    is_true = true;
    setState(() {});

    var headers = {
      'Authorization': 'Bearer ${p.getString("access_token")}'
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(
          menu_status == "4"
              ?
          main_base_url + AllApiServices.scheduleapi+ AllApiServices.SaveTaskLogQuestionnaire:
          main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.SaveTaskLogQuestionnaire
      ));

      for (int i = 0; i < checkListadd.length; i++) {
        request.fields.addAll({
          'questionAnswers[$i].taskLogId':widget.taskId.toString(),
          'questionAnswers[$i].isCheckListItem': "true",
          'questionAnswers[$i].linkId': checkListadd[i].linkId.toString(),
          'questionAnswers[$i].answerId': checkListadd[i].answerId.toString(),
          'questionAnswers[$i].comments': checkListadd[i].comments.toString(),
          'questionAnswers[$i].imageUrl': checkListadd[i].imageUrl.toString() != "null" || checkListadd[i].imageUrl.toString() != "" || checkListadd[i].imageUrl.toString().isNotEmpty ? checkListadd[i].imageUrl.toString():"" ,

        });

        if(imagefilelist![i].file == null){
        }else{
          request.files.add(await http.MultipartFile.fromPath('questionAnswers[$i].file', imagefilelist![i].file!.path));

        }
        request.headers.addAll(headers);
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Navigator.pop(context);
        widget.onCallback();
        setState(() {});
        is_true = false;
        setState(() {});
      }
      else {
        is_true = false;
        setState(() {});
      }

    } on SocketException catch (e) {
      is_true = false;
      setState(() {});
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }


}

List<File>? imageFileList = [];
List<ImageFileModel>? imagefilelist = [];

///Check list.....................................................................................................................
class CheckList extends StatefulWidget {
  int index;
  ChecklistQuestions questionsModel;
  CheckListItems HseqModel;
  String tasklogId;
  String isquestionanswer;
  List<ChecklistQuestionAnswers> checkquestionAnswerlist;

  CheckList(
      {Key? key,
        required this.index,
        required this.questionsModel,
        required this.HseqModel,
        required this.tasklogId,
        required this.isquestionanswer,
        required this.checkquestionAnswerlist})
      : super(key: key);

  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  final focusNode = FocusNode();

  void updateOrInsertHESQ(HESQ_Model newItem,ImageFileModel item2) {
    // print("item2>>${item2.file!.path}");
    int existingIndex = checkListadd
        .indexWhere((item) => item.questionId == newItem.questionId);

    if (existingIndex != -1) {
      checkListadd[existingIndex] = newItem; // Update existing item
      // imageFileList!.add(File(_image!.path.toString()));
    } else {
      checkListadd.add(newItem); // Insert new item
    }
    int existingIndex1 = imagefilelist!
        .indexWhere((item3) => item3.questionId == item2.questionId);
    if (existingIndex1 != -1) {
      imagefilelist![existingIndex1] = item2; // Update existing item
      // imageFileList!.add(File(_image!.path.toString()));
    } else {
      // checkListadd.add(newItem); // Insert new item
      imagefilelist!.add(item2); // Insert new item
    }
    String json = jsonEncode(checkListadd);
    //String json2 = jsonEncode(imagefilelist);
    print("jsonresponse55>>${json}");
    // print("jsonresponse 88 >>${json2}");
    print("imagefilelist 88 >>${imagefilelist!.length}");
    print("checkListadd check>>${checkListadd.length}");
  }

  String answerId = "0";
  String questionId = "";
  final ImagePicker imagePicker = ImagePicker();
  File? _image;
  String img = "";
  String imgurl = "";
  TextEditingController controller = TextEditingController();

  setdata() {
    print("taskId>${widget.tasklogId}");
   // print("questionsModel id>${widget.questionsModel.id}");
    if (widget.isquestionanswer.toString() == "null") {
    } else {
      String json = jsonEncode(checkListadd);
      print("jsonresponse4455>>${json}");
      print(
          "widget.isquestionanswer.toString()>>${widget.isquestionanswer.toString()}");

      print("hx${widget.checkquestionAnswerlist.length}");
      if (widget.checkquestionAnswerlist.isEmpty ||
          widget.checkquestionAnswerlist == null) {
      } else {
        for (int i = 0; i < widget.checkquestionAnswerlist.length; i++) {
          print("questionsModel id>${widget.checkquestionAnswerlist[i].linkId}");
          print("imageUrl${widget.checkquestionAnswerlist[i].imageUrl}");



          if (widget.questionsModel.id.toString() ==
              widget.checkquestionAnswerlist[i].linkId.toString()) {
            HESQ_Model model = HESQ_Model(
              questionId: widget.checkquestionAnswerlist[i].linkId.toString(),
              comments: widget.checkquestionAnswerlist[i].comments.toString(),
              taskLogId: int.parse(
                  widget.checkquestionAnswerlist[i].taskLogId.toString()),
              answerId: int.parse(
                  widget.checkquestionAnswerlist[i].answerId.toString()),
              linkId:
              int.parse(widget.checkquestionAnswerlist[i].linkId.toString()),
              imageUrl: widget.checkquestionAnswerlist[i].imageUrl,
              isCheckListItem: widget.checkquestionAnswerlist[i].isCheckListItem,
              //file:_image == null ? null : File(_image!.path.toString())
            );
            print("model id>>${model.linkId}");

            ImageFileModel model2 = ImageFileModel(
                questionId: widget.questionsModel.id.toString(),
                file:null
            );
            updateOrInsertHESQ(model,model2);
            setState(() {});
            answerId = widget.checkquestionAnswerlist[i].answerId.toString();
            controller.text =
                widget.checkquestionAnswerlist[i].comments.toString();
            imgurl =
                widget.checkquestionAnswerlist[i].imageUrl.toString();
            break;
          }
          setState(() {});
        }
      }
      print("hxcheckquestionAnswerlist  ${widget.checkquestionAnswerlist.length}");
    }
  }

  Future<void> showImagePickerOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Upload image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      pickImage(context, ImageSource.camera);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      pickImage(context, ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future pickImage(BuildContext context, imageSource) async {
    if (!kIsWeb) {
      var image = await imagePicker.pickImage(
        source: imageSource,
        imageQuality: 10,
      );

      if (image == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _image = File(image!.path);
          img = _image!.path.toString();
          image = null;
          print("_image>>${_image!.path}");
        });
        Navigator.pop(context);
        HESQ_Model model = HESQ_Model(
          questionId: widget.questionsModel.id.toString(),
          comments: controller.text,
          taskLogId: int.parse(widget.tasklogId.toString()),
          answerId: int.parse(answerId.toString()),
          linkId: int.parse(widget.questionsModel.id.toString()),
          imageUrl: "",
          isCheckListItem: true,
          //file:_image == null ? null : File(_image!.path.toString())
        );

        ImageFileModel model2 = ImageFileModel(
            questionId: widget.questionsModel.id.toString(),
            file:_image == null ? null : File(_image!.path.toString())
        );

        print("model3>>${model2.file!.path}");
        updateOrInsertHESQ(model,model2);
        setState(() {});
      }

      print("lemmnhfhg>${checkListadd.length}");
    } else if (kIsWeb) {
      var image =
      await imagePicker.pickImage(source: imageSource, imageQuality: 10);
      if (image == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _image = File(image!.path);
          img = _image!.path.toString();
          image = null;
        });
        Navigator.pop(context);
      }
      HESQ_Model model = HESQ_Model(
        questionId: widget.questionsModel.id.toString(),
        comments: controller.text,
        taskLogId: int.parse(widget.tasklogId.toString()),
        answerId: int.parse(answerId.toString()),
        linkId: int.parse(widget.questionsModel.id.toString()),
        imageUrl: "",
        isCheckListItem: true,
        //file:_image == null ? null : File(_image!.path.toString())
      );
      ImageFileModel model2 = ImageFileModel(
          questionId: widget.questionsModel.id.toString(),
          file:_image == null ? null : File(_image!.path.toString())
      );
      updateOrInsertHESQ(model,model2);
      setState(() {});
    }

    print("lemmnhfhg>${checkListadd.length}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: myColors.app_theme),
          color: myColors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                questionId = widget.questionsModel.id.toString();
                if (widget.questionsModel.ischecked == true) {
                  widget.questionsModel.ischecked = false;
                } else {
                  widget.questionsModel.ischecked = true;
                }
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 8, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///S_no.........................
                    Container(
                      // width: 30,
                      alignment: Alignment.center,
                      child: CustomText.CustomMediumText(
                          "${widget.index + 1}.",
                          myColors.black,
                          FontWeight.w400,
                          14,
                          1,
                          TextAlign.center),
                    ),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.questionsModel.questionName.toString(),
                            style: TextStyle(
                                color: myColors.grey_twenty,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          )),
                    ),

                    ///Status.............
                    Container(
                      // width: 40,
                      margin: EdgeInsets.only(left: 6),
                      alignment: Alignment.centerLeft,
                      child: CustomText.CustomMediumText(
                          "",
                          myColors.grey_twenty,
                          FontWeight.w500,
                          12,
                          1,
                          TextAlign.center),
                    ),
                    Container(
                      // width: 15,
                      height: 15,
                      margin: EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Image.asset(
                                  "assets/images/checkbox2_uncheck.png")),
                          SizedBox(
                            width: 10,
                          ),

                          ///Arrow............
                          InkWell(
                            onTap: () {},
                            child: Container(
                              // width: 25,
                              // height: 30,
                              child: Center(
                                  child: SvgPicture.asset(
                                    widget.questionsModel.ischecked == true
                                        ? "assets/images/ic_arrow_down_grey.svg"
                                        : "assets/images/ic_arrow_right_grey.svg",
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: widget.questionsModel.ischecked == true ? true : false,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 1.2,
                        color: myColors.grey_39,
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 8),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 6, 0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          //width: 52,
                                          alignment: Alignment.centerLeft,
                                          child: CustomText.CustomMediumText(
                                              widget.questionsModel.standardName
                                                  .toString(),
                                              //  "Standards",
                                              myColors.app_theme,
                                              FontWeight.w400,
                                              10,
                                              1,
                                              TextAlign.center),
                                        ),

                                        ///Answer List..............
                                        Container(
                                            alignment: Alignment.center,
                                            child: widget.HseqModel.answers!.isEmpty
                                                ? Container()
                                                : Row(
                                                children: List.generate(
                                                  widget
                                                      .HseqModel.answers!.length,
                                                      (anserindex) => GestureDetector(
                                                    onTap: () {
                                                      focusNode.unfocus();
                                                      answerId = widget
                                                          .HseqModel
                                                          .answers![anserindex]
                                                          .answerId
                                                          .toString();
                                                      //  if(imgurl == "null" || imgurl == "" || imgurl.isEmpty){
                                                      //
                                                      //  }
                                                      // else{
                                                      HESQ_Model model =
                                                      HESQ_Model(
                                                        questionId: widget
                                                            .questionsModel.id
                                                            .toString(),
                                                        comments: controller.text,
                                                        taskLogId: int.parse(
                                                            widget.tasklogId
                                                                .toString()),
                                                        answerId: int.parse(
                                                            answerId.toString()),
                                                        linkId: int.parse(widget
                                                            .questionsModel.id
                                                            .toString()),
                                                        imageUrl: imgurl,
                                                        isCheckListItem: true,
                                                        //file: _image == null ? null : File(_image!.path.toString())
                                                      );
                                                      ImageFileModel model2 = ImageFileModel(
                                                          questionId: widget.questionsModel.id.toString(),
                                                          file:_image == null ? null : File(_image!.path.toString())
                                                      );
                                                      updateOrInsertHESQ(model,model2);
                                                      //}



                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height: 25,
                                                      //width: 48,
                                                      margin: EdgeInsets.fromLTRB(
                                                          6, 0, 0, 0),
                                                      padding:
                                                      EdgeInsets.fromLTRB(
                                                          10, 0, 10, 0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        color: answerId ==
                                                            widget
                                                                .HseqModel
                                                                .answers![
                                                            anserindex]
                                                                .answerId
                                                                .toString()
                                                            ? myColors.app_theme
                                                            : myColors.grey_two,
                                                      ),
                                                      child: CustomText
                                                          .CustomBoldText(
                                                          widget
                                                              .HseqModel
                                                              .answers![
                                                          anserindex]
                                                              .answerName
                                                              .toString(),
                                                          myColors.white,
                                                          FontWeight.w700,
                                                          10,
                                                          1,
                                                          TextAlign.center),
                                                    ),
                                                  ),
                                                ))),
                                      ],
                                    ),
                                    answerId == "0" || answerId.isEmpty || answerId == "null" ?
                                    Container():
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: CustomText.CustomMediumText(
                                          "Commnents",
                                          myColors.app_theme,
                                          FontWeight.w400,
                                          10,
                                          1,
                                          TextAlign.center),
                                    ),
                                    answerId == "0" || answerId.isEmpty || answerId == "null" ?
                                    Container():
                                    Container(
                                      width:
                                      MediaQuery.of(context).size.width / 2.2,
                                      height: 43,
                                      margin: EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color: myColors.grey_31),
                                        color: myColors.grey_32,
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        controller: controller,
                                        focusNode: focusNode,
                                        onTap: () {
                                          if (answerId == "" ||
                                              answerId == "null") {
                                            Fluttertoast.showToast(
                                                msg: "Please select answer");
                                          } else {}
                                        },
                                        onChanged: (String value) {
                                          print("TAG" + value);

                                          if (answerId == "" ||
                                              answerId == "null") {
                                            controller.clear();
                                            setState(() {});
                                            Fluttertoast.showToast(
                                                msg: "Please select answer");
                                          } else {
                                            HESQ_Model model = HESQ_Model(
                                              questionId: widget.questionsModel.id
                                                  .toString(),
                                              comments: controller.text,
                                              taskLogId: int.parse(
                                                  widget.tasklogId.toString()),
                                              answerId:
                                              int.parse(answerId.toString()),
                                              linkId: int.parse(widget
                                                  .questionsModel.id
                                                  .toString()),
                                              imageUrl: "",
                                              isCheckListItem: true,
                                              // file:_image == null ? null : File(_image!.path.toString())
                                            );
                                            ImageFileModel model2 = ImageFileModel(
                                                questionId: widget.questionsModel.id.toString(),
                                                file:_image == null ? null : File(_image!.path.toString())
                                            );
                                            updateOrInsertHESQ(model,model2);
                                            setState(() {});
                                          }

                                          print("lemmnhfhg>${checkListadd.length}");
                                        },
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily:
                                          MyString.PlusJakartaSansregular,
                                          color: myColors.black,
                                        ),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "",
                                            hintStyle: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: myColors.black,
                                                fontFamily:
                                                MyString.PlusJakartaSansregular,),
                                            counter: Offstage(),
                                            isDense: true,
                                            // this will remove the default content padding
                                            contentPadding:
                                            EdgeInsets.fromLTRB(8, 8, 8, 0)),
                                        maxLines: 2,
                                        cursorColor: myColors.black,
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              width: 75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                    child: CustomText.CustomMediumText(
                                        "upload Image",
                                        myColors.app_theme,
                                        FontWeight.w400,
                                        10,
                                        1,
                                        TextAlign.center),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showImagePickerOptionsDialog(context);
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: myColors.grey_bar1,
                                      ),
                                      child: Container(
                                          child: Center(
                                              child:  _image == null
                                                  ?   imgurl.isNotEmpty ||  imgurl.toString() != "null" || imgurl != "" ?
                                             // Image.network(imgurl)
                                              CachedNetworkImage(
                                                height: 20,
                                                width: 20,
                                                fit: BoxFit.cover,
                                                imageUrl:  imgurl.toString(),
                                                progressIndicatorBuilder:
                                                    (context, url, downloadProgress) =>
                                                    Image.asset(
                                                      "assets/images/img_gallery_theme.png",
                                                      height: 100,
                                                      width: 35,
                                                      fit: BoxFit.cover,
                                                    ),
                                                // // placeholder: (context, url) => Image.asset("assets/images/placeholder_img.png"),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset(
                                                      "assets/images/img_gallery_theme.png",
                                                      fit: BoxFit.cover,
                                                      height: 100,
                                                      width: 35,
                                                    ),
                                              )
                                                  :
                                              Image.asset(
                                                "assets/images/img_camera_grey.png",
                                                width: 20,
                                                height: 18,
                                              )
                                                  : ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                                child: Image.file(
                                                  File(_image!.path),
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,
                                                ),
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

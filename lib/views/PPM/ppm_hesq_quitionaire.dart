import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/HSEQ_Model.dart';
import 'package:fm_pro/services/webservices.dart';

import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';

class HESQ_Model {
  String? questionId;
  int? taskLogId;
  bool? isCheckListItem;
  int? linkId;
  int? answerId;
  String? comments;
  String? imageUrl;
  String? file;

  HESQ_Model(
      {this.questionId,
        this.taskLogId,
        this.isCheckListItem,
        this.linkId,
        this.answerId,
        this.comments,
        this.imageUrl,
        this.file});

  HESQ_Model.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    taskLogId = json['taskLogId'];
    isCheckListItem = json['isCheckListItem'];
    linkId = json['linkId'];
    answerId = json['answerId'];
    comments = json['comments'];
    imageUrl = json['imageUrl'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['taskLogId'] = this.taskLogId;
    data['isCheckListItem'] = this.isCheckListItem;
    data['linkId'] = this.linkId;
    data['answerId'] = this.answerId;
    data['comments'] = this.comments;
    data['imageUrl'] = this.imageUrl;
    data['file'] = this.file;
    return data;
  }
}

// class HESQ_Model {
//   String comment;
//   int tasklogId;
//   int answerId;
//   int linkId;
//   String imgurl;
//   bool isCheckListItem;
//
//   HESQ_Model(this.comment,this.tasklogId,this.answerId,this.linkId,this.imgurl,this.isCheckListItem);
// }
//List<HESQ_Model> hesqList = [];

class PPM_HESQ_Quitionaire_Screen extends StatefulWidget {
  String taskId;
  Function onCallback;
  HseqListItems hseqlist;
  Function Oncallback;
  String title;
  String questionanswer;

  PPM_HESQ_Quitionaire_Screen(
      {Key? key,
        required this.taskId,
        required this.onCallback,
        required this.hseqlist,
        required this.Oncallback,
      required this.title,
      required this.questionanswer,
      })
      : super(key: key);

  @override
  _PPM_HESQ_Quitionaire_ScreenState createState() =>
      _PPM_HESQ_Quitionaire_ScreenState();
}

class _PPM_HESQ_Quitionaire_ScreenState
    extends State<PPM_HESQ_Quitionaire_Screen> {
  @override
  void initState() {
    questionanserlist.clear();
    setState(() {});
    // updatetaskApi();
    //  hesqList = [
    //    HESQ_Model("Check the electrical terminals"),
    //    HESQ_Model("Check the electrical terminals"),
    //    HESQ_Model("Check the electrical terminals"),
    //    HESQ_Model("Check the electrical terminals"),
    //    HESQ_Model("Check the electrical terminals"),
    //    HESQ_Model("Check the electrical terminals"),
    //    HESQ_Model("Check the electrical terminals"),
    //    HESQ_Model("Check the electrical terminals"),
    //
    //  ];
    super.initState();
    updatetaskApi();
    setState(() {});
  }

  updatetaskApi() async {
    print("widget.taskId${widget.taskId}");
    print("widget.taskId${widget.hseqlist.questions!.length}");
    if (widget.taskId == "") {
      Fluttertoast.showToast(msg: "Please select taskId");
    } else {
      await Webservices.RequestUpdateWorkOrders(context, false, widget.taskId,widget.title == "Soft Services PM W/O" ? "schedule" :"");
    }
    setState(() {});
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
                              this.widget.onCallback();
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
                                    MyString.HSEQ_Quitionaire,
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
                        margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.hseqlist.questions!.length,
                            itemBuilder: (context, int index) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child:
                                  //  questioui(index,widget.hseqlist.first.questions![index].id.toString(),widget.hseqlist.first.questions![index], widget.hseqlist.first,int.parse(widget.taskId.toString()),),
                                  HESQ_List(
                                    index: index,
                                    questionsModel:
                                    widget.hseqlist.questions![index],
                                    HseqModel: widget.hseqlist,
                                    tasklogId: int.parse(widget.taskId.toString()),
                                  ),
                                ),
                              );
                            })),
                    InkWell(
                      onTap: () {
                        HseqApi();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: myColors.app_theme,
                        ),
                        child: CustomText.CustomBoldText(
                            MyString.FINISH,
                            myColors.white,
                            FontWeight.w700,
                            14,
                            1,
                            TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
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
        ));
  }

  bool is_true = false;
  HseqApi() async {
    String json = jsonEncode(questionanserlist);
    if(questionanserlist.isEmpty || widget.hseqlist.questions!.isEmpty){
      Fluttertoast.showToast(msg: "Please select answer");
    }
    else {
      if (questionanserlist.length.toString() != widget.hseqlist.questions!.length.toString()) {
        Fluttertoast.showToast(msg: "Please select All questions answer");
      }
      else {
        for (int j = 0; j < questionanserlist.length; j++) {
          if (questionanserlist[j].answerId
              .toString()
              .isEmpty || questionanserlist[j].answerId.toString() == "null" ||
              questionanserlist[j].answerId.toString() == "") {
            Fluttertoast.showToast(msg: "Please select answer");
          } else {
            setState(() {
              is_true = true;
            });
            await Webservices.RequestAddPPMHseqlistApi(
                context, true, questionanserlist, widget.Oncallback,widget.title == "Soft Services PM W/O" ? "schedule" : "");
            setState(() {
              is_true = false;
            });


          }
        }
      }
    }
  }
/*  HseqApi() async {
    String json = jsonEncode(questionanserlist);
    print("jsonresponse>>${json}");
    if(is_true == false){
      if(questionanserlist.isEmpty || widget.hseqlist.questions!.isEmpty){
        Fluttertoast.showToast(msg: "Please select answer");
      }
      else {

        for (int i = 0; i < widget.hseqlist.questions!.length; i++) {
          if (questionanserlist.length.toString() != widget.hseqlist.questions!.length.toString()) {
            Fluttertoast.showToast(msg: "Please select All questions answer");
          }
          else {
            for (int j = 0; j < questionanserlist.length; j++) {
              // if (questionanserlist[j].questionId.toString() == widget.hseqlist.questions![i].id.toString()) {
              //   Fluttertoast.showToast(msg: "Please select All questions answer");
              // }
              if (questionanserlist[i].answerId
                  .toString()
                  .isEmpty || questionanserlist[i].answerId.toString() == "null" ||
                  questionanserlist[i].answerId.toString() == "") {
                Fluttertoast.showToast(msg: "Please select answer");
              } else {
                is_true = true;
                break;
              }
            }
          }
        }
      }
    }else{
      print("widget.title${widget.title}");
      await Webservices.RequestAddPPMHseqlistApi(
          context, true, questionanserlist, widget.Oncallback,widget.title == "Soft Services PM W/O" ? "schedule" : "");
      // await Webservices.RequeSaveTaskQuestion(
      //     context, true, questionanserlist, widget.Oncallback);
    }

  }*/

  bool is_yes = true;
  bool is_no = false;
  String answerId = "";
  String answerid = "";
  bool isCheckListItem = false;
  int linkId = 0;
  String cirrentindex = "";

  // List<HESQ_Model> questionanserlist = [];
  TextEditingController controller = TextEditingController();

  questioui(int index2, String questionId, Questions questionsModel,
      HseqListItems HseqModel, int tasklogId) {
    return Container(
      //height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: CustomText.CustomMediumText("${index2 + 1}.",
                    myColors.grey_33, FontWeight.w400, 12, 1, TextAlign.start),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 6),
                  child: CustomText.CustomMediumText(
                      "${questionsModel.questionName}",
                      myColors.grey_33,
                      FontWeight.w400,
                      12,
                      3,
                      TextAlign.start),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: CustomText.CustomSemiBoldText(MyString.Comments,
                myColors.grey_28, FontWeight.w400, 12, 1, TextAlign.center),
          ),
          //   SizedBox(height: 30,)
          ///Comments.......................................................
          Container(
            // height: 95,
            margin: EdgeInsets.fromLTRB(10, 16, 10, 16),
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: myColors.grey_29),
              color: myColors.bg_bottom,
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              onChanged: (String value) {
                print("TAG" + value);
                // if(answerId == "" || answerId == "null"){
                //   Fluttertoast.showToast(msg: "Please select answer");
                // }else{
                //   HESQ_Model model =  HESQ_Model(controller.text,widget.tasklogId,int.parse(answerId),linkId,"",isCheckListItem);
                //   questionanserlist.add(model);
                //   setState(() {});
                // }

                print("lemmnhfhg>${questionanserlist.length}");
              },
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily:  MyString.PlusJakartaSansregular,
                color: myColors.grey_28,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: MyString.Ente_your_comments,
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: myColors.grey_28,
                    fontFamily:  MyString.PlusJakartaSansregular,),
                counter: Offstage(),
                isDense: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              maxLines: 3,
              cursorColor: myColors.grey_28,
            ),
          ),

          HseqModel.answers!.isEmpty
              ? Container()
              : Container(
            padding: EdgeInsets.fromLTRB(10, 9, 10, 0),
            child: Row(
                children: List.generate(HseqModel.answers!.length,
                        (answersindex) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            is_yes = true;
                            is_no = false;
                            cirrentindex = questionsModel.id.toString();
                            setState(() {});
                            answerId = HseqModel.answers![answersindex].answerId.toString();
                            if(answersindex.toString() == "0"){
                              answerid = "1";
                            }if(answersindex.toString() == "1"){
                              answerid = "2";
                            }if(answersindex.toString() == "2"){
                              answerid = "3";
                            }
                            setState(() {});

                            if (controller.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Please enter comment");
                            } else {
                              HESQ_Model model = HESQ_Model(
                                  comments: controller.text,
                                  taskLogId: int.parse(widget.taskId),
                                  answerId: int.parse(answerid.toString()),
                                  linkId: linkId,
                                  imageUrl: "",
                                  isCheckListItem: isCheckListItem);
                              questionanserlist.add(model);
                              setState(() {});
                            }
                            print("hjhjfg>${questionanserlist[0].comments}");
                            setState(() {});
                            HESQ_Model model = HESQ_Model(
                                comments: controller.text,
                                taskLogId: int.parse(widget.taskId),
                                answerId: int.parse(answerid.toString()),
                                linkId: linkId,
                                imageUrl: "",
                                isCheckListItem: isCheckListItem);

                            // HESQ_Model model =  HESQ_Model(controller.text,tasklogId,int.parse(answerId),linkId,"",isCheckListItem);
                            questionanserlist.add(model);
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            height: 26,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: answerId ==
                                  HseqModel.answers![answersindex].answerId
                                      .toString()
                                  ? myColors.app_theme
                                  : myColors.grey_bar1,
                            ),
                            child: CustomText.CustomMediumText(
                                HseqModel.answers![answersindex].answerName
                                    .toString(),
                                questionId ==
                                    widget.hseqlist.questions![index2].id
                                        .toString() &&
                                    answerId ==
                                        HseqModel
                                            .answers![answersindex].answerId
                                            .toString()
                                    ? myColors.white
                                    : myColors.black,
                                FontWeight.w600,
                                12,
                                1,
                                TextAlign.center),
                          ),
                        ),
                      );
                    }).toList()),
          ),
          SizedBox(
            height: 9,
          )
        ],
      ),
    );
  }
}


List<HESQ_Model> questionanserlist = [];

///List HESQ................................................................................................................................................................................................
class HESQ_List extends StatefulWidget {
  int index;
  Questions questionsModel;
  HseqListItems HseqModel;
  int tasklogId;

  HESQ_List(
      {Key? key,
        required this.index,
        required this.questionsModel,
        required this.HseqModel,
        required this.tasklogId})
      : super(key: key);

  @override
  _HESQ_ListState createState() => _HESQ_ListState();
}

class _HESQ_ListState extends State<HESQ_List> {
  bool is_yes = true;
  bool is_no = false;
  String answerId = "";
  String answerid = "";
  bool isCheckListItem = false;
  int linkId = 0;

  // int? answerId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("fkkk>${widget.tasklogId}");
  }

  void updateOrInsertHESQ(HESQ_Model newItem) {
    int existingIndex = questionanserlist
        .indexWhere((item) => item.questionId == newItem.questionId);
    if (existingIndex != -1) {
      questionanserlist[existingIndex] = newItem; // Update existing item
    } else {
      questionanserlist.add(newItem); // Insert new item
    }
    String json = jsonEncode(questionanserlist);
    print("jsonresponse55>>${json}");
  }

  TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();
  List<TextEditingController> textfieldCntl = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: CustomText.CustomMediumText("${widget.index + 1}.",
                    myColors.grey_33, FontWeight.w400, 12, 1, TextAlign.start),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 6),
                  child: CustomText.CustomMediumText(
                      "${widget.questionsModel.questionName}",
                      myColors.grey_33,
                      FontWeight.w400,
                      12,
                      3,
                      TextAlign.start),
                ),
              ),
            ],
          ),

          widget.HseqModel.answers.toString() == "null" ? Container() :  widget.HseqModel.answers!.isEmpty
              ? Container()
              : Container(
            padding: EdgeInsets.fromLTRB(10, 9, 10, 0),
            child: Row(
                children: List.generate(widget.HseqModel.answers!.length,
                        (answerindex) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            is_yes = true;
                            is_no = false;
                            print("widget.HseqModel.answers![index].answerId.toString()>>${widget.HseqModel.answers![answerindex].answerId.toString()}");
                            answerId = widget.HseqModel.answers![answerindex].answerId.toString();
                            if(answerindex.toString() == "0"){
                              answerid = "1";
                              setState(() {});
                            }else if(answerindex.toString() == "1"){
                              answerid = "2";
                              setState(() {});
                            }else if(answerindex.toString() == "2"){
                              answerid = "3";
                              setState(() {});
                            }
                            setState(() {});
                            HESQ_Model model = HESQ_Model(
                                questionId: widget.questionsModel.id.toString(),
                                comments: controller.text,
                                taskLogId: int.parse(widget.tasklogId.toString()),
                                answerId: int.parse(answerid),
                                linkId:  int.parse(widget.questionsModel.id.toString()),
                                imageUrl: "",
                                isCheckListItem: isCheckListItem);

                            updateOrInsertHESQ(model);
                            //questionanserlist.add(model);
                            setState(() {});
                            // }
                            print("hjhjfg>${questionanserlist[0].comments}");
                            print("hjhjfg>${questionanserlist.length}");
                            setState(() {});
                            // HESQ_Model model =  HESQ_Model(comments:controller.text,taskLogId:int.parse(widget.tasklogId.toString()),answerId:int.parse(answerId.toString()),linkId:linkId,imageUrl:"",isCheckListItem:isCheckListItem);

                            //    HESQ_Model model =  HESQ_Model(controller.text,widget.tasklogId,int.parse(answerId),linkId,"",isCheckListItem);
                            // questionanserlist.add(model);
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            height: 26,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              color: answerId ==
                                  widget.HseqModel.answers![answerindex].answerId
                                      .toString()
                                  ? myColors.app_theme
                                  : myColors.grey_bar1,
                            ),
                            child: CustomText.CustomMediumText(
                                widget.HseqModel.answers![answerindex].answerName
                                    .toString(),
                                answerId ==
                                    widget.HseqModel.answers![answerindex].answerId
                                        .toString()
                                    ? myColors.white
                                    : myColors.black,
                                FontWeight.w600,
                                12,
                                1,
                                TextAlign.center),
                          ),
                        ),
                      );
                    }).toList()),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: CustomText.CustomSemiBoldText(MyString.Comments,
                myColors.grey_28, FontWeight.w400, 12, 1, TextAlign.center),
          ),
          //   SizedBox(height: 30,)
          ///Comments.......................................................
          Container(
            // height: 95,
            margin: EdgeInsets.fromLTRB(10, 16, 10, 16),
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: myColors.grey_29),
              color: myColors.bg_bottom,
            ),
            child: TextField(
              focusNode: focusNode,
              // enabled: answerId == "" || answerId == "null" ? false: true,
              onTap: (){
                if (answerId == "" || answerId == "null") {
                  Fluttertoast.showToast(msg: "Please select answer");
                }else{

                }
              },
              controller: controller,
              keyboardType: TextInputType.multiline,
              onChanged: (String value) {
                print("TAG" + answerId);

                if (answerId == "" || answerId == "null") {
                  controller.clear();
                  setState(() {

                  });
                  Fluttertoast.showToast(msg: "Please select answer");
                } else {
                  HESQ_Model model = HESQ_Model(
                      questionId: widget.questionsModel.id.toString(),
                      comments: controller.text,
                      taskLogId: int.parse(widget.tasklogId.toString()),
                      answerId: int.parse(answerid.toString()),
                      linkId:  int.parse(widget.questionsModel.id.toString()),
                      imageUrl: "",
                      isCheckListItem: isCheckListItem);
                  updateOrInsertHESQ(model);
                  // questionanserlist.add(model);
                  setState(() {});
                }

                print("lemmnhfhg>${questionanserlist.length}");
              },
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily:  MyString.PlusJakartaSansregular,
                color: myColors.grey_28,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: MyString.Ente_your_comments,
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: myColors.grey_28,
                    fontFamily:  MyString.PlusJakartaSansregular,),
                counter: Offstage(),
                isDense: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              ),
              maxLines: 3,
              cursorColor: myColors.grey_28,
            ),
          ),
          SizedBox(
            height: 9,
          )
        ],
      ),
    );
  }
}



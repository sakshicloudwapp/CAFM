import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/global/sizedbox.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/model/models/TaskInfoModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/views/PPM/ppm_documents_screen.dart';
import 'package:fm_pro/views/PPM/ppm_images_screen.dart';
import 'package:fm_pro/views/PPM/ppm_mr_view_screen.dart';
import 'package:fm_pro/views/PPM/ppm_new_workorder_screen.dart';
import 'package:fm_pro/views/PPM/wo_detail_screen.dart';
import 'package:fm_pro/widgets/customNavigator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/models/GetResourceModel.dart';
import '../utils/customLoader.dart';
import '../views/PPM/ppm_checklist_screen.dart';
import '../views/PPM/ppm_evaluation_screen.dart';
import '../views/PPM/ppm_meter_reading_screen.dart';
import '../views/PPM/ppm_resources_screen.dart';
import '../views/PPM/ppm_summary_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CustomDrawerScreen extends StatefulWidget {
  String title, taskLogId, serviceId, loaction,projectID;
  Function OnCallback;

  CustomDrawerScreen(
      {super.key,
        required this.title,
        required this.taskLogId,
        required this.serviceId,
        required this.loaction,
        required this.projectID,
        required this.OnCallback,
      });

  @override
  State<CustomDrawerScreen> createState() => _CustomDrawerScreenState();
}

class _CustomDrawerScreenState extends State<CustomDrawerScreen> {
  List<TaskInfoModel> taskModel = [];
  TaskLogInfo? taskloginfolist;
  List<Locations>? locations = [];
  List<Categories> categorylist = [];
  List<FaultCodes> faultcodelist = [];
  List<SubTaskStatuses> subtask_statuslist = [];
  List<TaskStatuses> task_statuslist = [];
  List<Priorities> prioritylist = [];
  List<Locs> loclist = [];
  List<TaskResourcesModel> taskResourceslist = [];
  List<HseqListItems> hseqlist = [];
  List<CheckListItems> checklist = [];
  List<ChecklistQuestionAnswers> checkquestionAnswerlist = [];
  List<Questions> questionslist = [];
  List<OnHoldReasons>? onHoldReasons = [];

  List<ResourcesModel> resourceslist = [];
  List<Data> masterResourceslist = [];
  List<ImagesDetailModel> imageslist = [];



  String compleated_date = "";

  String categoryName = "";
  String faultcodeName = "";
  String faultcodeId = "";
  String categoryId = "";
  String serviceType = "";
  String subTaskStatusId = "";
  String priorityId = "";
  String subTaskStatusName = "";
  String priorityName = "";
  String locName = "";
  String locId = "";
  String start_date = "";
  String finish_date = "";
  String ProjectId = "";
  String reasonId = "";
  String containDate = "";


  String questionanswer = "";
  String checklist_questionanswer = "";
  String resourceId = "";
  String task_statusID = "";
  String title = "";

  String menuId = "";

  String feedBackComment = "";
  String finishDate = "";

  SharedPreferences? p;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTitle();
    Future.delayed(Duration.zero, () {
      getApi(false);
      additionolinfo();
    });
  }

  setTitle() async{
    p = await SharedPreferences.getInstance();
    menuId =  p!.getString("menu_ID").toString();
    setState(() {});
    if (menuId == "1") {
      title = "PPM W/O";
    } else if (menuId == "3") {
      title = "Corrective W/O";
    }
    else if (menuId == "2") {
      title = "Reactive W/O";
    }else if (menuId == "3") {
      title = "Soft Services PM W/O";
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Container(
      width: data.size.width * 0.98,
      decoration: BoxDecoration(
        color: myColors.white,
      ),
      child: Column(
        children: [
          hsized70,
          Container(
            padding: EdgeInsets.only(left: 8, right: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        MyString.UPDATES,
                        style: TextStyle(
                            color: myColors.black,
                            fontSize: 15,
                            fontFamily: "PlusJakartaSansBold"),
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    CustomNavigator.popNavigate(context);
                  },
                  child: Container(
                      child: Icon(
                        CupertinoIcons.clear_circled,
                        color: myColors.app_theme,
                        size: 30,
                      )),
                )
              ],
            ),
          ),

          hsized30,
          ListView.builder(
              itemCount: updates_list.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () {
                    print(
                        "updates_list[index].title>${updates_list[index].title}");

                    ///Resources...........................................
                    if (updates_list[index].title == "Resources") {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: PPM_Resources_Screen(
                          taskResourceslist: taskResourceslist,
                          taskModel: taskModel,
                          resourcesModel: resourceslist,
                          masterResourceslist: masterResourceslist,
                          title: widget.title,
                          appbartitle: widget.title ==
                              "Soft Services PM W/O" ? "schedule" : "",
                          taskLogId: widget.taskLogId,
                          serviceId: widget.serviceId.toString(),),
                        withNavBar: false,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                        PageTransitionAnimation.fade,
                      );
                      setState(() {});
                    }

                    ///Evaluation...........................................
                    else  if (updates_list[index].title == "Evaluation") {
                      Navigator.pop(context);
                      print("object");
                      // print(
                      //  "feedbackComment.toString()>>${feedbackComment
                      //         .toString()}");
                      //  if (feedbackComment.toString() == "null") {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: PPM_Evaluation_Screen(
                          TasklogId: widget.taskLogId.toString(),
                          oncallback: widget.OnCallback, feedBackComment: feedBackComment.toString(),),
                        withNavBar: false,
                        // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                        PageTransitionAnimation.fade,
                      );
                    } ///Summary...........................................
                    else if (updates_list[index].title == "Summary") {
                      // print("resourcesModel>${widget.resourceslist.length}");
                      // print("resourcesModelid>${resourceId}");
                      CustomNavigator.pushNavigate(
                        context,
                        PPM_Summary_Screen(
                          taskResourceslist: taskResourceslist,
                          resourcesModel: resourceslist,
                          taskModel: taskModel,
                          onCallback: widget.OnCallback,
                          tasklogId: widget.taskLogId,
                          title: widget.title,
                          appbartitle: widget.title, finishedDate: finishDate.toString(),
                        ),
                      );
                      setState(() {});
                    }
                    ///Checklist...........................................
                    else if (updates_list[index].title ==
                        MyString.Checklist) {
                      print("hjbhdj${start_date.toString()}");
                      if (checklist_questionanswer.toString() != "null") {
                        Fluttertoast.showToast(
                            msg: "CheckListItem Already submit");
                      } else
                      if (start_date.toString() == "null" || start_date
                          .toString()
                          .isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please first start date");
                      }
                      else {
                        print("checklist${checklist.length}");
                        print(
                            "checklist.first.questions!>>${checklist.first
                                .questions}");

                        checklist.isEmpty ||
                            checklist.toString() == "null"
                            ? null
                            : PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: PPM_Checklist_Screen(
                            taskId: widget
                                .taskLogId,
                            onCallback: widget.OnCallback,
                            checkListItems: checklist[0],
                            //  Oncallback: OnCallback,
                            categoryName: categoryName == "null" ||
                                categoryName.isEmpty ? "" : categoryName,
                            title: taskloginfolist!.title.toString() ==
                                "null" || taskloginfolist!.title!.isEmpty
                                ? ""
                                : taskloginfolist!.title.toString(),
                            isquestionanswer: checklist_questionanswer,
                            checkquestionAnswerlist: checkquestionAnswerlist,
                            screent_title: title,
                            appbartitle: widget.title ==
                                "Soft Services PM W/O" ? "schedule" : "",
                          ),
                          withNavBar: false,
                          // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                          PageTransitionAnimation.fade,
                        );
                      }

                      setState(() {});
                    }


                    ///Document...........................................
                    else if (updates_list[index].title == "Documents") {
                      CustomNavigator.pushNavigate(
                        context,
                        PPM_Documents_Screen(
                          tasklogId: widget.taskLogId,
                          title: widget.title,
                          appbartitle:
                          widget.title == "Soft Services PM W/O"
                              ? "schedule"
                              : "", finishDate: finishDate.toString(),
                        ),
                      );
                      setState(() {});
                    }

                    ///Images...........................................
                    else if (updates_list[index].title == "Images") {
                      CustomNavigator.pushNavigate(
                        context,
                        PPM_Images_Screen(
                            task_logId: widget.taskLogId,
                            title: widget.title,
                            appbartitle:
                            widget.title == "Soft Services PM W/O"
                                ? "schedule"
                                : "", finishDate: finishDate.toString(),),
                      );
                      setState(() {});
                    }

                    ///New MR...........................................
                    else if (updates_list[index].title == "New MR") {
                      print("fgh");
                      CustomNavigator.pushNavigate(
                          context,
                          PPM_MR_View(
                            title: widget.title,
                            taskLogId: widget.taskLogId,
                            taskTypeId: widget.serviceId,
                            oncallback: widget.OnCallback,
                            projectId:widget.projectID,
                          ));
                      setState(() {});
                    }

                    ///Meter Readings...........................................
                    else if (updates_list[index].title == "Meter Readngs") {
                      CustomNavigator.pushNavigate(
                          context, PPM_Meter_Reading_Screen());
                      setState(() {});
                    }

                    ///New Workorder...........................................
                    else if (updates_list[index].title == "New W/O") {
                      CustomNavigator.pushNavigate(
                          context,
                          PPM_New_Workorder_Screen(
                              title: widget.title,
                              appbartitle:
                              widget.title == "Soft Services PM W/O"
                                  ? "schedule"
                                  : "",
                              assetcode: taskModel
                                  .first.taskLogInfo!.assetCode
                                  .toString(),
                              ServiceId: "3",
                              ppmId: taskloginfolist != null
                                  ? "${taskloginfolist!.securityInfoId}"
                                  : "",
                              parentId: taskloginfolist != null
                                  ? int.parse(
                                  taskloginfolist!.id.toString())
                                  : 0));
                      setState(() {});
                    }
                    else {

                    }
                    setState(() {});


                  },
                  child: Container(
                    child: widgetlistitem(
                        updates_list[index].title.toString(),
                        updates_list[index].image.toString()),
                  ),
                );
              }),
        ],
      ),
    );
  }

  getApi(bool load) async {
    print("fgjf");
    taskModel.clear();
    setState(() {

    });
    await Webservices.RequestGettaskinfodetail(
        context, taskModel, load, widget.taskLogId, widget.serviceId,widget.projectID,true,widget.title == "Soft Services PM W/O" ? "schedule" : "");
    if (taskModel.isEmpty) {} else {
      print("tettet");
      taskloginfolist = taskModel.isNotEmpty ?taskModel.first.taskLogInfo : null;
      categorylist = taskModel.first.configuration!.categories == null ? [] : taskModel.first.configuration!.categories!;
      faultcodelist = taskModel.first.configuration!.faultCodes == null ? [] : taskModel.first.configuration!.faultCodes!;
      subtask_statuslist = taskModel.first.configuration!.subTaskStatuses == null ? [] : taskModel.first.configuration!.subTaskStatuses!;
      prioritylist =taskModel.first.configuration!.priorities == null ? [] : taskModel.first.configuration!.priorities!;
      loclist = taskModel.first.configuration!.locs == null ? [] : taskModel.first.configuration!.locs!;
      onHoldReasons = taskModel.first.configuration!.onHoldReasons!;
      task_statuslist = taskModel.first.configuration!.taskStatuses!;
      categoryId = taskModel.first.taskLogInfo!.categoryId.toString();
      faultcodeId = taskModel.first.taskLogInfo!.faultCodeId.toString();
      subTaskStatusId = taskModel.first.taskLogInfo!.statusId.toString();
      priorityId = taskModel.first.taskLogInfo!.priorityId.toString();
      locId = taskModel.first.taskLogInfo!.locId.toString();
      reasonId =
      taskModel.first.taskLogInfo!.onHoldReasonId == null ? "" : taskModel.first
          .taskLogInfo!.onHoldReasonId.toString();
      feedBackComment = taskModel.first.taskLogInfo!.feedbackComments.toString();
    //  finishDate = taskModel.first.taskLogInfo!.
      setState(() {});


      /// check priority  ......
      for (int i = 0; i < prioritylist.length; i++) {
        print("priorityName>>${prioritylist[i].id.toString()}");
        if (priorityId == prioritylist[i].id.toString()) {
          priorityName = prioritylist[i].name.toString();
          break;
        }
      }

      /// check category.....
      for (int i = 0; i < categorylist.length; i++) {
        print("categorylist[i].id.toString()>>${categorylist[i].id.toString()}");
        print("categorylist[i].name.toString()>>${categorylist[i].name.toString()}");
        if (categoryId.toString() == categorylist[i].id.toString()) {
          categoryName = categorylist[i].name.toString();
          break;
        }
      }

      /// check faultcode
      for (int i = 0; i < faultcodelist.length; i++) {
        if (faultcodeId == faultcodelist[i].id.toString()) {
          faultcodeName = faultcodelist[i].name.toString();
          break;
        }
      }

      /// check subtask ......
      for (int i = 0; i < subtask_statuslist.length; i++) {
        if (subTaskStatusId == subtask_statuslist[i].id.toString()) {
          subTaskStatusName = subtask_statuslist[i].name.toString();
          break;
        }
      }




      /// check LocList  ......
      for (int i = 0; i < loclist.length; i++) {
        print("priorityName>>${loclist[i].name.toString()}");
        if (locId == loclist[i].id.toString()) {
          locName = loclist[i].name.toString();
          break;
        }
      }
    }
    print("taskloginfolist>>${taskloginfolist!.title}");
    print("taskModel>>${taskModel.length}");
    print("locName>>${locName}");
    print("task_statusName>>${taskModel.first.taskLogInfo!.locations}");



    locations = taskModel.first.taskLogInfo == null ? [] : taskModel.first.taskLogInfo!.locations == null ? null : taskModel.first.taskLogInfo!.locations;
    widget.loaction =locations == null ? widget.loaction: locations!.isEmpty ? widget.loaction : locations!.first.floorName.toString() +" | " +locations!.first.unitName.toString()+" | "+locations!.first.roomName.toString();


    setState(() {});
  }


  additionolinfo() async {
    taskResourceslist.clear();
    hseqlist.clear();
    checkquestionAnswerlist.clear();
    checklist.clear();
    setState(() {});
    Future.delayed(Duration.zero, () async {

      await RequestAdditionolInfo(
          context, true, widget.taskLogId.toString(),widget.title == "Soft Services PM W/O"?"schedule":"");
      setState(() {});
    });
    if (hseqlist.isEmpty) {} else {
      // questionanswer =  hseqlist.first.questionAnswers.toString();
      print("nbnn>>${questionanswer}");
      questionslist = hseqlist.first.questions!;
      setState(() {});
    }
    if (taskResourceslist.isEmpty) {}
    else {
      resourceId = taskResourceslist.first.resourceId!.toString();
      task_statusID = taskResourceslist.first.workStatusId!.toString();

      setState(() {});

      /// check Task Statuses ......
      for (int i = 0; i < task_statuslist.length; i++) {
        if (subTaskStatusId == task_statuslist[i].id.toString()) {
          // task_statusName = task_statuslist[i].name.toString();
          break;
        }
      }
    }


    if (resourceId.isEmpty) {} else {
      getResorce();
      setState(() {});
    }
    //  updatetaskApi(taskId2,location);
  }

  getResorce() async {
    resourceslist.clear();
    await Webservices.RequestGetResource(context, resourceId, resourceslist);
    setState(() {});
  }

  /// Accept Reject ........
//   Future<void> RequestAdditionolInfo(BuildContext context,
//       bool load,
//       String taskLogId,
//       String status
//       ) async {
//     SharedPreferences p = await SharedPreferences.getInstance();
//     CustomLoader.showAlertDialog(context, true);
//     print("timezone${p.getString("timezone")}");
//     print("task_log_additionol_info url ${status =="schedule"?
//     main_base_url + AllApiServices.scheduleapi+ AllApiServices.task_log_additionol_info +
//         taskLogId.toString():
//     main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.task_log_additionol_info +
//         taskLogId.toString()}");
//     print("AllApiServices.update_work_orders+taskid${AllApiServices
//         .task_log_additionol_info + taskLogId.toString()}");
//     try {
//       final response = await http.get(Uri.parse(
//
//           status =="schedule"?
//           main_base_url + AllApiServices.scheduleapi+ AllApiServices.task_log_additionol_info +
//               taskLogId.toString():
//           main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.task_log_additionol_info +
//               taskLogId.toString()),
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//             'Authorization': 'Bearer ${p.getString("access_token")}'
//           });
//
//       CustomLoader.showAlertDialog(context, false);
//       Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
//
//       print("additionalInfo" + jsonResponse.toString());
//       taskResourceslist.clear();
//       if (response.statusCode == 200) {
//         var taskresources = jsonResponse['taskResources'];
//         // var masterResources = jsonResponse['masterResources']['data'];
//         var images = jsonResponse['images'];
//         print("images>>${images}");
//         // print("masterResources>>${masterResources}");
//
//         var hseq_question = jsonResponse['hseqListItems'];
//         var checklist_question = jsonResponse['checkListItems'];
//         var checklist_questionanswer2 = jsonResponse['checkListItems']['questionAnswers'];
//
//         if (taskresources != null) {
//           taskresources.forEach((e) {
//             TaskResourcesModel model = TaskResourcesModel.fromJson(e);
//             resourceId = model.resourceId.toString();
//             finishDate = model.finishedDate.toString();
//             taskResourceslist.add(model);
//           });
//
//
//         /*  if (masterResources != null) {
//             masterResources.forEach((e) {
//               Data model = Data.fromJson(e);
//               masterResourceslist.add(model);
//             });
//             print("masterResourceslist<<${masterResourceslist.length}");
//           }
// */
//           /// check finish date........
//           for (int i = 0; i < taskResourceslist.length; i++) {
//             start_date = taskResourceslist[i].startedDate.toString();
//             finish_date = taskResourceslist[i].finishedDate.toString();
//             containDate = taskResourceslist[i].containDate.toString();
//             setState(() {});
//             print("start_date>${start_date}");
//             print("printASd>${taskResourceslist[i].finishedDate}");
//
//             if (taskResourceslist[i].finishedDate.toString() != "null") {
//               compleated_date = taskResourceslist[i].finishedDate.toString();
//               break;
//             } else {
//               compleated_date = taskResourceslist[i].finishedDate.toString();
//
//               setState(() {});
//             }
//
//             print("start_date start_date>${start_date}");
//             setState(() {});
//           }
//           setState(() {});
//         }
//         else {}
//
//         CheckListItems model3 = CheckListItems.fromJson(checklist_question);
//         checklist.add(model3);
//         checklist_questionanswer = model3.questionAnswers.toString();
//
//         if (checklist_questionanswer2 == null) {
//
//         } else {
//           print("checkquestionAnswerlist>>${checklist_questionanswer2}");
//           checklist_questionanswer2.forEach((e) {
//             ChecklistQuestionAnswers model4 = ChecklistQuestionAnswers.fromJson(
//                 e);
//             checkquestionAnswerlist.add(model4);
//
//             print("checkquestionAnswerlist length>>${checkquestionAnswerlist
//                 .length}");
//           });
//           // for(int i=0; i< checklist.length; i++){
//           //   // ChecklistQuestionAnswers model4 = ChecklistQuestionAnswers.fromJson(checklist[i]);
//           //   // checkquestionAnswerlist.add(model4);
//           // }
//           setState(() {});
//         }
//         if (images != null) {
//           images.forEach((e) {
//             ImagesDetailModel model = ImagesDetailModel.fromJson(e);
//             imageslist.add(model);
//           });
//           setState(() {});
//           // imageslist
//         }
//
//         // if(hseq_question != null){
//         HseqListItems model2 = HseqListItems.fromJson(hseq_question);
//         hseqlist.add(model2);
//
//
//         questionanswer = model2.questionAnswers.toString();
//
//         setState(() {});
//         String json = jsonEncode(model2.questionAnswers);
//         print("jsonresponse55>>${json}");
//         print("djbfjgf>>${model2.questionAnswers}");
//
//
//         checklist_questionanswer = model3.questionAnswers.toString();
//         setState(() {});
//
//         ///   hseq.forEach((e){
//
//         //  });
//         print("taskresources>>${taskresources}");
//         print("checklist_questionanswer>>${checklist_questionanswer}");
//
//         print("additionalInfo  response" + response.toString());
//       } else {
//         print(response.reasonPhrase);
//         CustomLoader.showAlertDialog(context, false);
//       }
//     } catch (e) {
//       //   CustomLoader.showAlertDialog(context, false);
//       print(e);
//       throw Exception('errorr>>>>> ${e.toString()}');
//     }
//     return;
//   }
  /// Accept Reject ........
  Future<void> RequestAdditionolInfo(BuildContext context,
      bool load,
      String taskLogId,
      String status) async {
    SharedPreferences p = await SharedPreferences.getInstance();

    print("Addintion.................${ status == "schedule" ?
    main_base_url + AllApiServices.scheduleapi +
        AllApiServices.task_log_additionol_info +
        taskLogId.toString() :
    main_base_url + AllApiServices.base_name_PPmApi +
        AllApiServices.task_log_additionol_info +
        taskLogId.toString()}");
    try {
      load == true? CustomLoader.showAlertDialog(context, true) :null;
      final response = await http.get(Uri.parse(

          status == "schedule" ?
          main_base_url + AllApiServices.scheduleapi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString() :
          main_base_url + AllApiServices.base_name_PPmApi +
              AllApiServices.task_log_additionol_info +
              taskLogId.toString()),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });


      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);

      load == true?   CustomLoader.showAlertDialog(context, false) : null;
      taskResourceslist.clear();
      if (response.statusCode == 200) {

        var taskresources = jsonResponse['taskResources'];

        var masterResources = jsonResponse['taskResources'];
        var images = jsonResponse['images'];

        var hseq_question = jsonResponse['hseqListItems'];
        print("hseq_question>>${hseq_question}");
        var checklist_question = jsonResponse['checkListItems'];
        var checklist_questionanswer2 = jsonResponse['checkListItems']['questionAnswers'];


        if (taskresources != null) {
          taskresources.forEach((e) {
            TaskResourcesModel model = TaskResourcesModel.fromJson(e);
            resourceId = model.resourceId.toString();
            taskResourceslist.add(model);
          });
          setState(() {});
        }
        if (masterResources != null) {
          masterResources.forEach((e) {
            Data model = Data.fromJson(e);
            masterResourceslist.add(model);
          });
        }

        /// check finish date........
        for (int i = 0; i < taskResourceslist.length; i++) {
          start_date = taskResourceslist[i].startedDate.toString();
          finish_date = taskResourceslist[i].finishedDate.toString();
          containDate = taskResourceslist[i].containDate.toString();
          setState(() {});

          if (taskResourceslist[i].finishedDate.toString() != "null") {
            compleated_date = taskResourceslist[i].finishedDate.toString();
            break;
          } else {
            compleated_date = taskResourceslist[i].finishedDate.toString();

            setState(() {});
          }
          setState(() {});
        }
        setState(() {});


        CheckListItems model3 = CheckListItems.fromJson(checklist_question);
        checklist.add(model3);
        checklist_questionanswer = model3.questionAnswers.toString();

        /// checklist_questionanswer................
        if (checklist_questionanswer2 != null) {
          checklist_questionanswer2.forEach((e) {
            ChecklistQuestionAnswers model4 = ChecklistQuestionAnswers.fromJson(
                e);
            checkquestionAnswerlist.add(model4);
          });
          setState(() {});
        }

        /// images....................
        if (images != null) {
          images.forEach((e) {
            ImagesDetailModel model = ImagesDetailModel.fromJson(e);
            imageslist.add(model);
          });
          setState(() {});
        }
        checklist_questionanswer = model3.questionAnswers.toString();
        setState(() {});

        ///   hseq.forEach((e){

        HseqListItems model2 = HseqListItems.fromJson(hseq_question);
        hseqlist.add(model2);
        setState(() {});

        questionanswer = model2.questionAnswers.toString();
        setState(() {});
        setState(() {});
        String json = jsonEncode(model2.questionAnswers);
      }
      else {
        print(response.reasonPhrase);
        // load == true?   CustomLoader.showAlertDialog(context, false) : null;
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }


  widgetlistitem(String title, String img) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 9, bottom: 9),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                  padding: EdgeInsets.only(left: 0),
                  alignment: Alignment.centerRight,
                  width: 20,
                  height: 20,
                  child: SvgPicture.asset(
                    img,
                    height: 20,
                    width: 20,
                    color: myColors.black,
                  )),
              Container(
                padding: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                //  width: 100,
                child: Text(
                  title,
                  style: TextStyle(
                      color: myColors.black,
                      fontSize: 15,
                      fontFamily: "PlusJakartaSansBold"),
                ),
              ),
            ],
          ),

          hsized20,
        //  Container(height: 1,color: myColors.light_blue,)
        ],
      ),
    );
  }
}

/*
DottedBorder(
color: myColors.white,
borderType: BorderType.RRect,
strokeWidth: 2,
dashPattern: [5, 3],
radius: Radius.circular(50),
child: ClipRRect(
borderRadius: BorderRadius.all(Radius.circular(50)),
child: Container(
width: double.infinity,
padding: EdgeInsets.symmetric(vertical: 12),
alignment: Alignment.center,
decoration: BoxDecoration(),
child: Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
SizedBox(
width: 30,
),
Expanded(
child: Container(
padding: EdgeInsets.only(left: 0),
alignment: Alignment.centerRight,
width: 20,
height: 20,
child: SvgPicture.asset(
img,
height: 20,
width: 20,
color: myColors.white,
)),
),
Expanded(
flex: 2,
child: Container(
padding: EdgeInsets.only(left: 30),
alignment: Alignment.centerLeft,
//  width: 100,
child: Text(
title,
style: TextStyle(
color: myColors.white,
fontSize: 15,
fontFamily: "PlusJakartaSansBold"),
),
),
),
],
),
),
),
),*/

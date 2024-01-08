import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/getTaskLogDataModel.dart';
import 'package:fm_pro/model/models/resourceModel.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/views/PPM/ppm_detail_screen.dart';
import 'package:fm_pro/views/Reactive/reactive_jobs_detail_screen.dart';
import 'package:fm_pro/views/Reactive/reactive_workorders_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../global/my_string.dart';
import '../../model/reactive_job_list_model.dart';
import '../../widgets/custom_texts.dart';
import '../Reactive/accepted_jobs_screen.dart';

List<ReactiveJobListModel> reactiveJobList = [];

class PPM_Screen extends StatefulWidget {
  Function callback;
  String title;
  String serviceTypeId;
   PPM_Screen({Key? key, required this.callback,required this.title,required this.serviceTypeId}) : super(key: key);

  @override
  _PPM_ScreenState createState() => _PPM_ScreenState();
}

class _PPM_ScreenState extends State<PPM_Screen> {


  void initState() {
    super.initState();
    getapi();
  }



  //List<GetTaskLogDataResponse> gettasldatalist = [];
  List<Resources> gettasldatalist = [];
  List<Resources> activegettasldatalist = [];
  List<Resources> complete_gettasldatalist = [];
  List<Resources> Assigned_gettasldatalist = [];
  List<Resources> accepted_gettasldatalist = [];
  List<Resources> rejected_gettasldatalist = [];
  List<Resources> on_hold_gettasldatalist = [];

  String checkstatus = "";

 // List<GetTaskLogDataResponse> main_gettasldatalist = [];
  List<Resources> main_gettasldatalist = [];

  getapi() async{
    await Webservices.RequestGettask_Logdata(context, gettasldatalist, true, widget.serviceTypeId);
    setState((){});
    for(int i = 0; i < gettasldatalist.length; i++){
      if(gettasldatalist[i].status == "Complete"){
        complete_gettasldatalist.add(gettasldatalist[i]);

      }else if(gettasldatalist[i].status == "Assigned"){
        Assigned_gettasldatalist.add(gettasldatalist[i]);

      }else if(gettasldatalist[i].status == "Active"){
        activegettasldatalist.add(gettasldatalist[i]);

      }else if(gettasldatalist[i].status == "OnHold"){
        on_hold_gettasldatalist.add(gettasldatalist[i]);

      }else if(gettasldatalist[i].status == "Rejected"){
        rejected_gettasldatalist.add(gettasldatalist[i]);

      }else if(gettasldatalist[i].status == "Accepted"){
        accepted_gettasldatalist.add(gettasldatalist[i]);
      }else{

      }

      reactiveJobList = [
        ReactiveJobListModel("All",gettasldatalist.length.toString()),
        ReactiveJobListModel("Active",activegettasldatalist.length.toString()),
        ReactiveJobListModel("Assigned",Assigned_gettasldatalist.length.toString()),
        ReactiveJobListModel("Accepted",accepted_gettasldatalist.length.toString()),
        ReactiveJobListModel("Rejected",rejected_gettasldatalist.length.toString()),
        ReactiveJobListModel("On Hold",on_hold_gettasldatalist.length.toString()),
        ReactiveJobListModel("Completed",complete_gettasldatalist.length.toString()),

      ];
      setState((){});
    }
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
        data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: myColors.app_theme,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: myColors.app_theme,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,  // For iOS (dark icons)
              ),
              automaticallyImplyLeading: false,
              backgroundColor: myColors.transparent,
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
                              this.widget.callback("");
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
                                    MyString.PPM,
                                    myColors.white,
                                    FontWeight.w700,
                                    16,
                                    1,
                                    TextAlign.center)),
                            flex: 1,
                          ),
                          Container(
                            height: 60,
                            width: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34), topRight: Radius.circular(34)),
              color: myColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Reactive Jobs.......................................................................................................
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 20, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily:  MyString.PlusJakartaSansBold,
                        color: myColors.dark_grey_txt,
                      ),
                    ),
                  ),

                  //reactive jobs..................................................................................................
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: reactiveJobList.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                checkstatus = reactiveJobList[index].title.toString();
                                if(checkstatus == "All"){
                                  main_gettasldatalist = gettasldatalist;
                                }else if(checkstatus == "Active"){
                                  main_gettasldatalist = activegettasldatalist;
                                }else if(checkstatus == "Assigned"){
                                  main_gettasldatalist = Assigned_gettasldatalist;
                                }else if(checkstatus == "Accepted"){
                                  main_gettasldatalist = accepted_gettasldatalist;
                                }else if(checkstatus == "Rejected"){
                                  main_gettasldatalist = rejected_gettasldatalist;
                                }else if(checkstatus == "On Hold"){
                                  main_gettasldatalist = on_hold_gettasldatalist;
                                }else if(checkstatus == "Completed"){
                                  main_gettasldatalist = complete_gettasldatalist;
                                }
                                setState((){});
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: PPM_DetailScreen(
                                    title: reactiveJobList[index]
                                        .title
                                        .toString(), gettasldatalist: main_gettasldatalist,
                                  ),
                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.fade,
                                );
                                setState(() {});
                              },
                              child: Container(
                                child: ReactiveJobsList(
                                    index: index,
                                    title:
                                    reactiveJobList[index].title.toString(), count: reactiveJobList[index].total.toString(),),
                              ),
                            );
                          })),

                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class ReactiveJobsList extends StatefulWidget {
  int index;
  String title;
  String count;

  ReactiveJobsList({required this.index, required this.title,required this.count});

  @override
  _ReactiveJobsListState createState() => _ReactiveJobsListState();
}

class _ReactiveJobsListState extends State<ReactiveJobsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:  myColors.app_theme
        ),
        color: myColors.app_theme_light
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.index == 0
                  ? myColors.green
                  : widget.index == 1
                  ? myColors.orange
                  : widget.index == 2
                  ? myColors.app_theme
                  : widget.index == 3
                  ? myColors.red
                  : widget.index == 4
                  ? myColors.red
                  : myColors.green,
            ),
            child: Center(
              child: SvgPicture.asset(
                widget.index == 0
                    ? "assets/images/ic_all_jobs.svg"
                    : widget.index == 1
                    ?"assets/images/ic_assigned_jobs.svg"
                    : widget.index == 2
                    ? "assets/images/ic_accepted_job.svg"
                    : widget.index == 3
                    ?"assets/images/ic_rejected_jobs.svg"
                    : widget.index == 4
                    ?"assets/images/ic_hold.svg"
                    : "assets/images/ic_completed_jobs.svg",
                height: 16,
                width: 16,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: CustomText.CustomMediumText(
                        widget.title,
                        myColors.grey_one,
                        FontWeight.w500,
                        14,
                        1,
                        TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(12, 5, 0, 0),
                    child: CustomText.CustomRegularText(
                        "3:45 PM",
                        myColors.grey_two,
                        FontWeight.w400,
                        12,
                        1,
                        TextAlign.center),
                  ),
                ],
              )),
          Container(
            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: CustomText.CustomBoldTextDM(
                widget.count, myColors.black, FontWeight.w700, 16, 1, TextAlign.center),
          ),
        ],
      ),
    );
  }
}
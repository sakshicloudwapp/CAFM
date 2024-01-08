import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DocumentModel {
  String sno;
  String title;

  DocumentModel(this.sno, this.title);
}
List<DocumentModel> documentList = [];

class PPM_Documents_Screen extends StatefulWidget {
  String tasklogId;
  String title;
  String appbartitle;
  String finishDate;
  PPM_Documents_Screen({Key? key,required this.tasklogId,required this.title,required this.appbartitle,required this.finishDate}) : super(key: key);

  @override
  _PPM_Documents_ScreenState createState() => _PPM_Documents_ScreenState();
}

class _PPM_Documents_ScreenState extends State<PPM_Documents_Screen> {
  List<DocumentsDetailModel> documentlist = [];
  List<TaskResourcesModel> taskResourceslist = [];
  List<AdditionalInfoResponse> additionalInfoResponse =[];
  String resourceId = "";
  String task_statusID = "";

  final ImagePicker imagePicker = ImagePicker();
  File? _image;
  String img = "";
  String imgname = "";
  final picker = ImagePicker();

  int? docId;

  List<File> files= [];
  FilePickerResult? result;
  String finisdate = "null";

  @override
  void initState() {
    additionolinfo();
    super.initState();


  }

  additionolinfo() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    documentlist.clear();
    finisdate = widget.finishDate.toString() == "null" || widget.finishDate.toString().trim().isEmpty ?"null" : widget.finishDate.toString();
    setState(() {});
    Future.delayed(Duration.zero, () async {
      await Webservices.RequestAdditionolInfoo(this.context, true,additionalInfoResponse,widget.tasklogId.toString());
      setState(() {});
      if(additionalInfoResponse.isNotEmpty){
        taskResourceslist = additionalInfoResponse.first.taskResources == null ? [] : additionalInfoResponse.first.taskResources!;
        documentlist = additionalInfoResponse.first.documents == null ? [] : additionalInfoResponse.first.documents!;

        if (taskResourceslist.isNotEmpty) {
          resourceId = taskResourceslist.first.resourceId!.toString();
          task_statusID = taskResourceslist.first.workStatusId!.toString();
          setState(() {});
        }
      }

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
                                  "Documents",
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: CustomText.CustomSemiBoldText(MyString.Upload_Docs,
                    myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
              ),

              ///upload doc.................
              GestureDetector(
                onTap: finisdate == "null"? (){
                  selectAttachement();
                }:(){},
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    dashPattern: [4, 5],
                    color: myColors.grey_sixteen,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        alignment: Alignment.center,
                        height: 120,
                        color: myColors.grey_fifteen,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child:
                                Image.asset(
                                  "assets/images/img_download.png",
                                  height: 30,
                                  width: 22,
                                )

                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: CustomText.CustomMediumText(
                                  _image != null?  imgname  :  MyString.Upload_Documents,
                                  myColors.grey_nineteen,
                                  FontWeight.w400,
                                  14,
                                  1,
                                  TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///Submit..............................................................
             /* InkWell(
                onTap: () {
                  if(files.isNotEmpty){
                    uploadimage();
                  }else{
                    CustomToast.showToast(msg: "Please select document");
                  }
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  margin: EdgeInsets.fromLTRB(24, 16, 24, 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: myColors.app_theme,
                  ),
                  child: CustomText.CustomBoldText(MyString.SUBMIT,
                      myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
                ),
              ),*/

              ///Documents List...............................................................
              Container(
                alignment: Alignment.centerLeft,
                height: 44,
                margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: myColors.app_theme),
                  color: myColors.light_blue.withOpacity(0.40),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 90,
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
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          alignment: Alignment.centerLeft,
                          child: CustomText.CustomMediumText(
                              MyString.Details,
                              myColors.grey_twenty,
                              FontWeight.w500,
                              12,
                              1,
                              TextAlign.center),
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: CustomText.CustomMediumText(
                          MyString.Actions,
                          myColors.grey_twenty,
                          FontWeight.w500,
                          12,
                          1,
                          TextAlign.center),
                    ),
                  ],
                ),
              ),

              documentlist.isEmpty ? Container():
              Container(
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: documentlist.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: DocumentList(index: index, model: documentlist[index], oncallback:OncallBack,),
                        );
                      })),
            ],
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: finisdate  == "null"?() {
            if(files.isNotEmpty){
              uploadimage();
            }else{
              CustomToast.showToast(msg: "Please select document");
            }
            setState(() {});
          }:(){},
          child: Container(
            alignment: Alignment.center,
            height: 50,
            margin: EdgeInsets.fromLTRB(16, 0, 16, 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: myColors.app_theme,
            ),
            child: CustomText.CustomBoldText(MyString.UPDATE,
                myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
          ),
        ) ,
      ),
    );
  }


  void selectAttachement() async {
    print("dkjkgff");
    // List<File> files= [];
    files.clear();
    setState(() {});
    List<XFile> files2= [];
    result = await FilePicker.platform.pickFiles(type: FileType.any,
        allowMultiple: false
    );
    if (result == null) return;
    PlatformFile? file = result!.files.first;

    files.add(File(file.path.toString()));
    files2.add(XFile(file.path.toString()));
    // attachementimageFileList!.addAll(files2);
    _image = File(file.path.toString());
    img = _image!.path.toString();
    imgname = file.name.toString();
    // Navigator.pop(context);
    //uploadimage();
    //  image = null;
    setState(() {});
  }

  uploadimage(){
    RequestAddDocumentApi();
    setState(() {});
  }



  /// AdditionInfo Api call
  Future<void> RequestAdditionolInfo(BuildContext context,
      bool load,
      String taskLogId,
      // List<TaskResourcesModel> taskResourceslist,
      // List<HseqListItems> hseqlist
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
        //   main_base_url+AllApiServices.task_log_additionol_info+taskLogId.toString()
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
        var documents = jsonResponse['documents'];


        if (taskresources != null) {
          taskresources.forEach((e) {
            TaskResourcesModel model = TaskResourcesModel.fromJson(e);
            resourceId = model.resourceId.toString();
            taskResourceslist.add(model);
          });
          setState(() {});
        }

        if(documents != null){
          documents.forEach((e) {
            DocumentsDetailModel model = DocumentsDetailModel.fromJson(e);
            documentlist.add(model);
          });
          setState(() {});
          // imageslist
        }
        else{}
        print("additionalInfo  response" + response.toString());
      } else {
        print(response.reasonPhrase);
        CustomLoader.showAlertDialog(context, false);
      }
    } catch (e) {
      print(e);
      throw Exception('errorr>>>>> ${e.toString()}');
    }
    return;
  }


  /// Delete Document Api call...
  deleteApi(int id,String resourceurl,String extension) async{

    if(id.toString().isEmpty){
      Fluttertoast.showToast(msg: "Document Id in null");
    }else{
      await Webservices.RequestDeleteTaskLogDocuments(this.context, int.parse(widget.tasklogId.toString()), int.parse(id.toString()),resourceurl,extension);
    }
    setState(() {});
    await additionolinfo();
    setState(() {});
  }

  OncallBack(int id,String resourceurl,String extension){
    deleteApi(id,resourceurl,extension);
    setState(() {});
  }

  Future<void> RequestAddDocumentApi(
      ) async {

    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    print("AddOrUpdateTaskLogDocuments url>>${main_base_url+AllApiServices.AddOrUpdateTaskLogDocuments}");

    CustomLoader.showAlertDialog(this.context, true);

    var headers = {
      'Authorization': 'Bearer ${p.getString("access_token")}'
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(
        //  "https://0190-49-37-135-238.ngrok-free.app/api/TaskLogOperations/AddOrUpdateTaskLogDocuments"
          status == "4"?
          main_base_url+AllApiServices.scheduleapi+AllApiServices.AddOrUpdateTaskLogDocuments:
          main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.AddOrUpdateTaskLogDocuments

      ));
      for(int i =0; i < files.length; i++){
        var image = files[i].path.toString().split(".");
        var str_image = "${image[image.length-2]}";
        var tag = "${image[image.length-1]}";
        var imagename = str_image.toString().split("/");
        String savename = "${imagename[imagename.length-1]}";

        String doctype_type = "";
        String content_type = "";

        if(tag == "xlsx"){
          content_type = "vnd.openxmlformats-officedocument.spreadsheetml.sheet";
          doctype_type = "application";
        }else if(tag == "txt"){
          content_type = "plain";
          doctype_type = "text";
        }else if(tag == "pdf"){
          content_type = "pdf";
          doctype_type = "application";
        }
        else if(tag == "docx"){
          content_type = "vnd.openxmlformats-officedocument.wordprocessingml.document";
          doctype_type = "application";
        }
        else if(tag == "xls"){
          content_type = "vnd.ms-excel";
          doctype_type = "application";
        }
        else if(tag == "doc"){
          content_type = "msword";
          doctype_type = "application";
        }
        else if(tag == "png" || tag == "jpg" || tag == "jpeg" || tag == "PNG" || tag == "JPG" || tag == "JPEG" || tag == "svg" || tag == "SVG" || tag == "tiff"){
          content_type = tag;
          doctype_type = "image";
        }

        print("content_type.....${content_type}");
        print("doctype_type.....${doctype_type}");

        setState(() {});

        print("tag >>${tag}");
        request.fields.addAll({
          'documents[$i].id':'0',
          'documents[$i].taskLogId': widget.tasklogId,
          'documents[$i].fileName': savename.toString(),
          'documents[$i].attachmentType': doctype_type,
          'documents[$i].resourceUrl': '',
          'documents[$i].extension': tag,
          'documents[$i].isBeforeImage': "true"

        });

        var stream = new http.ByteStream(files[i].openRead());
        var length = await files[i].length();
        request.files.add(await http.MultipartFile('documents[$i].file',stream,length,filename:"${savename}.${tag}",
          contentType: MediaType(doctype_type,content_type),
        ));

        request.headers.addAll(headers);
      }

      Map<String, dynamic> jsonResponse;
      http.StreamedResponse response = await request.send();
      CustomLoader.showAlertDialog(this.context, false);
      if (response.statusCode == 200) {
        print("add image response>>"+await response.stream.bytesToString());

        _image = null;
        await additionolinfo();
        setState(() {});
      }
      else {
        print(response.reasonPhrase);
      }

    } on SocketException catch (e) {
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }


  DownloadCallback(String url,String extention){
    // downloadFile(url,extention);
  }
}

class DocumentList extends StatefulWidget {
  int index;
  DocumentsDetailModel model;
  Function oncallback;
  DocumentList({Key? key, required this.index,required this.model,required this.oncallback}) : super(key: key);

  @override
  _DocumentListState createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {

  bool is_loading = false;
  bool loading = false;
  bool loader = false;
  double progress =0;
  var percent;
  final Dio dio = Dio();
  Future<bool> _requestPermission(Permission permission) async {
    var permissionStatus = await permission.request();

    print("isGranted: " +
        permissionStatus.isGranted.toString() +
        " isDenied: " +
        permissionStatus.isDenied.toString() +
        " isLimited: " +
        permissionStatus.isLimited.toString() +
        " isRestricted: " +
        permissionStatus.isRestricted.toString() +
        " isPermanentlyDenied: " +
        permissionStatus.isPermanentlyDenied.toString());
    if (await permission.isGranted) {

      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  filedownloaded(String content,String extention) async{
    print("extention>>${extention}");
    print("iamge>>E${content.toString()}");
    is_loading = true;
    setState((){});
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if(statuses[Permission.storage]!.isGranted){
      final directory = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationDocumentsDirectory();
      final dirPath = '/storage/emulated/0/Download' ;
      // final dirPath = '/sdcard/FmPro' ;
      setState((){});
      print("dirPath>>>>> "+dirPath.replaceAll('/emulated/0/Android/data/com.cw.fm_pro/files', ''));
      final dirPathnew =
      Platform.isAndroid
          ?
      await new Directory(dirPath,).create(recursive: true)
          : await new Directory(directory!.path).create(recursive: true);
      print("dirPathnew>>>>> "+dirPathnew.path);
      if(directory != null){
        var rng = Random();
        for (var i = 0; i < 20; i++) {
          print(rng.nextInt(100));
        }
        String savename = extention == "pdf" ? "${rng.nextInt(100)}.pdf" : "${rng.nextInt(100)}.png";
        String savePath = dirPathnew.path+ "/$savename";
        print(savePath);
        try {
          await Dio().download(
            // APIservices.imagebaseurl+
              content,
              savePath,
              onReceiveProgress: (received, total) {
                if (total != -1) {
                  setState((){
                    progress = double.parse((received / total * 100).toStringAsFixed(0).toString());
                    progress == 100.0 ?  is_loading = false : is_loading = true;


                  });


                  print("download progresss....."+(received / total * 100).toStringAsFixed(0) + "%");
                  print("download progresss....."+progress.toString());
                  //you can build progressbar feature too
                }
              });
          print("File is saved to download folder.");
          if(progress == 100){
            showCustomDialog(this.context,popupConfirm());
            //  showCustomDialog(context,popupConfirm(myUploadslist: myUploadsdata,));
          }else{
            // showCustomDialog(context,popupFailed(myUploadslist: myUploadsdata,));
          }
        } on DioError catch (e) {
          print(e.message);
          is_loading = false;
          setState((){});
        }
      }
    }else{
      print("No permission to read and write.");
    }
  }


  sharefile(String content,String extention) async{
    var image = content.toString();
    var extention =  image.split(".");
    print("extention>>${extention}");
    var tag = extention[1];
    print("pkl>${tag}");
    setState(() {
      loader = true ;
    });
    Directory? tempDir = Platform.isAndroid
        ? await getExternalStorageDirectory() //FOR ANDROID
        : await getApplicationSupportDirectory();
    String tempPath = tempDir!.path;
    var filePath = "";
    filePath = tempPath + '/'+DateTime.now().millisecondsSinceEpoch.toString()+'_file_02.$extention';
    var response = await http.get(Uri.parse(content));
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    File file = new File(join(documentDirectory.path, '$fileName.$extention'));
    file.writeAsBytesSync(response.bodyBytes);
    print("details>>>>>>${file.path}");
    setState((){});
    share(file);


  }

  Future<void> share(File file) async {
    print("filrsnmds${file.path}");
    setState(() {
      loader = false ;
    });
    Future.delayed(Duration(seconds: 1));

    if(!kIsWeb){
      print("ios>>>");
      Share.shareFiles(['${file.path}'], text: 'Findem User');
    }else{
      print("android>>>");
      FlutterShare.shareFile(
          title: "Findem User",
          filePath: file.path,
          chooserTitle: 'share'
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 22,
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 90,
                  child: CustomText.CustomMediumText(
                      "${widget.index+1}.",
                      //  documentList[widget.index].sno,
                      myColors.grey_21,
                      FontWeight.w500,
                      12,
                      1,
                      TextAlign.center),
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      alignment: Alignment.centerLeft,
                      child: CustomText.CustomMediumText(
                          widget.model.fileName == null ? "":
                          widget.model.fileName.toString(),
                          myColors.grey_twenty,
                          FontWeight.w500,
                          12,
                          1,
                          TextAlign.center),
                    )),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap:(){
                          filedownloaded(widget.model.resourceUrl.toString(),widget.model.extension.toString());
                          setState(() {});

                        },
                        child: Container(
                          width: 26,
                          height: 22,
                          child: Center(
                              child:
                              Image.asset(
                                "assets/images/img_download_black.png",
                                height: 11,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.oncallback(widget.model.id,widget.model.resourceUrl,widget.model.extension);
                          setState(() {});
                        },
                        child: Container(
                          width: 50,
                          child: Container(
                            width: 26,
                            height: 22,
                            child: Center(
                                child: Image.asset(
                                  "assets/images/img_delete.png",
                                  height: 11,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          progress == 100 || progress == 0 ? Container() :
          Padding(
            padding: EdgeInsets.all(15.0),
            child: new LinearPercentIndicator(
              // width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 13.0,
              animationDuration: 2500,
              percent: 0.4,
              center: Text("${progress}",style: TextStyle(fontSize: 10),),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
          DottedBorder(
            dashPattern: [4,5],
            color: myColors.grey_22,
            customPath: (size) {
              return Path()
                ..moveTo(0, 20)
                ..lineTo(size.width, 20);
            },
            child: Container(),
          ),
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context,var page) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal:10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: myColors.white.withOpacity(0.01),
                ),
                height: 300,
                child: page),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        }
        else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
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
}


class popupConfirm extends StatefulWidget {

  popupConfirm({Key? key}) : super(key: key);

  @override
  State<popupConfirm> createState() => _popupConfirmState();
}

class _popupConfirmState extends State<popupConfirm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.05),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            decoration: const BoxDecoration(
                color: myColors.white,
                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(10),
                    topRight:Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))
            ),
            child:Column(
              children: [

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Download Successful",
                    style: const TextStyle(
                      fontSize:14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'assets/font/poppins_medium.ttf',
                      color: myColors.black,),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    "You have successfully downloaded",
                    style: const TextStyle(
                      fontSize:10,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'assets/font/poppins_regular.ttf',
                      color: myColors.black,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(12, 15, 12, 17),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color:myColors.app_theme,
                    ),
                    child: Text(
                      "Ok",
                      style: const TextStyle(
                        fontSize:14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'assets/font/poppins_medium.ttf',
                        color: myColors.black,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
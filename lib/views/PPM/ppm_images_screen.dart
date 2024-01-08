import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/model/models/AdditionolInfoModel.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/customToast.dart';
import 'package:fm_pro/views/PPM/ppm_documents_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/my_string.dart';
import '../../services/allApiServices.dart';
import '../../widgets/custom_texts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



List<ImageModel> imageList = [];

class PPM_Images_Screen extends StatefulWidget {
  String task_logId;
  String title;
  String appbartitle;
  String finishDate;

  PPM_Images_Screen({Key? key,required this.task_logId,required this.title,required this.appbartitle,required this.finishDate}) : super(key: key);

  @override
  _PPM_Images_ScreenState createState() => _PPM_Images_ScreenState();
}

class _PPM_Images_ScreenState extends State<PPM_Images_Screen> {
  bool is_before_image = true;
  bool is_after_image = false;
  bool isbefor_aftercheck = true;
  final ImagePicker imagePicker = ImagePicker();
  File? _image;
  List<File> imagefilelist = [];
  String img = "";
  String resourceId = "";
  String TaskLogReasonId = "";
  String task_statusID = "";
  TextEditingController controller = TextEditingController();

  List<ImagesDetailModel> imageslist = [];
  List<ImagesDetailModel> filterimageslist = [];
  List<TaskResourcesModel> taskResourceslist = [];


  @override
  void initState() {
    additionolinfo();
    imageList = [
      ImageModel(0,"File","143",false,"","","png",""),
      // ImageModel("File name.ext"),
      // ImageModel("File name.ext"),
    ];
    super.initState();
  }


  additionolinfo() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    imageslist.clear();
    filterimageslist.clear();
    setState(() {});
    Future.delayed(Duration.zero, () async {
      await RequestAdditionolInfo(
          context, true, widget.task_logId.toString());
      setState(() {});
    });
    if (taskResourceslist.isEmpty) {

    }
    else {
      resourceId = taskResourceslist.first.resourceId!.toString();
      task_statusID = taskResourceslist.first.workStatusId!.toString();

      setState(() {});

      /// check Task Statuses ......
      /*  for (int i = 0; i < task_statuslist.length; i++) {
        if (subTaskStatusId == task_statuslist[i].id.toString()) {
          // task_statusName = task_statuslist[i].name.toString();
          break;
        }
      }*/
    }
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
                                  widget.title,
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
                child: CustomText.CustomSemiBoldText(MyString.Upload_Image,
                    myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
              ),

              ///upload Image.................
              GestureDetector(
                onTap: (){
                  showImagePickerOptionsDialog(context);
                },
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
                        height: 150,
                        color: myColors.grey_fifteen,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: _image == null ?
                              Image.asset(
                                "assets/images/img_gallery.png",
                                height: 30,
                                width: 26,
                              ):
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.file(File(_image!.path.toString()), height: 95,)),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: CustomText.CustomMediumText(
                                  MyString.Upload_Images,
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

              // ///Details................................................................
              // Container(
              //   height: 40,
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
              //   padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //       color: myColors.bg_bottom,
              //       border: Border.all(color: myColors.grey_23)
              //   ),
              //   child: CustomText.CustomRegularText(
              //       MyString.details, myColors.grey_24, FontWeight.w400, 14, 1,
              //       TextAlign.center),
              // ),

              ///Before image   After Image............................................
              Container(
                margin: EdgeInsets.fromLTRB(16, 30, 16, 5),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        imageslist.clear();
                        isbefor_aftercheck = true;
                        is_before_image = true;
                        is_after_image = false;
                        setState(() {});
                        for(int i =0; i< filterimageslist.length;i++) {
                          if (filterimageslist[i].isBeforeImage == isbefor_aftercheck) {
                            imageslist.add(filterimageslist[i]);
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: isbefor_aftercheck == true?
                                Icon(Icons.radio_button_checked_outlined,color: myColors.app_theme,size: 28,):
                                Icon(Icons.radio_button_off,color: myColors.app_theme,size: 28,)

                              // Image.asset(isbefor_aftercheck == true
                              //     ? "assets/images/radio1_cheked.png"
                              //     : "assets/images/radio1_unchecked.png"),
                            ),
                            CustomText.CustomRegularText(
                                MyString.Before_Image, myColors.black,
                                FontWeight.w500, 12, 1, TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        imageslist.clear();
                        isbefor_aftercheck = false;
                        is_after_image = true;
                        is_before_image = false;
                        setState(() {});
                        for(int i =0; i< filterimageslist.length;i++) {
                          if (filterimageslist[i].isBeforeImage == isbefor_aftercheck) {
                            imageslist.add(filterimageslist[i]);
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
                        child: Row(
                          children: [
                            Container(
                                width: 25,
                                height: 25,
                                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: isbefor_aftercheck == false?
                                Icon(Icons.radio_button_checked_outlined,color: myColors.app_theme,size: 28,):
                                Icon(Icons.radio_button_off,color: myColors.app_theme,size: 28,)
                            ),
                            CustomText.CustomRegularText(
                                MyString.After_Image, myColors.black,
                                FontWeight.w500, 12, 1, TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///Doted Line..............................................................
              DottedBorder(
                dashPattern: [4, 5],
                color: myColors.grey_22,
                customPath: (size) {
                  return Path()
                    ..moveTo(0, 20)
                    ..lineTo(size.width, 20);
                },
                child: Container(),
              ),

              ///Grid Files List................................................................................................................................
              Container(
                padding: EdgeInsets.fromLTRB(16, 34, 16, 0),
                child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 16,
                    childAspectRatio: 2 / 1,
                    children: List.generate(imageslist.length, (index) {
                      return  ImageList(
                          index: index,
                          model:imageslist[index], OncallBack:OncallBack
                      );
                    })),
              ),


              SizedBox(height: 50,)


            ],
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          child:  ///Submit..............................................................
          InkWell(
            onTap: () {
              if(_image != null){
                addimages();
              }
              else {
                CustomToast.showToast(msg: "Please select image");
              }

              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 50,
              margin: EdgeInsets.fromLTRB(24, 14, 24, 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: myColors.app_theme,
              ),
              child: CustomText.CustomBoldText(MyString.SUBMIT,
                  myColors.white, FontWeight.w700, 14, 1, TextAlign.center),
            ),
          ),
        ),
      ),
    );
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
                       Navigator.pop(context);
                      pickImage(context, ImageSource.camera);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      Navigator.pop(context);
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
          imagefilelist.add(File(image!.path));
          image = null;
        });

        setState(() {});
      }


    } else if (kIsWeb) {
      var image =
      await imagePicker.pickImage(source: imageSource, imageQuality: 10);
      if (image == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _image = File(image!.path);
          imagefilelist.add(File(image!.path));
          img = _image!.path.toString();
          image = null;
        });
        Navigator.pop(context);
      }

      setState(() {});
    }

  }


  /// AdditionInfo Api call
/*  Future<void> RequestAdditionolInfo(BuildContext context,
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
        // main_base_url+AllApiServices.task_log_additionol_info+taskLogId.toString()
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
        // var taskresources = jsonResponse['taskResources'];
        var masterResources = jsonResponse['masterResources']['data'];
        var images = jsonResponse['images'];
        print("images>>${images}");
        print("masterResources>>${masterResources}");

        var hseq_question = jsonResponse['hseqListItems'];
        var checklist_question = jsonResponse['checkListItems'];
        var checklist_questionanswer2 = jsonResponse['checkListItems']['questionAnswers'];

        // if (taskresources != null) {
        //   taskresources.forEach((e) {
        //     TaskResourcesModel model = TaskResourcesModel.fromJson(e);
        //     resourceId = model.resourceId.toString();
        //     taskResourceslist.add(model);
        //   });
        //
        //   setState(() {});
        // }
        if(images != null){
          images.forEach((e) {
            ImagesDetailModel model = ImagesDetailModel.fromJson(e);
            imageslist.add(model);
          });
          setState(() {});
          // imageslist
        }
        else{}

        // print("taskresources>>${taskresources}");
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
  }*/
  /// AdditionInfo Api call
  Future<void> RequestAdditionolInfo(BuildContext context,
      bool load,
      String taskLogId,
      ) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    CustomLoader.showAlertDialog(context, true);

    try {
      final response = await http.get(Uri.parse(
          widget.appbartitle =="schedule"?
          main_base_url + AllApiServices.scheduleapi+ AllApiServices.task_log_additionol_info +
              taskLogId.toString():
          main_base_url + AllApiServices.base_name_PPmApi + AllApiServices.task_log_additionol_info +
              taskLogId.toString()
      ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${p.getString("access_token")}'
          });


      CustomLoader.showAlertDialog(context, false);
      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse........${jsonResponse}");

      if (response.statusCode == 200) {
        var images = jsonResponse['images'];

        if(images != null){
          images.forEach((e) {
            ImagesDetailModel model = ImagesDetailModel.fromJson(e);

            filterimageslist.add(model);
          });
          for(int i =0; i< filterimageslist.length;i++){
            if(filterimageslist[i].isBeforeImage == isbefor_aftercheck){
              imageslist.add(filterimageslist[i]);
            }
          }
          setState(() {});

        }
        else{}


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
      await Webservices.RequestDeleteTaskLogImages(context, int.parse(widget.task_logId.toString()), int.parse(id.toString()),resourceurl,extension);
    }
    setState(() {});
    await additionolinfo();
    setState(() {});
  }

  OncallBack(int id,String resourceurl,String extension){
    deleteApi(id,resourceurl,extension);
    setState(() {});
  }

  addimages() async{
    await Webservices.AddOrUpdateTaskLogImages(context, widget.task_logId, isbefor_aftercheck.toString(), imagefilelist);
    _image = null;
    imagefilelist.clear();
    await additionolinfo();
    setState(() {});

  }

/*  Future<void> RequestaddimageApi(
      ) async {

    SharedPreferences p = await SharedPreferences.getInstance();
    String status = p.getString("menu_ID").toString();
    print("AddOrUpdateTaskLogImages url>>${main_base_url+AllApiServices.AddOrUpdateTaskLogImages}");

    CustomLoader.showAlertDialog(context, true);

    var image = _image!.path.toString().split(".");
    var tag = image[1];
    print("tag >>${tag}");
    var rng = Random();
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
    }
    String savename = tag == "pdf" ? "${rng.nextInt(100)}.pdf" : "${rng.nextInt(100)}.png";

    print("savename>>${savename}");
    setState(() {

    });

    var headers = {
      'Authorization': 'Bearer ${p.getString("access_token")}'
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(
          status == "4"?
          main_base_url+AllApiServices.scheduleapi+AllApiServices.AddOrUpdateTaskLogImages:
          main_base_url+AllApiServices.base_name_PPmApi+AllApiServices.AddOrUpdateTaskLogImages
      ));
      request.fields.addAll({
        'images[0].id':'0',
        'images[0].taskLogId': widget.task_logId,
        'images[0].fileName': savename.toString(),
        'images[0].attachmentType': 'Img',
        'images[0].resourceUrl': '',
        'images[0].extension': tag,
        'images[0].isBeforeImage': isbefor_aftercheck.toString()
      });
      request.files.add(await http.MultipartFile.fromPath('images[0].file', _image!.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      CustomLoader.showAlertDialog(context, false);
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
      // CustomLoader.showAlertDialog(context, false);
      CustomToast.showToast(msg: e.toString());
    }
    return;
  }*/





}

///Grid Image List.......................................................................................................
class ImageList extends StatefulWidget {
  int index;
  ImagesDetailModel model;
  Function OncallBack;
  ImageList({Key? key, required this.index,required this.model,required this.OncallBack}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  TargetPlatform? platform;
  String? title;
  late bool _saveInPublicStorage;
  late String _localPath;
  final ReceivePort _port = ReceivePort();

  @override
  void initState()  {
    super.initState();

    _bindBackgroundIsolate();

    // FlutterDownloader.registerCallback(downloadCallback, step: 1);

    _saveInPublicStorage = false;

    _retryRequestPermission();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) async{
      print("data>>>${data}");
      final taskId = (data as List<dynamic>)[0] as String;
      final status = data[1] as DownloadTaskStatus;
      final progress = data[2] as int;
      print("status >>>>>"+status.toString());
      if(status==3){

      }
      else{
      }
      print(
        'Callback on UI isolate: '
            'task ($taskId) is in status ($status) and process ($progress)',
      );

    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress,) {
    print(
      'Callback on background isolate: '
          'task ($id) is in status ($status) and process ($progress)',
    );

    IsolateNameServer.lookupPortByName('downloader_send_port')?.send([id, status, progress]);
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }

    setState(() {
    });
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    if (Platform.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt! > 28) {
        return true;
      }

      final status = await Permission.storage.status;
      if (status == PermissionStatus.granted) {
        return true;
      }

      final result = await Permission.storage.request();
      return result == PermissionStatus.granted;
    }

    throw StateError('unknown platform');
  }

  Future<String?> _getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err, st) {
        print('failed to get downloads path: $err, $st');

        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _getSavedDir())!;
    final savedDir = Directory(_localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
  }
  var percent;
  bool is_loading = false;
  bool loading = false;
  double progress =0;
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
    // var image = content;
    // var extention =  image.split(".");
    print("extention>>${extention}");
    //  var tag = extention[1];
    // print("pkl>${tag}");
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
      //  var dir = await getExternalStorageDirectory();
      //await DownloadsPathProvider.downloadsDirectory;
      if(directory != null){
        var rng = Random();
        for (var i = 0; i < 20; i++) {
          print(rng.nextInt(100));
        }
        String savename = extention == "pdf" ? "${rng.nextInt(100)}.pdf" : "${rng.nextInt(100)}.png";
        String savePath = dirPathnew.path+ "/$savename";
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

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
          /*  final android = AndroidNotificationDetails('0', 'Adun Accounts',
              channelDescription: 'channel description',
              priority: Priority.high,
              importance: Importance.max,
              icon: '');
          final iOS = DarwinNotificationDetails();
          final platform = NotificationDetails(android: android, iOS: iOS);*/

          /* await flutterLocalNotificationsPlugin.show(
              0, // notification id
              savename,
              'Download complete.',
              platform);*/

          print("File is saved to download folder.");
          if(progress == 100){
            showCustomDialog(context,popupConfirm());
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


  filesave(String url,String extention) async{
    final directory = Platform.isAndroid
        ?
    Directory('/storage/emulated/0/Download')
    // Download//FOR ANDROID
    // await getDownloadsDirectory() //FOR ANDROID
        : await getApplicationDocumentsDirectory();
    final dirPath = '${directory.path}/FmPro' ;
    print("dirPath>>>>> "+dirPath);
    final dirPathnew = await new Directory(dirPath).create();
    // File file2 = File("${dirPathnew.path}/"+first_name+".png");
    // await file2.writeAsBytes(capturedImage!);
    var filePath = "";
    //await getTemporaryDirectory();
    final path ='${dirPathnew.path}';

    //         //  await GallerySaver.saveImage(path);

    filePath = path + '/'+DateTime.now().millisecondsSinceEpoch.toString()+'_file.$extention'; // file_01.tmp is dump file, can be anything
    print("path>>>${path + '/'+DateTime.now().millisecondsSinceEpoch.toString()+'_file.$extention'}");
    await Dio().download(url.toString(), filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState((){
              progress = double.parse((received / total * 100).toStringAsFixed(0).toString());
              percent = (received / total * 100).toStringAsFixed(0).toString();
              //  progress == 100.0 ?  is_loading = false : is_loading = true;


            });


            print("download progresss....."+(received / total * 100).toStringAsFixed(0) + "%");
            print("download progresss....."+percent.toString());
            //you can build progressbar feature too
          }
        });

    print("File is saved to download folder.");
    if(percent.toString() == "100.0" || percent == "100"){
      showCustomDialog(context,popupConfirm());
    }else{
    }


    Navigator.pop(context);
    Fluttertoast.showToast(msg: "File Download Successfully");



  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 75,
            child: Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: myColors.grey_bar1,
                  ),
                  child: Center(child:
                  widget.model.resourceUrl == null ?
                  Image.asset(
                    "assets/images/img_gallery_dark_grey.png", width: 32,
                    height: 22,)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.model.resourceUrl.toString(), width: 75,
                        height: 75,fit: BoxFit.cover),
                  )
                  ),
                ),
                Container(
                  height: 75,
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        margin: EdgeInsets.fromLTRB(5, 4, 0, 0),
                        child: CustomText.CustomRegularText(
                            widget.model.resourceUrl == null ?"":
                            widget.model.fileName.toString(), myColors.black,
                            FontWeight.w400, 12, 1, TextAlign.start),
                      ),
                      Container(
                        width: 80,
                        margin: EdgeInsets.fromLTRB(5, 4, 0, 0),
                        child: CustomText.CustomRegularText(
                            widget.model.isBeforeImage.toString() == "true" ? "Before Image" : "After Image", myColors.black, FontWeight.w400, 10, 1,
                            TextAlign.start),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:(){
                                filedownloaded(widget.model.resourceUrl.toString(),widget.model.extension.toString());
                              },
                              child: Container(
                                width: 26,
                                height: 22,
                                child: Center(
                                    child: Image.asset(
                                      "assets/images/img_download_black.png",
                                      height: 11,
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                widget.OncallBack(widget.model.id,widget.model.resourceUrl,widget.model.extension);
                                setState(() {});
                                //  deleteApi();
                              },
                              child: Container(
                                width: 26,
                                height: 22,
                                child: Center(
                                    child: Image.asset(
                                      "assets/images/img_delete.png",
                                      height: 11,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
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


class ImageModel {
  int? id ;
  String? title;
  String? taskLogId;
  bool? isBeforeImage;
  //file": "string",
  String? resourceUrl;
  String? fileName;
  String? extension;
  String? attachmentType;

  ImageModel(this.id,this.title,this.taskLogId,this.isBeforeImage,this.resourceUrl,this.fileName,this.extension,this.attachmentType);

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    taskLogId = json['taskLogId'];
    isBeforeImage = json['isBeforeImage'];
    resourceUrl = json['resourceUrl'];
    fileName = json['fileName'];
    extension = json['extension'];
    attachmentType = json['attachmentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['taskLogId'] = this.taskLogId;
    data['isBeforeImage'] = this.isBeforeImage;
    data['resourceUrl'] = this.resourceUrl;
    data['fileName'] = this.fileName;
    data['extension'] = this.extension;
    data['attachmentType'] = this.attachmentType;
    return data;
  }
}
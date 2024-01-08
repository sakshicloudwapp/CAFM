import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../global/my_string.dart';
import '../../widgets/custom_texts.dart';

class PPM_Signature extends StatefulWidget {
  Function OnCallBack;
   PPM_Signature({Key? key,required this.OnCallBack}) : super(key: key);

  @override
  _PPM_SignatureState createState() => _PPM_SignatureState();
}

class _PPM_SignatureState extends State<PPM_Signature> {

  // initialize the signature controller
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.green,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.red,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  String documents = "";
  Uint8List? signature;
  File? imagefile;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed ${_controller.toPngBytes()}'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  Future<String> _createFileFromString() async {
    final encodedStr = "put base64 encoded string here";
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
    await file.writeAsBytes(bytes);
    return file.path;
  }
  Future<void> exportImage(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return;
    }}

  var color = Colors.black;
  var strokeWidth = 3.0;
  final _sign = GlobalKey<_PPM_SignatureState>();

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
              statusBarBrightness: Brightness.dark,  // For iOS (dark icons)
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
                                  MyString.PPM,
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
                child: CustomText.CustomSemiBoldText(MyString.Get_Signature_Here,
                    myColors.black, FontWeight.w600, 16, 1, TextAlign.center),
              ),

              Container(
                margin:  EdgeInsets.only(top: 30.0,left: 30,right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: myColors.grey_30,
                ),
                child: Signature(
                  key: const Key('signature'),
                  controller: _controller,
                  height: 300,
                  backgroundColor: Colors.grey[300]!,
                ),
              ),


              SizedBox(height: 30,),
              Container(
                margin:  EdgeInsets.only(top: 0.0,left: 20,right: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () async{

                          final imageData = await _controller.toPngBytes();
                          if(imageData!=null){
                            final imageEncoded = base64.encode(imageData); // returns base64 string
                            documents = "data:image/jpeg;base64,"+imageEncoded;
                            print("bas64dataoutside>> "+documents);

                          }// must be called in async method


                          if(documents.isEmpty){
                            Fluttertoast.showToast(msg: 'Signature please');
                          }

                          else{

                            print("documents>>${documents}");
                            Navigator.pop(context);
                            widget.OnCallBack(documents);
                            setState(() {});
                          }

                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myColors.app_theme,
                          ),
                          child: CustomText.CustomBoldText(MyString.SUBMIT, myColors.white,
                              FontWeight.w700, 14, 1, TextAlign.center),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child:InkWell(
                        onTap: () async{
                          setState(() => _controller.clear());

                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: myColors.app_theme,
                          ),
                          child: CustomText.CustomBoldText(MyString.CLEAR, myColors.white,
                              FontWeight.w700, 14, 1, TextAlign.center),
                        ),
                      ),)

                  ],
                ),
              ),
             /* Container(
                height: 380,
                margin: EdgeInsets.fromLTRB(30, 38, 30, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: myColors.grey_30,
                ),
              ),*/
            ],
          ),
        ),

      ),
    );
  }
}

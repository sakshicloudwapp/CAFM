import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/model/models/GetMrDrtailModel.dart';
import 'package:fm_pro/widgets/custom_texts.dart';

import '../../model/models/MrItemdetailModel.dart';

class MrDetailScreen extends StatefulWidget {
  List<MrDetailItemsModel>? mrDetailItems = [];
  String mrid;
   MrDetailScreen({super.key,this.mrDetailItems,required this.mrid});

  @override
  State<MrDetailScreen> createState() => _MrDetailScreenState();
}

class _MrDetailScreenState extends State<MrDetailScreen> {

  List<String> BuildingList = [
    "Burjmann",
  ];
  List<String> locationList = [
    "Khadiya Tower",
  ];
  List<String> unitList = [
    "C-1245",
  ];
  List<String> floorList = [
    "C3",
  ];

  String? selectBuilding;
  String? selectLocationStore;
  String? selectUnit;
  String? selectFloor;

  @override
  Widget build(BuildContext context) {
    final mediaQuerryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuerryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: myColors.app_theme,
          title: Text("Meter Reading",style: TextStyle(color: myColors.white),),
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.white,),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 25,),
            /* Container(
               width: MediaQuery.of(context).size.width,
               child: Image.asset("assets/new_images/mr_readingImg.png",height: 240,fit: BoxFit.fill,),
             ),
             Container(
               margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   Text("M No -  14358",style: TextStyle(color: myColors.black,fontSize: 14,fontWeight: FontWeight.w700),),
                   SizedBox(width: 20,),
                   Image.asset("assets/new_images/barCode1_ic.png",height: 30,width: 30,),
                   Spacer(),
                   Container(
                     margin: EdgeInsets.only(right: 5),
                     padding: EdgeInsets.all(10.0),
                     decoration: BoxDecoration(
                       color: myColors.blue_container,
                       borderRadius: BorderRadius.circular(20.0)
                     ),
                     child: Text("Water Meter",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 10,color: myColors.white),),
                   )
                 ],
               ),
             ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Date",style: TextStyle(color: myColors.black,fontSize: 12,fontWeight: FontWeight.w600,fontFamily: MyString.PlusJakartaSansBold,),),
                    Spacer(),
                    Text("20 sep 2022 17:48:36",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: myColors.grey_eleven,fontFamily: MyString.PlusJakartaSansregular,),),
                  ],
                ),
              ),

              /// Building and LocationStore....................

              Container(
                padding: EdgeInsets.only(left: 20, right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(child: Buildingdropdown()
                        //Text("Building"),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(child: LocationStroredropdown()
                        //Text("Building"),
                      ),
                    ),
                  ],
                ),
              ),

              /// Unit and Floor........................

              Container(
                padding: EdgeInsets.only(left: 20, right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(child: Unitdropdown()
                        //Text("Building"),
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(child: Floordropdown()
                        //Text("Building"),
                      ),
                    ),
                  ],
                ),
              ),

              /// Previous or Current Readings........................


              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                          Text("Previous  Readings",style: TextStyle(color: myColors.black,fontSize: 10,fontWeight: FontWeight.w800,fontFamily: MyString.PlusJakartaSansBold),),
                        SizedBox(height:10),
                        Text("0000",style: TextStyle(color: myColors.app_theme,fontSize: 20,fontWeight: FontWeight.w600,fontFamily: MyString.PlusJakartaSansregular),),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: 85,
                      decoration: DottedDecoration(
                        shape: Shape.line, linePosition: LinePosition.left,color: myColors.grey_43,strokeWidth: 1.5 //remove this to get plane rectange
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text("Current  Readings",style: TextStyle(color: myColors.black,fontSize: 10,fontWeight: FontWeight.w800,fontFamily: MyString.PlusJakartaSansBold),),
                        SizedBox(height:10),
                        Text("0000",style: TextStyle(color: myColors.app_theme,fontSize: 20,fontWeight: FontWeight.w600,fontFamily: MyString.PlusJakartaSansregular),),
                      ],
                    ),
                  ],
                ),
              )*/

               ///new list............................................

              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    Text(
                      "MR Id: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: myColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        wordSpacing: 0.1,
                        fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                      ),
                    ),

                    SizedBox(width: 10,),
                    Text(
                      "${widget.mrid}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: myColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        wordSpacing: 0.1,
                        fontFamily: "assets/fonts/Poppins/Poppins-Medium.ttf",
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),

              Container(
                height: 44,
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: myColors.app_theme),
                  color: myColors.light_blue.withOpacity(0.40),
                ),
                child: Row(
                  children: [
                    ///S.Grp.....................................................
                    Expanded(
                        flex: 1,
                        child: CustomText.CustomMediumText(MyString.S_Grp, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                    ),

                    ///S.Name.....................................................
                    Expanded(
                        flex: 1,
                        child: CustomText.CustomMediumText("Description", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                    ),

                    ///Qty.....................................................
                    Expanded(
                        flex: 1,
                        child: CustomText.CustomMediumText("Req qty", myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                    ),

                    ///Unit Price.....................................................
                    // Expanded(
                    //     flex: 1,
                    //     child: CustomText.CustomMediumText(MyString.unit_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                    // ),

                    ///T Price.....................................................
                    // Expanded(
                    //     flex: 1,
                    //     child: CustomText.CustomMediumText(MyString.T_Price, myColors.grey_five, FontWeight.w700, 12, 1, TextAlign.center)
                    // ),
                  ],
                ),
              ),

              ///List................................................
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.mrDetailItems!.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 1, vertical: 12),
                            child: listviewwidget( widget.mrDetailItems![index],index),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }


  ///DropDown................

  Buildingdropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Building",
            style: TextStyle(
                fontSize: 12,
                color: myColors.black,
                fontFamily: MyString.PlusJakartaSansBold,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: SvgPicture.asset(
                    "assets/images/dropDown.svg",
                    color: myColors.black,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.yellow,
                  iconDisabledColor: Colors.grey,
                ),
                // barrierColor: MyColor.app_theme.withOpacity(0.60),
                style: TextStyle(
                    color: myColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,),
                //
                hint: Text(
                  'Burjmann',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,
                    fontWeight: FontWeight.w400,
                    color: myColors.black,
                  ),
                ),
                items: BuildingList
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: MyString.PlusJakartaSansregular,
                      fontWeight: FontWeight.w400,
                      color: myColors.grey_five,
                    ),
                  ),
                ))
                    .toList(),
                dropdownStyleData: DropdownStyleData(
                  // width: 120,

                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: myColors.white,
                  ),
                  offset: const Offset(5, 4),
                ),
                value: selectBuilding,
                onChanged: (String? value) {
                  setState(() {
                    selectBuilding = value.toString();
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LocationStroredropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location / Store",
            style: TextStyle(
                fontSize: 12,
                color: myColors.black,
                fontFamily: MyString.PlusJakartaSansBold,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: SvgPicture.asset(
                    "assets/images/dropDown.svg",
                    color: myColors.black,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.yellow,
                  iconDisabledColor: Colors.grey,
                ),
                // barrierColor: MyColor.app_theme.withOpacity(0.60),
                style: TextStyle(
                    color: myColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,),
                //
                hint: Text(
                  'Khadiya Tower',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,
                    fontWeight: FontWeight.w400,
                    color: myColors.black,
                  ),
                ),
                items: locationList
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: MyString.PlusJakartaSansregular,
                      fontWeight: FontWeight.w400,
                      color: myColors.grey_five,
                    ),
                  ),
                ))
                    .toList(),
                dropdownStyleData: DropdownStyleData(
                  // width: 120,

                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: myColors.white,
                  ),
                  offset: const Offset(5, 4),
                ),
                value: selectLocationStore,
                onChanged: (String? value) {
                  setState(() {
                    selectLocationStore = value.toString();
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Unitdropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Unit",
            style: TextStyle(
                fontSize: 12,
                color: myColors.black,
                fontFamily: MyString.PlusJakartaSansBold,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: SvgPicture.asset(
                    "assets/images/dropDown.svg",
                    color: myColors.black,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.yellow,
                  iconDisabledColor: Colors.grey,
                ),
                // barrierColor: MyColor.app_theme.withOpacity(0.60),
                style: TextStyle(
                    color: myColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,),
                //
                hint: Text(
                  'C-1245',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,
                    fontWeight: FontWeight.w400,
                    color: myColors.black,
                  ),
                ),
                items: unitList
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: MyString.PlusJakartaSansregular,
                      fontWeight: FontWeight.w400,
                      color: myColors.grey_five,
                    ),
                  ),
                ))
                    .toList(),
                dropdownStyleData: DropdownStyleData(
                  // width: 120,

                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: myColors.white,
                  ),
                  offset: const Offset(5, 4),
                ),
                value: selectUnit,
                onChanged: (String? value) {
                  setState(() {
                    selectUnit = value.toString();
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Floordropdown() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Floor",
            style: TextStyle(
                fontSize: 12,
                color: myColors.black,
                fontFamily: MyString.PlusJakartaSansBold,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.0,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: myColors.grey_38),
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(10)),
            //  margin: EdgeInsets.only(left: 25,right: 25),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: SvgPicture.asset(
                    "assets/images/dropDown.svg",
                    color: myColors.black,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.yellow,
                  iconDisabledColor: Colors.grey,
                ),
                // barrierColor: MyColor.app_theme.withOpacity(0.60),
                style: TextStyle(
                    color: myColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,),
                //
                hint: Text(
                  'C3',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: MyString.PlusJakartaSansregular,
                    fontWeight: FontWeight.w400,
                    color: myColors.black,
                  ),
                ),
                items: floorList
                    .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: MyString.PlusJakartaSansregular,
                      fontWeight: FontWeight.w400,
                      color: myColors.grey_five,
                    ),
                  ),
                ))
                    .toList(),
                dropdownStyleData: DropdownStyleData(
                  // width: 120,

                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: myColors.white,
                  ),
                  offset: const Offset(5, 4),
                ),
                value: selectFloor,
                onChanged: (String? value) {
                  setState(() {
                    selectFloor = value.toString();
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  listviewwidget(MrDetailItemsModel model,int index){
    return Container(
      child: Row(
        children: [
          ///S.Grp.....................................................
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 10,),
                  CustomText.CustomMediumText("${index+1}.", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
                ],
              )
          ),

          ///S.Name.....................................................
          Expanded(
            flex: 1,
            child:Text(
              "${model.stockName}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: myColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                wordSpacing: 0.1,
                fontFamily: MyString.PlusJakartaSansmedium,
              ),
            ),

            // CustomText.CustomMediumText("${widget.mrdetail.stockName}", myColors.black, FontWeight.w700, 12, 1, )
          ),

          ///Qty.....................................................
          Expanded(
              flex: 1,
              child: CustomText.CustomMediumText("${model.requiredQty}", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          ),

          // ///Unit Price.....................................................
          // Expanded(
          //     flex: 1,
          //     child: CustomText.CustomMediumText("1000", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          // ),
          //
          // ///T Price.....................................................
          // Expanded(
          //     flex: 1,
          //     child: CustomText.CustomMediumText("100000", myColors.black, FontWeight.w700, 12, 1, TextAlign.center)
          // ),
        ],
      ),
    );
  }

}



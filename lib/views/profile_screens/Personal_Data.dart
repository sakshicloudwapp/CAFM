import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/global/my_string.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/models/GetResourceProfile.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  List<GetResorcePRofile> getresourceprofilelist = [];
  List<ResourcesProfile>? resources = [];
  List<ResourceLanguages>? resourceLanguages = [];
  List<ResourceSkillSets> resourceSkillSets = [];
  List<ResourceTypes>? resourceTypes = [];
  List<ResourceSubTypes>? resourceSubTypes = [];
  List<Roles>? roles = [];
  List<Departments>? departments = [];
  List<Designations>? designations = [];
  List<Divisions>? divisions = [];
  List<Vendors>? vendors = [];
  List<Clients>? clients = [];
  List<Countries>? countries = [];
  List<States>? states = [];
  List<Cities>? cities = [];
  List<Accounts>? accounts = [];
  List<RoleAccesses>? roleAccesses = [];

  String name = "";
  String user_name = "";
  String user_designation = "";
  String user_img = "";
  String countryname = "";
  String statename = "";
  String cityname = "";
  String streetno = "";
  String streetname = "";
  String landmark = "";
  String zipcode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedprefences();
    gerResorceprofileApi();
  }

  gerResorceprofileApi() async {
    getresourceprofilelist.clear();
    resourceLanguages!.clear();
    resourceSkillSets.clear();
    resourceTypes!.clear();
    resourceSubTypes!.clear();
    roles!.clear();
    departments!.clear();
    designations!.clear();
    divisions!.clear();
    vendors!.clear();
    clients!.clear();
    countries!.clear();
    states!.clear();
    cities!.clear();
    accounts!.clear();
    roleAccesses!.clear();
    resources!.clear();
    setState(() {});
    await Webservices.RequestGetResourceProfile(
        context, getresourceprofilelist);
    setState(() {});
    if (getresourceprofilelist != null) {

      resourceLanguages = getresourceprofilelist.first.resourceLanguages;
      resourceSkillSets = getresourceprofilelist.first.resourceSkillSets!;
      resourceTypes = getresourceprofilelist.first.resourceTypes;
      resourceSubTypes = getresourceprofilelist.first.resourceSubTypes;
      roles = getresourceprofilelist.first.roles;
      departments = getresourceprofilelist.first.departments;
      designations = getresourceprofilelist.first.designations;
      divisions = getresourceprofilelist.first.divisions;
      vendors = getresourceprofilelist.first.vendors;
      clients = getresourceprofilelist.first.clients;
      states = getresourceprofilelist.first.states;
      countries = getresourceprofilelist.first.countries;
      cities = getresourceprofilelist.first.cities;
      accounts = getresourceprofilelist.first.accounts;
      roleAccesses = getresourceprofilelist.first.roleAccesses;
      resources = getresourceprofilelist.first.resources;


      if(resources!.isNotEmpty){
        /// Country....
        for(int i =0; i < countries!.length; i++){
          if(resources!.first.countryId.toString() == countries![i].id.toString()){
            countryname = countries![i].name.toString();
            setState(() {});
            break;
          }
        }

        /// states....
        for(int i =0; i < states!.length; i++){
          if(resources!.first.stateId.toString() == states![i].id.toString()){
            statename = states![i].name.toString();
            setState(() {});
            break;
          }
        }

        /// cities....
        for(int i =0; i < cities!.length; i++){
          if(resources!.first.cityId.toString() == cities![i].id.toString()){
            cityname = cities![i].name.toString();
            setState(() {});
            break;
          }
        }
        // /// cities....
        // for(int i =0; i < landmark!.length; i++){
        //   if(resources!.first.l.toString() == cities![i].id.toString()){
        //     cityname = cities![i].name.toString();
        //     setState(() {});
        //     break;
        //   }
        // }
        // /// cities....
        // for(int i =0; i < st!.length; i++){
        //   if(resources!.first.cityId.toString() == cities![i].id.toString()){
        //     cityname = cities![i].name.toString();
        //     setState(() {});
        //     break;
        //   }
        // }
      }

      setState(() {});

    }
  }

  SharedPreferences? pre ;
  getSharedprefences() async{
    pre = await SharedPreferences.getInstance();
    user_name = pre!.getString("user_name").toString();
    user_img = pre!.getString("user_profile").toString();
    user_designation = pre!.getString("designation").toString();
    print("username>>${user_name}");

    setState((){});
  }


  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: data,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:
                  context.isDarkMode ? myColors.app_theme : myColors.app_theme,
              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            backgroundColor: myColors.app_theme,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: myColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              MyString.personal_data,
              style: TextStyle(color: myColors.white, fontSize: 18),
            ),
          ),
        ),
        body: bodyWidget(),
      ),
    );
  }

  /// Widget body........
  bodyWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            profileimageAndname(),
            SizedBox(
              height: 10,
            ),
            // Text(
            //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            //   style: TextStyle(color: myColors.grey_twenty, fontSize: 13),
            // ),
            SizedBox(
              height: 30,
            ),
            headingtext(MyString.personal_info),
            SizedBox(
              height: 10,
            ),
            rowiconwithname("", "User Id:",
              resources!.isNotEmpty
                  ?   resources!.first.resourceUserId.toString() :"",),
            SizedBox(
              height: 8,
            ),
            rowiconwithname(
                "", "Mobile:", resources!.isNotEmpty
                ?   resources!.first.mobileCode.toString()+" "+ resources!.first.mobileNo.toString() :"",),

            SizedBox(
              height: 8,
            ),
            rowiconwithname(
              "", "Email:", resources!.isNotEmpty
                ?   resources!.first.email.toString() :"",),
            SizedBox(
              height: 30,
            ),
            headingtext(MyString.address),
            SizedBox(
              height: 10,
            ),




            rowiconwithname(
              "", "Country:", countryname),

            SizedBox(
              height: 8,
            ),
            rowiconwithname(
              "", "State:", statename),
            SizedBox(
              height: 8,
            ),
            rowiconwithname(
              "", "City:", cityname),

            SizedBox(
              height:resources!.isNotEmpty   && resources!.first.streetNo.toString() == "null" || resources!.isNotEmpty   && resources!.first.streetNo.toString() == ""? 0: 8,
            ),
            resources!.isNotEmpty   && resources!.first.streetNo.toString() == "null"  || resources!.isNotEmpty   && resources!.first.streetNo.toString() == ""? Container() :rowiconwithname(
              "", "Street No:", resources!.isNotEmpty
                ?   resources!.first.streetNo.toString() :"",),

            SizedBox(
              height: resources!.isNotEmpty   && resources!.first.streetName.toString() == "null"  || resources!.isNotEmpty   && resources!.first.streetName.toString() == ""? 0:8 ,
            ),
            resources!.isNotEmpty   && resources!.first.streetName.toString() == "null"  || resources!.isNotEmpty   && resources!.first.streetName.toString() == ""?
            Container() : rowiconwithname(
              "", "Street Name:", resources!.isNotEmpty
                ?   resources!.first.streetName.toString() :"",),
            SizedBox(
              height: resources!.isNotEmpty   && resources!.first.landMark.toString() == "null"  || resources!.isNotEmpty   && resources!.first.landMark.toString() == ""? 0: 8,
            ),
            resources!.isNotEmpty   && resources!.first.landMark.toString() == "null"  || resources!.isNotEmpty   && resources!.first.landMark.toString() == ""?
            Container() : rowiconwithname(
              "", "Landmark:", resources!.isNotEmpty
                ?   resources!.first.landMark.toString() :"",),

            // SizedBox(
            //   height: 8,
            // ),
            // rowiconwithname(
            //   "", "Zip code:", resources!.isNotEmpty
            //     ?   resources!.first.code.toString() :"",),

            SizedBox(
              height: 30,
            ),
            // headingtext(MyString.contact),
            // SizedBox(
            //   height: 10,
            // ),
            // rowiconwithname(
            //     "assets/images/contact.svg", "+971 088 505-5539-30", ""),
            // SizedBox(
            //   height: 10,
            // ),
            // rowiconwithname(
            //     "assets/images/email.svg", "loremipsum@mail.com", ""),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  profileimageAndname() {
    return Container(
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              resources!.isNotEmpty
                  ? CircleAvatar(
                      maxRadius: 50,
                      backgroundImage:
                          NetworkImage(resources!.first.imageUrl.toString()))
                  : CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                    color: myColors.white,
                    //  borderRadius: BorderRadius.circular(50),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: myColors.grey_two, spreadRadius: 0.1)
                    ]),
                child: Center(
                    child: Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                  color: myColors.grey_two,
                )),
              )
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Text(
                resources!.isNotEmpty
                    ?   resources!.first.firstName.toString() + " "+ resources!.first.lastName.toString() :"",
                style: TextStyle(
                    color: myColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }

  headingtext(String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
            color: myColors.black, fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  rowiconwithname(String icon, String titlename, String data) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SvgPicture.asset(icon),
          // SizedBox(
          //   width: 10,
          // ),
          Text(
            titlename,
            style: TextStyle(
                color: myColors.grey_33,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            data,
            style: TextStyle(
                color: myColors.grey_33,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          )),
        ],
      ),
    );
  }
}

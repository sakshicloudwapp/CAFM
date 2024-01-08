import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:fm_pro/views/tab_home_screen.dart';

import '../../global/my_string.dart';

class AnnounceMentScreen extends StatefulWidget {
  const AnnounceMentScreen({Key? key}) : super(key: key);

  @override
  State<AnnounceMentScreen> createState() => _AnnounceMentScreenState();
}

class _AnnounceMentScreenState extends State<AnnounceMentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
            context.isDarkMode ? myColors.app_theme : myColors.app_theme,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,  // For iOS (dark icons)
          ),
          automaticallyImplyLeading: false,
          backgroundColor: myColors.app_theme,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,color: myColors.white,), onPressed: () {
            Navigator.pop(context);
          },
          ),
          title: Text(MyString.announcements,style: TextStyle(color: myColors.white,fontSize: 18),),
        ),
      ),

      body: bodyWidget(),

    );
  }

  /// body Widget.........
bodyWidget(){
    return     Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  child: AnnouncementList(
                    index: index,
                  ),
                ),
              );
            }));
}

}

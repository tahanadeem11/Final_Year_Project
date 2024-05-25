import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:labquest/app/core/extensions.dart';
import 'package:labquest/app/screen/home/home.dart';
import 'package:labquest/app/screen/home/widgets/addDialog.dart';
import 'package:labquest/app/screen/report/report.dart';
import 'package:labquest/controller/homecontroller.dart';
import 'package:labquest/model/task.dart';

import '../../../../Theme/Utils/Drawer.dart';
import '../../../../Theme/color.dart';
import '../../chatGPT/ImageUploadScreen.dart';
import '../../chatGPT/ChatScreen.dart';
import '../../chatGPT/chatGPT.dart';

class Demopagestate extends StatefulWidget {
  Demopagestate({Key? key}) : super(key: key);

  @override
  State<Demopagestate> createState() => _DemopagestateState();
}

class _DemopagestateState extends State<Demopagestate> {
  var control=Get.find<Homecontroller>();

  int pageIndex = 0;

  List<Widget> pages = [
    Home(),
    Report(),
    chatGPT(),
    Container(),
  ];
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String displayName = '';
    String? photoURL = user?.photoURL;

    if (user?.email != null) {
      String email = user!.email!;
      List<String> parts = email.split("@");
      displayName = parts[0].length <= 10 ? parts[0] : parts[0].substring(0, 10) + "...";
    }
    return Scaffold(

      drawer: AppDrawer(),
      appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0, top: 20.0),
                child: Icon(Icons.list_alt_rounded, color: Colors.deepPurple, size: 35),
              ),
              if (photoURL != null)
                Padding(
                  padding: EdgeInsets.only(left: 16.0, bottom: 8.0, right: 8.0, top: 16.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(photoURL),
                    radius: 16,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 8.0, right: 16.0, top: 16.0),
                child: Text(
                  "Hello $displayName",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,),
      floatingActionButton:   FloatingActionButton(
        backgroundColor: control.deleting.value?Colors.red:Colors.deepPurple,
        onPressed:(){
          if(control.tasks.isNotEmpty){
            Get.to(()=>AddDialog(),transition: Transition.downToUp);
          }else{
            EasyLoading.showInfo("Please create your task type");
          }
        },
        child: Icon(control.deleting.value? Icons.delete:Icons.add,color: Colors.white,size: 30),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: getFooter(),


      body: getBody()
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }
  Widget getFooter() {
    List<IconData> iconItems = [
      CupertinoIcons.home,
      CupertinoIcons.creditcard,
   //   CupertinoIcons.money_dollar,
      CupertinoIcons.chat_bubble_text_fill,
    ];
    return AnimatedBottomNavigationBar(
        backgroundColor: primary,
        icons: iconItems,
        splashColor: secondary,
        activeColor: Colors.deepPurple,
        inactiveColor: black.withOpacity(0.5),
        gapLocation: GapLocation.none,
        activeIndex: pageIndex,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 0,
        iconSize: 25,
        rightCornerRadius: 0,
        elevation: 2,
        onTap: (index) {
          setTabs(index);
        });
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }


}


import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:labquest/app/core/keys.dart';
import 'package:labquest/app/screen/home/widgets/demopagestate.dart';
import 'package:labquest/main.dart';
import 'package:labquest/model/introcontent.dart';

import '../app/screen/AUthentication/login.dart';

class IntroController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pagecontroller = PageController();

  actionbutton() {
    if (currentIndex.value == contents.length - 1) {
      preferences!.setBool(DISPLAYINTRO, true);
      Get.off(()=>SignInScreen());
    }
    pagecontroller.nextPage(duration: 800.milliseconds, curve: Curves.ease);
  }

  List<IntroContent> contents = [
    IntroContent(
        imageName: "assets/taking-notes-amico.png",
        title: "Create Your Task",
        description:
            "Create your task to make sure every task you have can completed on time"),
    IntroContent(
        imageName: "assets/to-do-list-cuate.png",
        title: "Manage your Daily Task",
        description:
            "By using this application you will be able to manage your daily tasks"),
    IntroContent(
        imageName: "assets/writing-a-letter-rafiki.png",
        title: "Checklist Finished Task",
        description:
            "If you completed your task, so you can view the result you work for each day")
  ];
}

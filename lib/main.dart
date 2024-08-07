import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labquest/Quiz/classes/status_tracker_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Quiz/screens/done_screen.dart';
import 'Quiz/screens/home_page.dart';
import 'Quiz/screens/quiz_page.dart';
import 'Quiz/screens/results_page.dart';
import 'Quiz/screens/splash_screen.dart';
import 'Quiz/screens/welcome_page1.dart';
import 'app/data/services/storage/sevices.dart';
import 'app/middleware/MiddleWare.dart';
import 'app/screen/AUthentication/login.dart';
import 'app/screen/AUthentication/sign_up.dart';
import 'app/screen/chatGPT/chatGPT.dart';
import 'app/screen/home/binding.dart';
import 'app/screen/home/home.dart';
import 'app/screen/home/widgets/demopagestate.dart';
import 'app/screen/intro/intro.dart';
import 'app/screen/report/report.dart';
import 'firebase_options.dart';

SharedPreferences? preferences;
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => StoreService().init());
  runApp(MyApp());
}
StatusTrackerClass statusObject = StatusTrackerClass();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Intro(),
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
              )),
          colorScheme: ColorScheme.light().copyWith(primary: Colors.deepPurple),
          primaryColor: Colors.deepPurple,


          // ignore: prefer_const_constructors
          textTheme: TextTheme(
            displayLarge: const TextStyle(
                fontSize: 32, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black),
            displayMedium: const TextStyle(
                fontSize: 17,
                fontFamily: "Ubuntu-Regular.ttf",
                color: Colors.black54),
            displaySmall: const TextStyle(
                fontSize: 24, fontFamily: "Ubuntu-Medium.ttf", color: Colors.white),
            headlineMedium: const TextStyle(
                fontSize: 36, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black,fontWeight: FontWeight.w500),
            headlineSmall: const TextStyle(
                fontSize: 24, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w500),
            labelLarge: const TextStyle(
                fontSize: 25, fontFamily: "Ubuntu-Medium.ttf", color: Colors.deepPurple),
            titleLarge: const TextStyle(
                fontSize: 25, fontFamily: "Ubuntu-Medium.ttf", color: Colors.black,fontWeight: FontWeight.w400),
          ).apply(fontFamily: "Ubuntu")
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),

      getPages: [
        GetPage(name: '/', page: ()=> Intro(),

            middlewares: [IntroMeddleWare()]),
        GetPage(name: '/Demo', page: ()=>Demopagestate()),
        GetPage(name: '/SignInScreen', page: ()=>SignInScreen()),
        GetPage(name: '/SignUpScreen', page: ()=>SignUpScreen()),
        GetPage(name: '/Home', page: ()=>Home()),
        GetPage(name: '/Report', page: ()=>Report()),
        GetPage(name: '/chatGPT', page: ()=>chatGPT()),
      ],


    );
  }
}



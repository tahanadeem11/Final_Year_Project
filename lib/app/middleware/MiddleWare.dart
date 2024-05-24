import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labquest/app/core/keys.dart';
import 'package:labquest/main.dart';

import '../screen/home/widgets/demopagestate.dart';

class IntroMeddleWare extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route){
    if(preferences!.getBool(DISPLAYINTRO)!=Demopagestate())
    return RouteSettings(name: '/SignInScreen');
  }
}
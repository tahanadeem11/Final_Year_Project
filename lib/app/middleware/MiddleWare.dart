import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labquest/app/core/keys.dart';
import 'package:labquest/main.dart';

class IntroMeddleWare extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route){
    if(preferences!.getBool(DISPLAYINTRO)!=null)
    return RouteSettings(name: '/Demo');
    
  }
}
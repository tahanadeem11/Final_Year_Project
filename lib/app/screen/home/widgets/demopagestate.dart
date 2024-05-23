import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:labquest/app/core/extensions.dart';
import 'package:labquest/app/screen/home/home.dart';
import 'package:labquest/app/screen/home/widgets/addDialog.dart';
import 'package:labquest/app/screen/report/report.dart';
import 'package:labquest/controller/homecontroller.dart';
import 'package:labquest/model/task.dart';

import '../../chatGPT/ImageUploadScreen.dart';
import '../../chatGPT/ImageGenerator Screen.dart';
import '../../chatGPT/chatGPT.dart';

class Demopagestate extends StatelessWidget {
  Demopagestate({Key? key}) : super(key: key);
  var control=Get.find<Homecontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.0.wp,bottom: 2.0.wp,top: 5.0.wp),
              child: Icon(Icons.list_alt_rounded,color:Colors.deepPurple,size: 35,),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.0.wp,bottom: 2.0.wp,right: 4.0.wp,top: 4.0.wp),
              child: Text('Hello User',style: Theme.of(context).textTheme.headlineMedium,),
            ),
          ],),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: DragTarget<Task>(

        builder:(_,__,___){
          return  Obx(
          () =>  FloatingActionButton(
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
        );
        },
        onAccept: (Task task){
          control.deletetask(task);
          EasyLoading.showSuccess("Delete Sucess");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: 
         BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.deepPurple,
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.wp),
              child: IconButton(onPressed: (){control.changemypage(0);
              print(control);
                }, icon: Icon(Icons.list_alt_rounded,color: Colors.white,size: 30,)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0.wp),
              child: IconButton(onPressed: (){control.changemypage(1);
                print(control);

                }, icon: Icon(Icons.data_saver_off_rounded,color: Colors.white,size: 30)),
            ),

              Padding(
                padding: EdgeInsets.only(left: 10.0.wp),
                child: IconButton(onPressed: (){control.changemypage(2);
                print(control);
                  }, icon: Icon(Icons.chat,color: Colors.white,size: 30)),
              ),
          ],)
          ),
      
      body: PageView(
        controller: control.mypage,
        children: [
          Home(),
          Report(),
          chatGPT(),
        ],
      ),
    );
  }
}
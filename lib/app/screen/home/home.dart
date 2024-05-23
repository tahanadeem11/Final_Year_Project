import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:labquest/app/core/extensions.dart';
import 'package:labquest/app/screen/home/widgets/addCard.dart';
import 'package:labquest/app/screen/home/widgets/taskCard.dart';
import 'package:labquest/controller/homecontroller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Home extends GetView<Homecontroller> {
  Home({Key? key}) : super(key: key);
  var control=Get.find<Homecontroller>();
  @override
  Widget build(BuildContext context) {
    var createdTasks = control.getTotalTask();
    var completedTasks = control.getTotalDoneTask();
    var livetasks = createdTasks-completedTasks;
    var precent=(completedTasks/createdTasks *100).toStringAsFixed(0);
    return Scaffold(
      body: SafeArea(child: 
      ListView(
        children: [
          Row(
                children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.0.wp,bottom: 2.0.wp,top: 5.0.wp),
                  child: Icon(Icons.list_alt_rounded,color:Colors.deepPurple,size: 35,),
                ),
                 Padding(
                padding: EdgeInsets.only(left: 4.0.wp,bottom: 2.0.wp,right: 4.0.wp,top: 4.0.wp),
                child: Text('My List',style: Theme.of(context).textTheme.headline4,),
              ),
              ],),

          Obx((){
            var createdTasks = control.getTotalTask();
            var completedTasks = control.getTotalDoneTask();
            var livetasks = createdTasks-completedTasks;
            var precent=(completedTasks/createdTasks *100).toStringAsFixed(0);
            return Column(
              children: [

                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 4.0.wp,horizontal: 4.0.wp),
                  child: const Divider(thickness: 2,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0.wp,horizontal: 5.0.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      status(Colors.red, livetasks, 'Live Tasks', context),
                      status(Colors.green, completedTasks, 'Completed', context),
                      status(Colors.blue, createdTasks, 'Created', context)
                    ],
                  ),
                ),
                SizedBox(height:15.0.wp),
                             ],
            );
          }),

          Obx((){
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children:[...control.tasks.map((element) => LongPressDraggable(
                data: element,
                onDragStarted: ()=>control.changeDeleting(true),
                onDraggableCanceled: (_,__)=>control.changeDeleting(false),
                onDragEnd: (_)=>control.changeDeleting(false),
                feedback: Opacity(opacity: 0.8,child: TaskCard(task: element),),
                child: TaskCard(task: element))).toList(),AddCard()],

             );
          }
             
          ),
          
        ],
      )),
      
      
    );
  }

  Widget status(Color color,int number,String title,BuildContext context){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
              color: color.withOpacity(0.4),
              shape: BoxShape.circle,
              border: Border.all(
                width: 0.5.wp,
                color: color,
              )
          ),
        ),SizedBox(width: 3.0.wp,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$number",style: Theme.of(context).textTheme.headline6,),
            Text(title,style: Theme.of(context).textTheme.headline2,)

          ],
        )
      ],
    );
  }
}

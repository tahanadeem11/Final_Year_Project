import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:labquest/app/core/extensions.dart';
import 'package:labquest/controller/homecontroller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({Key? key}) : super(key: key);
  final control=Get.find<Homecontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{
          Get.back();
                    control.titlecontroller.clear();
                    control.changeTask(null);
                    return true;
        },
        child: SafeArea(
          child: Form(
            key: control.formkey,
            child: ListView(
              children: [Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                    onPressed: (){Get.back();
                    control.titlecontroller.clear();
                    control.changeTask(null);},
                    icon:const Icon(Icons.close,color: Colors.deepPurple)
                  ),
                  TextButton(
                    onPressed: (){
                      if(control.formkey.currentState!.validate()){
                        if(control.task.value==null){
                          EasyLoading.showError('Please select task type');
                        }else{
                          var success =control.updateTask(
                            control.task.value!,
                            control.titlecontroller.text,
                          );
                          if(success){
                            EasyLoading.showSuccess('To-Do item add success');
                            Get.back();
                            control.changeTask(null);
                          }else{
                            EasyLoading.showError('To-Do is already exist');
                          }
                          control.titlecontroller.clear();
                        }
                      }
                    },
                    child: Text("Done",style: Theme.of(context).textTheme.labelLarge,),
                  ),
                  ],
                  
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text("New Task",style: Theme.of(context).textTheme.headlineMedium,),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp,vertical: 5.0.wp),
                 child: TextFormField(
                          controller:control.titlecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                            labelText: 'Add To-Do',
                            labelStyle: Theme.of(context).textTheme.displayMedium,
                          ),
                          validator: (value){
                            if(value==null||value.trim().isEmpty){
                              return 'Please enter your To-Do item';
                            }
                            return null;
                          },
                        ),
               ),
               Padding(
                 padding:  EdgeInsets.all(5.0.wp),
                 child: Text("Add to",style: Theme.of(context).textTheme.displayMedium),
               ),
               ...control.tasks.map((element) => Obx(()=>
                InkWell(
                   onTap: ()=>control.changeTask(element),
                   child: Padding(
                     padding:  EdgeInsets.only(left: 5.0.wp,bottom: 3.0.wp,right: 5.0.wp,top: 3.0.wp),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(IconData(
                          element.icon,
                          fontFamily: "MaterialIcons",
                          ),
                          color: HexColor.fromHex(element.color),),
                          SizedBox(width: 3.0.wp),
                          Text(element.title,style: Theme.of(context).textTheme.headlineSmall,),
                          ],
                        ),
                          if(control.task.value==element)
                          const Icon(Icons.check,color: Colors.deepPurple,size: 30,)
                      ],
                     ),
                   ),
                 ),
               )).toList(),
              
              ],
          
            ),
          ),
        ),
      ),
    );
  }
}
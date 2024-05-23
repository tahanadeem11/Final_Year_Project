import 'package:get/get.dart';
import 'package:labquest/app/data/provideData.dart/taskProvide.dart';
import 'package:labquest/app/data/services/storage/repository.dart';
import 'package:labquest/controller/homecontroller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Homecontroller(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}

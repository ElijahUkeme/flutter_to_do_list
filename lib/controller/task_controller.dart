import 'package:flutter_to_do_list/database/database_helper.dart';
import 'package:flutter_to_do_list/model/TaskModel.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{

  @override
  void onReady() {
    super.onReady();
  }
  Future<int> addTask(TaskModel taskModel) async {
    return await DatabaseHelper.insert(taskModel);
  }
  var taskList = <TaskModel>[].obs;

  void getTask()async{
     List<Map<String, dynamic>> task = await DatabaseHelper.query();
    taskList.assignAll(task.map((data) => new TaskModel.fromJson(data)).toList());
  }

  void delete(TaskModel taskModel){
   var value = DatabaseHelper.delete(taskModel);
   getTask();
   print(value);
  }

  void markCompletedTask(int id)async{
    await DatabaseHelper.update(id);
    getTask();
  }
}
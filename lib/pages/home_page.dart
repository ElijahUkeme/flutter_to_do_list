import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_to_do_list/controller/task_controller.dart';
import 'package:flutter_to_do_list/model/TaskModel.dart';
import 'package:flutter_to_do_list/pages/add_task_page.dart';
import 'package:flutter_to_do_list/services/notification_service.dart';
import 'package:flutter_to_do_list/services/theme_services.dart';
import 'package:flutter_to_do_list/utils/themes.dart';
import 'package:flutter_to_do_list/widget/app_button.dart';
import 'package:flutter_to_do_list/widget/bottom_button.dart';
import 'package:flutter_to_do_list/widget/task_tile.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            SizedBox(height: 10,),
            _showTask()

    ],
    )
    ,
    );
  }

  _showBottomSheet(BuildContext context, TaskModel taskModel){
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: taskModel.isCompleted==1?
            MediaQuery.of(context).size.height *0.24:
        MediaQuery.of(context).size.height *0.32,
        color: Get.isDarkMode?Colors.blueGrey:Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
            Spacer(),
            taskModel.isCompleted==1?
                Container():
                BottomButton(label: "Task Completed",
                    onTap:(){
                  _taskController.markCompletedTask(taskModel.id!);
                  Get.back();
                    },
                    color: bluishColor
                ),
            BottomButton(label: "Delete Task",
                onTap:(){
              _taskController.delete(taskModel);
                  Get.back();
                },
                color: Colors.red[300]!
            ),
            BottomButton(label: "Close",
                onTap:(){
                  Get.back();
                },
                color: Colors.red[300]!,
              isClosed: true,
            ),
            SizedBox(height: 10,)
          ],
        ),
      )
    );
  }

  _addDateBar(){
    return Container(
      margin: EdgeInsets.only(left: 20,top: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: bluishColor,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.grey
        ),
        dayTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.grey
        ),
        monthTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.grey
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar(){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now())
                  , style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ),
                Text("Today",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,)
                )],
            ),
          ),
          AppButton(label: "+ Add A Task", onTap: () async {
            await Get.to(()=>AddTaskPage());
            _taskController.getTask();
            }
          )],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme"
          );
          notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          color: Get.isDarkMode ? Colors.white : Colors.grey,
          size: 20,),
      ),
      actions: [

        CircleAvatar(
          backgroundImage: AssetImage(
              "images/profile.png"
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
    _showTask() {

    return Expanded(
      child: Obx((){
        print("Inside the new widget");
        return ListView.builder(
          itemCount: _taskController.taskList.length,
            itemBuilder: (_, index){
            print("Items in the db is "+_taskController.taskList.length.toString());
            TaskModel taskModel = _taskController.taskList[index];
            //print(taskModel.toJson());
            if(taskModel.repeat=='Daily'){
              DateTime dateTime = DateFormat.jm().parse(taskModel.startTime.toString());
              var myTime = DateFormat("HH:mm").format(dateTime);
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                taskModel
              );
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                          child:Row(
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    _showBottomSheet(context, taskModel);
                                  },
                                  child: TaskTile(taskModel: taskModel,)
                              )
                            ],
                          ) )));
            }if(taskModel.date==DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                      child: FadeInAnimation(
                          child:Row(
                            children: [
                              GestureDetector(
                                  onTap: (){
                                    _showBottomSheet(context, taskModel);
                                  },
                                  child: TaskTile(taskModel: taskModel,)
                              )
                            ],
                          ) )));
            }else{
              return Container();
            }



        });
      }),
    );
  }

}

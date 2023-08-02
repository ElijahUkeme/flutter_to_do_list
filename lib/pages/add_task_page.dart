import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/controller/task_controller.dart';
import 'package:flutter_to_do_list/model/TaskModel.dart';
import 'package:flutter_to_do_list/utils/themes.dart';
import 'package:flutter_to_do_list/widget/app_button.dart';
import 'package:flutter_to_do_list/widget/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int _selectedColor =0;
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "09:10 AM";
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Task",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,)
              ),
              MyInputField(title: "Title", hint: "Enter your note title",controller: _titleController,),
              MyInputField(title: "Note", hint: "Enter your note ",controller: _noteController,),
              MyInputField(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                  onPressed: (){
                    print("Calendar");
                    _getDateFromUser();
                  },
                  icon: Icon(Icons.calendar_today_outlined),
              color: Colors.grey,),),
              Row(
                children: [
                  Expanded(
                      child:MyInputField(
                          title: "Start Time",
                          hint: _startTime,
                      widget: IconButton(onPressed: (){
                        _getTimeFromUser(isStartTime: true);
                      },
                          icon: Icon(Icons.access_time_rounded,
                          color: Colors.grey,)),) ),
                  SizedBox(width: 12,),
                  Expanded(
                      child:MyInputField(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(onPressed: (){
                          _getTimeFromUser(isStartTime: false);
                        },
                            icon: Icon(Icons.access_time_rounded,
                              color: Colors.grey,)),) )
                ],
              ),
              MyInputField(title: "Reminder", hint: "$_selectedRemind minutes early",
              widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                underline: Container(height: 0,),
                onChanged: (String? newValue){
                  setState(() {
                    _selectedRemind = int.parse(newValue!);
                  });
                },
                items:remindList.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),),
              MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:repeatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!,style: TextStyle(color: Colors.grey),),
                    );
                  }).toList(),
                ),),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  AppButton(label: "Create Task", onTap: ()=>_validateData())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _addTaskToDb() async {
   int value = await _taskController.addTask(
        TaskModel(
            title: _titleController.text,
            note: _noteController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            colour: _selectedColor,
            isCompleted: 0
        )
    );
   print("The inserted id is " +" $value");
  }

  _validateData(){
    if(_titleController.text.isEmpty){
      Get.snackbar("Error", "Please Enter the title of the note",
      snackPosition: SnackPosition.TOP,
      backgroundColor: pinkColor,
      icon: Icon(Icons.warning_amber_rounded));
    }else if(_noteController.text.isEmpty){
      Get.snackbar("Error", "Note Cannot be Empty");
    }else{
      _addTaskToDb();
      Get.back();
    }
  }

  _colorPalette(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Colour",
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
        SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index==0?bluishColor:index==1?pinkColor:yellowColor,
                      child: _selectedColor==index?Icon(Icons.done,
                        size: 16,
                        color: Colors.white,):Container(),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,
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
  
  _getDateFromUser()async{
    DateTime? _pickedDate = await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if(_pickedDate !=null){
      setState(() {
        _selectedDate = _pickedDate;
      });
    }else{
      print("The date is null");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePickerDialog();
    String _formattedTime = pickedTime.format(context);
    if(pickedTime ==null){
      print("Time cancelled");
    }else if(isStartTime==true){
      setState(() {
        _startTime = _formattedTime;
      });
    }else if(isStartTime==false){
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }
  _showTimePickerDialog(){
    return  showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}

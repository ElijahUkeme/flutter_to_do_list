import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/model/TaskModel.dart';
import 'package:flutter_to_do_list/utils/themes.dart';

class TaskTile extends StatelessWidget {
  final TaskModel? taskModel;
  TaskTile({Key? key,this.taskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBackgroundColor(taskModel?.colour??0),
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel?.title??"",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        color: Colors.white)
                    ),
                    SizedBox(height: 12,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        SizedBox(width: 4,),
                        Text(
                          "${taskModel!.startTime}  -  ${taskModel!.endTime}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100],),
                        )
                      ],
                    ),
                    SizedBox(height: 12,),
                    Text(
                      taskModel?.note??"",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[100],),
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
                quarterTurns: 3,
              child: Text(
                taskModel!.isCompleted == 1? "COMPLETED":"TODO",
                style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white)
              ),
            )
          ],
        ),
      ),
    );
  }
  _getBackgroundColor(int no){
    switch(no){
      case 0:
        return bluishColor;
      case 1:
        return pinkColor;
      case 2:
        return yellowColor;
      default:
        return bluishColor;
    }
  }
}

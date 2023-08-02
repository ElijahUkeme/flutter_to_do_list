
import 'package:sqflite/sqflite.dart';

import '../model/TaskModel.dart';

class DatabaseHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "task";

  static Future<void> initDb()async{
    if(_db !=null){
      return;
    }
    try {
      String path = await getDatabasesPath() + 'task.db';
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db,version){
          print("Creating a new database");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT, date STRING, "
                "startTime STRING, endTime STRING, "
                "repeat STRING, remind INTEGER, colour INTEGER, isCompleted INTEGER)",
          );
        }
      );
    }catch(e){
      print(e);
    }
  }
  static Future<int> insert(TaskModel? taskModel) async {
    print("insert function called");
    return await _db?.insert(_tableName, taskModel!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("querry function called");
    return await _db!.query(_tableName);
  }
  static delete(TaskModel taskModel) async {
    return await _db!.delete(_tableName,where: 'id=?',whereArgs: [taskModel.id]);
  }

  static update(int id)async{
    return await _db?.rawUpdate('''
    UPDATE task
    SET isCompleted = ?
    WHERE id = ?
    ''',[1,id]);
  }
}
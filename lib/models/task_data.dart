import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {
  late Database _database;

  Future createDB() async {
    _database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      await database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .catchError((error) {
        print(error.toString());
      });
      print('table created');
    }, onOpen: (database) {
      print('database opened');
    });

    notifyListeners();
  }

  void insertDB(
      {required String title,
      required String date,
      required String time}) async {
    await _database.transaction(
      (txn) async {
        await txn
            .rawInsert(
                'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "active")')
            .then((value) {
          print('$value inserted successfully');
        }).catchError((error) {
          print(error.toString());
        });
      },
    );
    notifyListeners();
  }
}

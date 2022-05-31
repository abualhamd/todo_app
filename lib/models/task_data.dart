import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {
  late Database _database;
  List<Map> _list = [];

  void createDB() async {
    _database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      await database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .catchError((error) {
        print(error.toString());
      });
      print('table created');
    }, onOpen: (database) async {
      _updateTasksList(db: database);
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
          // print('$value inserted successfully');
        }).catchError((error) {
          print(error.toString());
        });
      },
    );
    _updateTasksList();
    // _list = await _retriveDB(_database, 'active');
    //todo _list.add({'title':title, 'date': date, 'time': time, 'status': 'active'});
    // notifyListeners();
  }

  void updateDB(
      {required int index,
      String? newTitle,
      String? newDate,
      String? newTime}) async {
    newTitle ??= _list[index]['title'];
    newDate ??= _list[index]['date'];
    newTime ??= _list[index]['time'];
    await _database.rawUpdate(
        'UPDATE tasks SET title = ?, date = ?, time = ? WHERE id = ?',
        ['$newTitle', '$newDate', '$newTime', index]);

    _updateTasksList();
  }

  void deleteTask({required int index}) async {
    await _database.rawDelete('DELETE FROM tasks WHERE id = ?', [index]);
    _updateTasksList();
    // print(tasksData);
  }

  Future<List<Map>> _retriveDB(Database database, String status) async {
    //, String status
    return await database.rawQuery(
        'SELECT * FROM tasks  WHERE status = "$status"'); // WHERE status = "$status"
  }

  get listLength => _list.length;

  UnmodifiableListView get tasksData => UnmodifiableListView(_list);

  void _updateTasksList({Database? db}) async {
    _list = await _retriveDB(db ?? _database, 'active');
    notifyListeners();
  }
}

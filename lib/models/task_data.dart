import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';

class TaskData extends ChangeNotifier {
  int currentIndex = 0;
  late Database _database;
  List<Map> _activeList = [];
  List<Map> _doneList = [];
  List<Map> _archivedList = [];

  void setCurrentIndex({required int index}) {
    currentIndex = index;
    notifyListeners();
  }

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
      _updateActiveList(db: database);
      _updateDoneList(db: database);
      _updateArchivedList(db: database);
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
    _updateActiveList();
    // _list = await _retriveDB(_database, 'active');
    //todo _list.add({'title':title, 'date': date, 'time': time, 'status': 'active'});
    // notifyListeners();
  }

  void updateStautsDB({required String status, required int id}) async {
    await _database
        .rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]);

    _updateActiveList();
    _updateDoneList();
    _updateArchivedList();
  }

  Future<void> deleteTask({required int index}) async {
    await _database.rawDelete('DELETE FROM tasks WHERE id = ?', [index]);
    _updateActiveList();
    _updateDoneList();
    _updateArchivedList();
  }

  Future<List<Map>> _retriveDB(Database database, String status) async {
    //, String status
    return await database.rawQuery(
        'SELECT * FROM tasks  WHERE status = "$status"'); // WHERE status = "$status"
  }

  int listLength({required String taskType}) {
    switch (taskType) {
      case 'active':
        return _activeList.length;
      case 'done':
        return _doneList.length;
    }

    return _archivedList.length;
  }

  UnmodifiableListView tasksData({required String taskType}) {
    switch (taskType) {
      case 'active':
        return UnmodifiableListView(_activeList);
      case 'done':
        return UnmodifiableListView(_doneList);
    }

    return UnmodifiableListView(_archivedList);
  }

  void _updateActiveList({Database? db}) async {
    _activeList = await _retriveDB(db ?? _database, 'active');

    notifyListeners();
  }

  void _updateDoneList({Database? db}) async {
    _doneList = await _retriveDB(db ?? _database, 'done');

    notifyListeners();
  }

  void _updateArchivedList({Database? db}) async {
    _archivedList = await _retriveDB(db ?? _database, 'archived');

    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:collection/collection.dart';
import 'package:todo_app/screens/active_tasks.dart';
import 'package:todo_app/screens/done_tasks.dart';
import 'package:todo_app/screens/archived_tasks.dart';

enum Lists {
  active,
  done,
  archived,
}

class MyCubit extends Cubit<AppState> {
  MyCubit() : super(AppInitState());

  static MyCubit get(BuildContext context) => BlocProvider.of(context);
  int currentIndex = Lists.active.index;
  late Database _database;
  List<Map> _activeList = [];
  List<Map> _doneList = [];
  List<Map> _archivedList = [];

  final List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  final List<String> titles = [
    'Tasks',
    'Done',
    'Archived',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeScreenIndexState());
  }

  void createDB() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (database) {
        _updateAllLists(db: database);
      },
    ).then((value) {
      _database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void insertInDB(
      {required String title, required String date, required String time}) {
    _database.transaction(
      (txn) async {
        await txn
            .rawInsert(
                'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "active")')
            .then((value) {})
            .catchError((error) {
          print(error.toString());
        });
      },
    ).then(
      (value) {
        emit(AppInsertIntoDatabaseState());
        _updateActiveList();
      },
    );
    //todo _list.add({'title':title, 'date': date, 'time': time, 'status': 'active'});
  }

  void updateStatusDB({required String status, required int id}) {
    _database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(AppUpdateStatusState());
      _updateAllLists();
    });
  }

  void deleteTask({required int index, required Lists list}) {
    _database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [index]).then((value) {
      emit(AppDeleteTaskState());
      switch (list) {
        case Lists.active:
          _updateActiveList();
          break;
        case Lists.done:
          _retrieveDB(_database, titles[Lists.done.index].toLowerCase())
              .then((value) {
            _doneList = value;
            emit(AppUpdateAllListsState());
          });
          break;
        default:
          _retrieveDB(_database, titles[Lists.archived.index].toLowerCase())
              .then((value) {
            _archivedList = value;
            emit(AppUpdateAllListsState());
          });
          break;
      }
    });
  }

  Future<List<Map>> _retrieveDB(Database database, String status) async {
    return await database
        .rawQuery('SELECT * FROM tasks  WHERE status = "$status"');
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

  void _updateActiveList() {
    _retrieveDB(_database, 'active').then((value) {
      _activeList = value;
      emit(AppUpdateActiveListState());
    });
  }

  //TODO make sure update is working well especially after performing delete
  void _updateAllLists({Database? db}) {
    _retrieveDB(db ?? _database, 'archived')
        .then((value) {
          _archivedList = value;
        })
        .then((value) => {
              _retrieveDB(db ?? _database, 'active').then((value) {
                _activeList = value;
              })
            })
        .then((value) => {
              _retrieveDB(db ?? _database, 'done').then((value) {
                _doneList = value;
                emit(AppUpdateAllListsState());
              })
            });
  }
}

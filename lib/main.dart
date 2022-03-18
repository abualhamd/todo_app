import 'package:flutter/material.dart';
import 'package:todo_app/screens/archived.dart';
import 'package:todo_app/screens/done.dart';
import 'package:todo_app/screens/tasks.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  late Database database; // = await openDatabase('todo.db', version: 1);

  List<Widget> screens = [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  List<String> titles = [
    'Tasks',
    'Done',
    'Archived',
  ];

  @override
  initState() {
    super.initState();
    creatDB().then((value) {
      insertDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(titles[currentIndex]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded), label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outlined), label: 'Done'),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: 'Archived'),
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }

  Future creatDB() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
      print('table created');
    }, onOpen: (database) {
      print('database opened');
    });
  }

  void insertDB() async {
    await database.transaction(
      (txn) async {
        await txn.rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES(travel, 16-10-2021, active)');
        print('done successfully');
      },
    );
  }
}

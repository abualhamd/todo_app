import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Database database;

  @override
  initState() {
    super.initState();
    createDB();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Home()
    );
  }

  Future createDB() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
          ).catchError((error){
            print(error.toString());
      });
      print('table created');
    }, onOpen: (database) {
      print('database opened');
    });
  }

  void insertDB() async {
    await database.transaction(
      (txn) async {
        await txn.rawInsert(
            'INSERT INTO tasks(title, date, time, status) VALUES("good bye", "17-10-2021", "tomorrow", "active")'
        ).then((value) {
          print('$value inserted successfully');
        }).catchError((error){
          print(error.toString());
        });
      },
    );
  }
}

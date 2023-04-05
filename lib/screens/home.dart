import 'package:flutter/material.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/screens/archived.dart';
import 'package:todo_app/screens/done.dart';
import 'package:todo_app/screens/tasks.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return AddTaskScreen();
            },
          );
        },
        child: Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: Text(titles[context.watch<TaskData>().currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        elevation: 10.0,
        onTap: (index) {
          context.read<TaskData>().setCurrentIndex(index: index);
        },
        currentIndex: context.watch<TaskData>().currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outlined), label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Archived'),
        ],
      ),
      body: screens[context.watch<TaskData>().currentIndex],
    );
  }
}

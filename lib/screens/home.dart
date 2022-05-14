import 'package:flutter/material.dart';
import 'package:todo_app/screens/archived.dart';
import 'package:todo_app/screens/done.dart';
import 'package:todo_app/screens/tasks.dart';
import 'package:todo_app/screens/bottomSheet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool bottomSheetOpened = false;
  IconData bottomNavIcon = Icons.edit;

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
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // setState(() {
          //   bottomNavIcon = Icons.add;
          // });
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context)
            {
              return MyBottomSheet();
            },
          );
        },
        child: Icon(bottomNavIcon),
      ),
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
    );

  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';
import 'package:todo_app/screens/add_task_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyCubit cubit = MyCubit.get(context);

    return BlocConsumer<MyCubit, AppState>(
      listener: (context, state) {},
      builder: (BuildContext context, AppState state) {
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
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10.0,
            onTap: (index) => MyCubit.get(context).changeIndex(index),
            currentIndex: MyCubit.get(context).currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_rounded), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outlined), label: 'Done'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: 'Archived'),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components_and_decorations/components.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyCubit cubit = MyCubit.get(context);

    return BlocConsumer<MyCubit, AppState>(
      listener: (BuildContext context, AppState state) {},
      builder: (BuildContext context, AppState state) {
        return ListView.builder(
          itemCount: cubit.listLength(taskType: 'active'),
          itemBuilder: (BuildContext context, int index) {
            final Map task = cubit.tasksData(taskType: 'active')[index];
            return buildTask(
              context: context,
              width: MediaQuery.of(context).size.width,
              task: task,
              onLongPress: () => cubit.deleteTask(
                index: task['id'],
                list: Lists.active,
              ),
              //TODO add change data upon onTap
              // onTap: () {
              //   showModalBottomSheet<void>(
              //   isScrollControlled: true,
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AddTaskScreen(
              //         // initialTitle: task['title'],
              //         // initialDate: task['date'],
              //         // initialTime: task['time'],
              //       );
              //     },
              //   );
              // },
            );
          },
        );
      },
    );
  }
}


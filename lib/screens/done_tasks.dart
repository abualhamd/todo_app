import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components_and_decorations/components.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyCubit cubit = MyCubit.get(context);

    return BlocConsumer<MyCubit, AppState>(
      listener: (BuildContext context, AppState state) {},
      builder: (BuildContext context, AppState state) {
        return ListView.builder(
          itemCount: cubit.listLength(taskType: 'done'),
          itemBuilder: (BuildContext context, int index) {
            final Map task = cubit.tasksData(taskType: 'done')[index];
            return buildTask(
                context: context,
                width: MediaQuery.of(context).size.width,
                task: task,
                onLongPress: () {
                  return cubit.deleteTask(
                    index: task['id'],
                    list: Lists.done,
                  );
                });
          },
        );
      },
    );
  }
}

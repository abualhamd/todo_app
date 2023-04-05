import 'package:flutter/material.dart';
import 'package:todo_app/components.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';

class ArchivedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer<TaskData>(
    //   builder: (context, taskData, child) {
    final taskProvider = Provider.of<TaskData>(context);
    return ListView.builder(
      itemCount: taskProvider//Provider.of<TaskData>(context, listen: false)
          .listLength(taskType: 'archive'),
      itemBuilder: (BuildContext context, int index) {
        final Map task = taskProvider//Provider.of<TaskData>(context, listen: false)
            .tasksData(taskType: 'archive')[index];
        return buildTask(
            context: context,
            width: MediaQuery.of(context).size.width,
            task: task,
            onLongPress: () {
              taskProvider//Provider.of<TaskData>(context, listen: false)
              .deleteTask(
                index: task['id'],
              );
            });
      },
    );
    //   },
    // );
  }
}
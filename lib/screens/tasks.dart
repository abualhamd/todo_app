import 'package:flutter/material.dart';
import 'package:todo_app/components.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskData>(context);
    return ListView.builder(
      itemCount: taskProvider.listLength(taskType: 'active'),
      itemBuilder: (BuildContext context, int index) {
        final Map task = taskProvider.tasksData(taskType: 'active')[index];
        return buildTask(
          context: context,
          width: MediaQuery.of(context).size.width,
          task: task,
          onLongPress: () => taskProvider.deleteTask(
            index: task['id'],
          ),
        );
      },
    );
  }
}

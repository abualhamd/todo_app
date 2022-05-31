import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/components.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: Provider.of<TaskData>(context, listen: false).listLength,
          itemBuilder: (BuildContext context, int index) {
            final Map task =
                Provider.of<TaskData>(context, listen: false).tasksData[index];
            return buildTask(
              width: MediaQuery.of(context).size.width,
              task: task,
              onLongPress: () => Provider.of<TaskData>(context, listen: false)
                    .deleteTask(index: task['id']));
          },
        );
      },
    );
  }
}

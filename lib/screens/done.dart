import 'package:flutter/material.dart';
import 'package:todo_app/components.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer<TaskData>(
    //   builder: (context, taskData, child) {
      final taskProvider = Provider.of<TaskData>(context);
        return ListView.builder(
          itemCount: taskProvider//Provider.of<TaskData>(context, listen: false)
              .listLength(taskType: 'done'),
          itemBuilder: (BuildContext context, int index) {
            final Map task = taskProvider//Provider.of<TaskData>(context, listen: false)
                .tasksData(taskType: 'done')[index];
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

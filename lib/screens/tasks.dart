import 'package:flutter/material.dart';
import 'package:todo_app/components.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
// import 'add_task_screen.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer<TaskData>(
    //   builder: (context, taskProvider, child) {
    final taskProvider = Provider.of<TaskData>(context);
    return ListView.builder(
      itemCount:
          taskProvider //Provider.of<TaskData>(context, listen: false)
              .listLength(taskType: 'active'),
      itemBuilder: (BuildContext context, int index) {
        final Map task =
            taskProvider //Provider.of<TaskData>(context, listen: false)
                .tasksData(taskType: 'active')[index];
        return buildTask(
          context: context,
          width: MediaQuery.of(context).size.width,
          task: task,
          onLongPress: () =>
              taskProvider //Provider.of<TaskData>(context, listen: false)
                  .deleteTask(
            index: task['id'],
          ),
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
    //   },
    // );
  }
}

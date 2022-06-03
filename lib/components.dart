import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';

Widget buildTask({
  required double width,
  required Map task,
  required Function onLongPress,
  required BuildContext context,
}) {
  return Dismissible(
    key: Key(task['id'].toString()),
    onDismissed: (direction) {
      onLongPress();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: width / 10,
            child: Text(task['time']),
          ),
          SizedBox(
            width: width / 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(task['title']),
                Text(
                  task['date'],
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          //TODO change color of icons based on status
          IconButton(
            onPressed: () {
              Provider.of<TaskData>(context, listen: false)
                  .updateStautsDB(status: 'done', id: task['id']);
            },
            icon: Icon(Icons.check_box_outlined),
          ),
          IconButton(
            onPressed: () {
              Provider.of<TaskData>(context, listen: false)
                  .updateStautsDB(status: 'archived', id: task['id']);
            },
            icon: Icon(Icons.archive_outlined),
          ),
        ],
      ),
    ),
  );
}

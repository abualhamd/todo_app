import 'package:flutter/material.dart';

Widget buildTask(
    {required double width, required Map task, required Function onLongPress}) {
  return InkWell(
    onLongPress: () {
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
          Column(
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
          )
        ],
      ),
    ),
  );
}

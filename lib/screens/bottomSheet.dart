import 'package:flutter/material.dart';
import 'package:todo_app/decorations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/components.dart';

class MyBottomSheet extends StatefulWidget {
  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final EdgeInsetsGeometry kFormTextFieldPadding =
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0);
  final _formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) return 'field must not be empty';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // backgroundColor: Colors.lightBlueAccent,
        // backgroundBlendMode: BlendMode.modulate,
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(30), topEnd: Radius.circular(30)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: kFormTextFieldPadding,
              child: TextFormField(
                  controller: titleController,
                  decoration: kInputDecoration,
                  onChanged: (value) {
                    titleController.text = value;
                    print(titleController.text);
                  },
                  validator: validator),
            ),
            Padding(
              padding: kFormTextFieldPadding,
              child: TextFormField(
                keyboardType: TextInputType.none,
                controller: dateController,
                decoration: kInputDecoration.copyWith(
                  prefixIcon: Icon(Icons.calendar_today_rounded),
                  label: Text('date'),
                ),
                validator: validator,
                onTap: () {
                  Future.delayed(
                    Duration.zero,
                    () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.parse('2022-06-22'),
                      ).then((value) {
                        String date = DateFormat.yMMMd().format(value!);
                        print(date);
                        dateController.text = date;
                      });
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: kFormTextFieldPadding,
              child: TextFormField(
                keyboardType: TextInputType.none,
                controller: timeController,
                decoration: kInputDecoration.copyWith(
                  prefixIcon: Icon(Icons.punch_clock_rounded),
                  label: Text('time'),
                ),
                validator: validator,
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      String time = value!.format(context);
                      print(time);
                      timeController.text = time;
                    });
                  });
                },
              ),
            ),
            TextButton(
              child: Text('submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Provider.of<TaskData>(context, listen: false).insertDB(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text,
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

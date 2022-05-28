import 'package:flutter/material.dart';
import 'package:todo_app/decorations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components.dart';

class MyBottomSheet extends StatefulWidget {

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  // TextEditingController statusController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final EdgeInsetsGeometry kFormTextFieldPadding =
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0);
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      decoration: BoxDecoration(
        // backgroundColor: Colors.lightBlueAccent,
        // backgroundBlendMode: BlendMode.modulate,
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(30), topEnd: Radius.circular(30)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: kFormTextFieldPadding,
              child: TextFormField(
                controller: titleController,
                decoration: kInputDecoration,
                validator: (value) {
                  if (value!.isEmpty) return 'title must not be empty';
                  return null;
                },
              ),
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
                validator: (value) {
                  if (value!.isEmpty) return 'date must not be empty';
                  return null;
                },
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
                        String time = DateFormat.yMMMd().format(value!);
                        print(time);
                        dateController.text = time;
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
                validator: (value) {
                  if (value!.isEmpty) return 'date must not be empty';
                  return null;
                },
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
                  // if(formKey.currentState.validate())
                  if (Form.of(context)!.validate())
                    Navigator.pop(context, [
                      titleController.text,
                      dateController.text,
                      timeController.text
                    ]);
                }),
          ],
        ),
      ),
    );
  }
}

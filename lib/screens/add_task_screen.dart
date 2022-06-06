import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components_and_decorations/decorations.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';

//TODO handle the keyboard covering the title field

class AddTaskScreen extends StatefulWidget {
  // String? initialTitle;
  // String? initialDate;
  // String? initialTime;

  // AddTaskScreen({this.initialTitle, this.initialDate, this.initialTime});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //TODO add initial values for controllers for when trying to modify an existing task
  // @override
  // void initState() {
  //   super.initState();
  //   titleController.text = widget.initialTitle!;
  //   dateController.text = widget.initialDate!;
  //   timeController.text = widget.initialTime!;
  // }

  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final EdgeInsetsGeometry kFormTextFieldPadding =
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0);

  String? validator(String? value) {
    if (value == null || value.isEmpty) return 'field must not be empty';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyCubit, AppState>(
      listener: (BuildContext context, AppState state) {},
      builder: (BuildContext context, AppState state) {
        return Container(
          decoration: BoxDecoration(
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
                  //TODO fix the keyboard covering the textformfilds
                  child: TextFormField(
                    // initialValue: titleController.text,
                    controller: titleController,
                    decoration: kInputDecoration,
                    validator: validator,
                  ),
                ),
                Padding(
                  padding: kFormTextFieldPadding,
                  child: TextFormField(
                    // initialValue: widget.initialDate,
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
                            //TODO make this a month from current date
                            lastDate: DateTime.parse('2022-06-22'),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: kFormTextFieldPadding,
                  child: TextFormField(
                    // initialValue: widget.initialTime,
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
                          timeController.text = value!.format(context);
                        });
                      });
                    },
                  ),
                ),
                TextButton(
                  //TODO add style to this button
                  child: Text('submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      MyCubit.get(context).insertInDB(
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
      },
    );
  }
}

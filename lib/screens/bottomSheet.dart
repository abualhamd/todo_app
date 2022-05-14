import 'package:flutter/material.dart';
import 'package:todo_app/decorations.dart';
import 'package:todo_app/components.dart';
//hello world

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController dateController = TextEditingController();

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
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // FormField
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: TextFormField(
              //     controller: titleController,
              //     keyboardType: TextInputType.text,
              //     decoration: kInputDecoration,
              //   ),
              // ),
              FormComponent(
                  controller: titleController, decoration: kInputDecoration),
              FormComponent(
                  controller: dateController,
                  decoration: kInputDecoration.copyWith(
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                    label: Text('date'),
                  ),
                  picker: Future.delayed(Duration.zero, () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.parse('2022-06-22'),
                    ).then((value) {
                      print(value.toString());
                    });
                  })),
              FormComponent(
                controller: timeController,
                decoration: kInputDecoration.copyWith(
                  prefixIcon: Icon(Icons.punch_clock_rounded),
                  label: Text('time'),
                ),
                // picker: Future.delayed(Duration.zero, (){
                //       showTimePicker(
                //       context: context,
                //       initialTime: TimeOfDay.now()
                //   ).then((value) => print(value.toString()));
                // }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

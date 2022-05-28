import 'package:flutter/material.dart';

Widget formComponent(
        {required TextEditingController controller,
        required InputDecoration decoration,
        TextInputType? inputType,
        Future? picker}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType ?? TextInputType.datetime,
        decoration: decoration,
        onTap: () {
          picker!;
        },
      ),
    );

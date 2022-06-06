import 'package:flutter/material.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/my_observer.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(MyApp()), blocObserver: MyBlocObserver());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MyCubit()..createDB(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

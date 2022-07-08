import 'package:flutter/material.dart';
import 'package:task_ss/check_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task Scoop & Spoon',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CheckList());
  }
}

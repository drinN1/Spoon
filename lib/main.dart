import 'package:Spoon/selected_items.dart';
import 'package:flutter/material.dart';
import 'package:Spoon/check_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          'selected_items': (context) => const SelectedItems(),
        },
        title: 'Task Scoop & Spoon',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CheckList());
  }
}

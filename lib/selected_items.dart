import 'package:flutter/material.dart';

class SelectedItems extends StatefulWidget {
  const SelectedItems({Key? key}) : super(key: key);

  @override
  State<SelectedItems> createState() => _SelectedItemsState();
}

class _SelectedItemsState extends State<SelectedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selected Items')),
    );
  }
}

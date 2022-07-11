import 'package:flutter/material.dart';

class SummaryButton extends StatelessWidget {
  const SummaryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'selected_items');
      },
      child: const Text('Summary '),
    );
  }
}

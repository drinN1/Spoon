import 'package:flutter/material.dart';

import '../selected_items.dart';

class SummaryButton extends StatefulWidget {
  const SummaryButton(
      this.selectedItemsDrinks, this.selectedItemsMeals, this.token, this.logo);
  final List selectedItemsDrinks;
  final List selectedItemsMeals;
  final String token;
  final String logo;
  @override
  State<SummaryButton> createState() => _SummaryButtonState();
}

class _SummaryButtonState extends State<SummaryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.selectedItemsDrinks.isEmpty &&
            widget.selectedItemsMeals.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.red[100],
              title: const Text(
                'Alert',
              ),
              content: const Text(
                'Please select at least 1 item',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedItems(
                widget.selectedItemsDrinks,
                widget.selectedItemsMeals,
                widget.token,
                widget.logo,
              ),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Colors.red,
              Colors.blue,
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Summary ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

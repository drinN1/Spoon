import 'package:flutter/material.dart';
import 'package:spoon/widgets/custom_app_bar.dart';

class ShowSelectedItems extends StatefulWidget {
  const ShowSelectedItems(
    this.selectedItemsDrinks,
    this.selectedItemsMeals,
  );
  final List selectedItemsDrinks;
  final List selectedItemsMeals;

  @override
  State<ShowSelectedItems> createState() => _ShowSelectedItemsState();
}

class _ShowSelectedItemsState extends State<ShowSelectedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: const Text(
          'You Selected these Items',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: const CustomAppBar(),
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedItemsDrinks.length,
              itemBuilder: (BuildContext ctx, i) {
                return Card(
                  elevation: 7,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  color: Colors.red[100],
                  child: ListTile(
                    title: Center(
                      child: Text(
                        '${(widget.selectedItemsDrinks[i])}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedItemsMeals.length,
              itemBuilder: (BuildContext ctx, i) {
                return Card(
                  elevation: 7,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                  color: Colors.red[100],
                  child: ListTile(
                    title: Center(
                      child: Text(
                        '${(widget.selectedItemsMeals[i])}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

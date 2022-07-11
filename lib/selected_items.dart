import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spoon/show_selected_items.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/logo_image.dart';

class SelectedItems extends StatefulWidget {
  SelectedItems(
      this.selectedItemsDrinks, this.selectedItemsMeals, this.token, this.logo);
  final List selectedItemsDrinks;
  final List selectedItemsMeals;
  final String token;
  final String logo;
  @override
  State<SelectedItems> createState() => _SelectedItemsState();
}

class _SelectedItemsState extends State<SelectedItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: LogoImage(
          logo: widget.logo,
          token: widget.token,
        ),
        centerTitle: true,
        flexibleSpace: const CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  'To see selected items click the link below:',
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowSelectedItems(
                          widget.selectedItemsDrinks,
                          widget.selectedItemsMeals,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '${(widget.selectedItemsDrinks).join('/')}\n${(widget.selectedItemsMeals).join('/')}',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Share.share(
                  '${(widget.selectedItemsDrinks).join('/')}\n${(widget.selectedItemsMeals).join('/')}',
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.red, Colors.blue],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Share items ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

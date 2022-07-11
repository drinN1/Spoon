import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:Spoon/models/item_model.dart';

import 'widgets/logo_image.dart';
import 'widgets/summary_button.dart';

class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  List selectedItemsDrinks = [];
  List selectedItemsMeal = [];
  String token = 'task:prishtina';
  String logo = '';
  Future<List<Item>> getItems() async {
    const url = 'http://prishtinatask.scoopandspoon.at/api/flutter.php';

    final response = await http.get(
      Uri.parse(url),
    );

    var jsonData = json.decode(response.body) as Map<String, dynamic>;

    List<Item> items = [];
    logo = jsonData['logo'];

    for (int i = 0; i < jsonData.values.toList().length - 1; i++) {
      var item = Item.fromJson(jsonData.values.toList()[i]);

      items.add(item);
    }

    return items;
  }

  saveItems(bool value, Item item, Item parent, Item parentOfParent,
      Item parentOfParentOfParent) {
    if (value == true) {
      setState(() {
        selectedItemsDrinks.add(item.name);
      });
    } else if (item.parent == parent.id) {
      if (value == true) {
        setState(() {
          selectedItemsDrinks.add(item.name);
        });
      } else {
        setState(() {
          selectedItemsDrinks.removeWhere((element) =>
              element != parent.name &&
              element != parentOfParent.name &&
              element != parentOfParentOfParent.name);
        });
      }
    } else {
      setState(() {
        selectedItemsDrinks.clear();
      });
    }
  }

  saveItemsMeal(bool value, Item item, Item parent, Item parentOfParent,
      Item parentOfParentOfParent) {
    if (value == true) {
      setState(() {
        selectedItemsDrinks.add(item.name);
      });
    } else if (item.parent == parent.id) {
      if (value == true) {
        setState(() {
          selectedItemsDrinks.add(item.name);
        });
      } else {
        setState(() {
          selectedItemsDrinks.removeWhere((element) =>
              element != parent.name &&
              element != parentOfParent.name &&
              element != parentOfParentOfParent.name);
        });
      }
    } else {
      setState(() {
        selectedItemsDrinks.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scoop & Spoon'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Item>>(
          future: getItems(),
          builder: (
            context,
            snapshot,
          ) {
            return Container(
              color: Colors.white54,
              child: snapshot.hasData
                  ? Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext ctx, i) {
                                  final itemData = snapshot.data!;
                                  return Column(
                                    children: [
                                      Visibility(
                                        visible: itemData[i].parent == 0,
                                        child: ExpansionTile(
                                          onExpansionChanged: (value) {
                                            itemData[i].name == 'Drinks'
                                                ? {
                                                    saveItems(
                                                      value,
                                                      itemData[i],
                                                      itemData[i],
                                                      itemData[i],
                                                      itemData[i],
                                                    )
                                                  }
                                                : {
                                                    saveItemsMeal(
                                                      value,
                                                      itemData[i],
                                                      itemData[i],
                                                      itemData[i],
                                                      itemData[i],
                                                    )
                                                  };
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          leading: selectedItemsDrinks.contains(
                                                      itemData[i].name) ||
                                                  selectedItemsMeal.contains(
                                                      itemData[i].name)
                                              ? const Icon(
                                                  Icons.check_box,
                                                )
                                              : const Icon(Icons
                                                  .check_box_outline_blank),
                                          title: Text('${itemData[i].name}'),
                                          children: List.generate(
                                            itemData.length,
                                            (index) => Visibility(
                                              visible: itemData[index].parent ==
                                                  itemData[i].id,
                                              child: ExpansionTile(
                                                onExpansionChanged: (value) {
                                                  itemData[index].parent == 4
                                                      ? {
                                                          saveItems(
                                                            value,
                                                            itemData[index],
                                                            itemData[i],
                                                            itemData[i],
                                                            itemData[i],
                                                          )
                                                        }
                                                      : {
                                                          saveItemsMeal(
                                                            value,
                                                            itemData[index],
                                                            itemData[i],
                                                            itemData[i],
                                                            itemData[i],
                                                          )
                                                        };
                                                },
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                leading: selectedItemsDrinks
                                                            .contains(
                                                                itemData[index]
                                                                    .name) ||
                                                        selectedItemsMeal
                                                            .contains(
                                                                itemData[index]
                                                                    .name)
                                                    ? const Icon(
                                                        Icons.check_box,
                                                      )
                                                    : const Icon(Icons
                                                        .check_box_outline_blank),
                                                title: Text(
                                                    '${itemData[index].name}'),
                                                children: List.generate(
                                                  itemData.length,
                                                  (index1) => Visibility(
                                                    visible: itemData[index1]
                                                            .parent ==
                                                        itemData[index].id,
                                                    child: ExpansionTile(
                                                      onExpansionChanged:
                                                          (value) {
                                                        itemData[index1].parent ==
                                                                    5 ||
                                                                itemData[index1]
                                                                        .parent ==
                                                                    6
                                                            ? {
                                                                saveItems(
                                                                  value,
                                                                  itemData[
                                                                      index1],
                                                                  itemData[
                                                                      index],
                                                                  itemData[i],
                                                                  itemData[i],
                                                                )
                                                              }
                                                            : {
                                                                saveItemsMeal(
                                                                  value,
                                                                  itemData[
                                                                      index1],
                                                                  itemData[
                                                                      index],
                                                                  itemData[i],
                                                                  itemData[i],
                                                                )
                                                              };
                                                      },
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      leading: selectedItemsDrinks
                                                                  .contains(itemData[
                                                                          index1]
                                                                      .name) ||
                                                              selectedItemsMeal
                                                                  .contains(
                                                                      itemData[
                                                                              index1]
                                                                          .name)
                                                          ? const Icon(
                                                              Icons.check_box,
                                                            )
                                                          : const Icon(Icons
                                                              .check_box_outline_blank),
                                                      title: Text(
                                                        '${itemData[index1].name}',
                                                      ),
                                                      children: List.generate(
                                                        itemData.length,
                                                        (index2) => Visibility(
                                                          visible: itemData[
                                                                      index2]
                                                                  .parent ==
                                                              itemData[index1]
                                                                  .id,
                                                          child: ExpansionTile(
                                                            onExpansionChanged:
                                                                (value) {
                                                              itemData[index2].parent ==
                                                                          1 ||
                                                                      itemData[index2]
                                                                              .parent ==
                                                                          9
                                                                  ? {
                                                                      saveItems(
                                                                        value,
                                                                        itemData[
                                                                            index2],
                                                                        itemData[
                                                                            index1],
                                                                        itemData[
                                                                            index],
                                                                        itemData[
                                                                            i],
                                                                      )
                                                                    }
                                                                  : {
                                                                      saveItemsMeal(
                                                                        value,
                                                                        itemData[
                                                                            index2],
                                                                        itemData[
                                                                            index1],
                                                                        itemData[
                                                                            index],
                                                                        itemData[
                                                                            i],
                                                                      )
                                                                    };
                                                            },
                                                            controlAffinity:
                                                                ListTileControlAffinity
                                                                    .leading,
                                                            leading: selectedItemsDrinks.contains(
                                                                        itemData[index2]
                                                                            .name) ||
                                                                    selectedItemsMeal.contains(
                                                                        itemData[index2]
                                                                            .name)
                                                                ? const Icon(
                                                                    Icons
                                                                        .check_box,
                                                                  )
                                                                : const Icon(Icons
                                                                    .check_box_outline_blank),
                                                            title: Text(
                                                              '${itemData[index2].name}',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                        const SummaryButton(),
                        LogoImage(logo: logo, token: token)
                      ],
                    )
                  : snapshot.hasError
                      ? const Center(
                          child: Text('Snapshot Has Error'),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
            );
          }),
    );
  }
}

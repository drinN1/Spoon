import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:task_ss/models/item_model.dart';

class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  bool isDrinks = false;
  bool isPressed = false;
  Future<List<Item>> _fetchItem() async {
    const uri = 'http://prishtinatask.scoopandspoon.at/api/flutter.php';
    final response = await http.get(
      Uri.parse(uri),
    );

    var jsonData = json.decode(response.body) as Map<String, dynamic>;
    List<Item> items = [];
    for (int i = 0; i < jsonData.values.toList().length - 1; i++) {
      var item = Item.fromJson(jsonData.values.toList()[i]);

      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Item>>(
          future: _fetchItem(),
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
                                  return Column(
                                    children: [
                                      Visibility(
                                        visible: snapshot.data![i].parent == 0,
                                        child: //Parent

                                            ExpansionTile(
                                          trailing: Text(''),
                                          leading: Icon(
                                              Icons.check_box_outline_blank),
                                          title:
                                              Text('${snapshot.data![i].name}'),
                                          //  Children
                                          children: List.generate(
                                            snapshot.data!.length,
                                            (index) => Visibility(
                                              visible: snapshot
                                                      .data![index].parent ==
                                                  snapshot.data![i].id,
                                              child: ExpansionTile(
                                                trailing: Text(''),
                                                leading: Icon(Icons
                                                    .check_box_outline_blank),
                                                title: Text(
                                                    '${snapshot.data![index].name}'),
                                                children: List.generate(
                                                  snapshot.data!.length,
                                                  (index1) => Visibility(
                                                    visible: snapshot
                                                            .data![index1]
                                                            .parent ==
                                                        snapshot
                                                            .data![index].id,
                                                    child: ExpansionTile(
                                                      trailing: Text(''),
                                                      leading: Icon(Icons
                                                          .check_box_outline_blank),
                                                      title: Text(
                                                          '${snapshot.data![index1].name}'),
                                                      children: List.generate(
                                                        snapshot.data!.length,
                                                        (index2) => Visibility(
                                                          visible: snapshot
                                                                  .data![index2]
                                                                  .parent ==
                                                              snapshot
                                                                  .data![index1]
                                                                  .id,
                                                          child: ExpansionTile(
                                                            trailing: Text(''),
                                                            leading: Icon(Icons
                                                                .check_box_outline_blank),
                                                            title: Text(
                                                                '${snapshot.data![index2].name}'),
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
                      ],
                    )
                  : snapshot.hasError
                      ? const Center(
                          child: Text('Something went wrong'),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
            );
          }),
    );
  }
}

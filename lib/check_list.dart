import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:Spoon/models/item_model.dart';

class CheckList extends StatefulWidget {
  const CheckList({Key? key}) : super(key: key);

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spoon & Scoop'),
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
                                  return Column(
                                    children: [
                                      Visibility(
                                        visible: snapshot.data![i].parent == 0,
                                        child: //Parent
                                            ExpansionTile(
                                          trailing: const Text(''),
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
                                                trailing: const Text(''),
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
                                                      trailing: const Text(''),
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
                                                            trailing:
                                                                const Text(''),
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
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Summary '),
                        ),
                        Image.network(
                          logo,
                          headers: {
                            "authorization":
                                'Basic ' + base64Encode(utf8.encode('$token'))
                          },
                        )
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

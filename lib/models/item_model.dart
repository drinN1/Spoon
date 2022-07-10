import 'dart:convert';

Item itemModelFromJson(String str) {
  return Item.fromJson(json.decode(str));
}

class Item {
  Item(
    this.id,
    this.name,
    this.parent,
  );
  int? id;
  String? name;
  int? parent;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
  }
}

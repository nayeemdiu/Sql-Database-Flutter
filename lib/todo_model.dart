// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo {
  int id;
  String name;
  String title;

  Todo({
    required this.id,
    required this.name,
    required this.title,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["id"],
    name: json["name"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
  };
}

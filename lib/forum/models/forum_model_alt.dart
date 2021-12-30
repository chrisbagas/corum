// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

class Forum {
  Forum({
    required this.model,
    required this.pk,
    required this.fields,
  });

  final String model;
  final int pk;
  final Fields fields;

  factory Forum.fromRawJson(String str) => Forum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.title,
    required this.author,
    required this.body,
    required this.timeCreated,
    required this.timeModified,
  });

  final String title;
  final int author;
  final String body;
  final DateTime timeCreated;
  final DateTime timeModified;

  factory Fields.fromRawJson(String str) => Fields.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
        body: json["body"],
        timeCreated: DateTime.parse(json["time_created"]),
        timeModified: DateTime.parse(json["time_modified"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "body": body,
        "time_created": timeCreated.toIso8601String(),
        "time_modified": timeModified.toIso8601String(),
      };
}

// Future<List<Forum>> fetchForums() async {
//   // const url = 'https://corum.herokuapp.com/forum/api';
//   // final request = context.watch<NetworkService>();

//   const url = 'http://localhost:8000/forum/api';

//   final response = await http.get(Uri.parse(url));

//   List<Forum> result = [];

//   for (var r in response) {
//     if (r == null) continue;
//     result.add(Forum.fromJson(r));
//   }

//   return result;
// }

Future<List<Forum>> fetchForums() async {
  final response = await http.get(Uri.parse('http://localhost:8000/forum/api'));

  if (response.statusCode == 200) {
    return parseItem(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

List<Forum> parseItem(String responseBody) {
  final List<Forum> forums = [];
  final parsed = jsonDecode(responseBody) as List<dynamic>;
  for (var e in parsed) {
    forums.add(Forum.fromJson(e));
  }

  return forums;
}

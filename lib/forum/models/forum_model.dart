import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Forum {
  final int pk;
  final String title;
  final dynamic author;
  final dynamic authorUsername;
  final String body;
  final DateTime createdTime;
  final DateTime modifiedTime;

  Forum({
    required this.pk,
    required this.title,
    required this.author,
    required this.authorUsername,
    required this.body,
    required this.createdTime,
    required this.modifiedTime,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
        pk: json['pk'],
        title: json['fields']['title'],
        author: json['fields']['author'],
        authorUsername: json['fields']['author_username'],
        body: json['fields']['body'],
        createdTime: DateTime.parse(json['fields']['time_created']),
        modifiedTime: DateTime.parse(json['fields']['time_modified']));
  }

  Map<String, dynamic> toJson() => {
        title: "title",
        author: "author",
        body: "body",
      };
}

Future<List<Forum>> fetchForums() async {
  // const url = 'https://corum.herokuapp.com/forum/api';
  const url = 'http://localhost:8000/forum/api';

  final response = await http.get(Uri.parse(url));

  List<dynamic> extractedData = jsonDecode(response.body);
  List<Forum> forums = [];

  for (dynamic frm in extractedData) {
    forums.add(Forum.fromJson(frm));
  }

  return forums;
}

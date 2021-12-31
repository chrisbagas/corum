import 'dart:convert';

class Survey {
  Survey({
    required this.title,
    required this.description,
    required this.pubDate,
  });

  final String title;
  final String description;
  final DateTime pubDate;

  factory Survey.fromRawJson(String str) =>
      Survey.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        title: json["fields"]["title"],
        description: json["fields"]["description"],
        pubDate: DateTime.parse(json["fields"]["pub_date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "pub_date": pubDate.toIso8601String(),
      };
}
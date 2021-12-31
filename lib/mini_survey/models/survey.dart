import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Survey {
  Survey({
    required this.title,
    required this.description,
    required this.creator,
    required this.pubDate,
  });

  final String title;
  final String description;
  final String creator;
  final String pubDate;

  factory Survey.fromRawJson(String str) => Survey.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
    "title" : title,
    "description" : description,
    "creator" : creator,
    "pubDate" : pubDate,
  };

  factory Survey.fromJson(Map<String, dynamic> json) {
    final String jsonDate = json["pub_date"];

    DateTime date = DateTime.parse(jsonDate);
    String formattedDate = DateFormat("d MMM yyyy h:mm a").format(date);

    return Survey(
      title: json["title"],
      description: json["description"],
      creator: json["creator"],
      pubDate: formattedDate,
    );
  }
}

List<dynamic> parseSurveys(String json) {
  final parsed = jsonDecode(json);
  return List<dynamic>.from(parsed);
}

Survey parseSurvey(String json) {
  final parsed = jsonDecode(json);
  Survey survey = Survey.fromJson(parsed);
  return survey;
}

Future<List<Survey>> fetchSurveys() async {
  var url = Uri.parse("https://corum.herokuapp.com/survey/get-lists/");

  final response = await http.get(url);
  List<dynamic> extractedData = jsonDecode(response.body);
  List<Survey> surveys = [];

  for (dynamic d in extractedData) {
    surveys.add(Survey.fromJson(d["fields"]));
  }

  return surveys;
}
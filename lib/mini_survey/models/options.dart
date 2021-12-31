import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Options {
  Options({
    required this.text,
    required this.count,
  });

  final String text;
  final int count;

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      text: json["text"],
      count: json["option_count"]
    );
  }
}

Future<List<Options>> fetchOptions() async {
  const url = "https://corum.herokuapp.com/survey/4/get-options/";

  final response = await http.get(Uri.parse(url));
  List<dynamic> extractedData = jsonDecode(response.body);
  List<Options> options = [];

  for (dynamic d in extractedData) {
    options.add(Options.fromJson(d));
  }

  return options;
}
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Events {
  String image1,
      image2,
      title,
      url,
      date,
      time,
      media,
      tipe,
      description,
      created;
  Events({
    required this.title,
    required this.date,
    required this.time,
    required this.media,
    required this.tipe,
    required this.url,
    required this.description,
    required this.image1,
    required this.image2,
    required this.created,
  });

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
        title: json['Nama'],
        date: json['Tanggal'],
        time: json['Waktu'],
        media: json['Media'],
        tipe: json['Tipe'],
        url: json['url'],
        description: json['Deskripsi'],
        image1: "https://corumbucket.s3.amazonaws.com/${json['Card_Image']}",
        image2: "https://corumbucket.s3.amazonaws.com/${json['Page_Image']}",
        created: json['created']);
  }
}

Future<List<Events>> fetchPosts() async {
  const url = 'https://corum.herokuapp.com/event/json';

  final response = await http.get(Uri.parse(url));
  List<dynamic> extractedData = jsonDecode(response.body);
  List<Events> events = [];

  for (dynamic d in extractedData) {
    events.add(Events.fromJson(d['fields']));
  }

  return events;
}

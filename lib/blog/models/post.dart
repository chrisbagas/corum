import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class Post {
  const Post({
    required this.title,
    required this.subtitle,
    required this.thumbnailUrl,
    required this.bodyText,
    required this.datePublished,
    required this.author,
    required this.slug,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final String _jsonDate = json['date_published'];

    DateTime _d = DateTime.parse(_jsonDate);
    String _formattedDate = DateFormat('d MMM yyyy h:mm a').format(_d);

    return Post(
      title: json['title'],
      subtitle: json['subtitle'],
      thumbnailUrl: "https://corumbucket.s3.amazonaws.com/${json['thumbnail']}",
      bodyText: json['body'],
      datePublished: _formattedDate,
      author: json['author'][0],
      slug: json['slug'],
    );
  }

  final String title;
  final String subtitle;
  final String thumbnailUrl;
  final String bodyText;
  final String datePublished;
  final String author;
  final String slug;
}

List<dynamic> parsePosts(String json) {
  final parsed = jsonDecode(json);
  return List<dynamic>.from(parsed);
}

Post parsePost(String json) {
  final parsed = jsonDecode(json);
  Post post = Post.fromJson(parsed);
  return post;
}

Future<List<Post>> fetchPosts() async {
  const url = 'https://corum.herokuapp.com/blog/api/posts';

  final response = await http.get(Uri.parse(url));
  List<dynamic> extractedData = jsonDecode(response.body);
  List<Post> posts = [];

  for (dynamic d in extractedData) {
    posts.add(Post.fromJson(d['fields']));
  }

  return posts;
}

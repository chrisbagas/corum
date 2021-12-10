import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Post {
  const Post({
    required this.title,
    required this.subtitle,
    required this.thumbnailUrl,
    required this.bodyText,
    required this.datePublished,
    required this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      subtitle: json['subtitle'],
      thumbnailUrl: "https://corumbucket.s3.amazonaws.com/${json['thumbnail']}",
      bodyText: json['body'],
      datePublished: json['date_published'],
      author: 'Test',
    );
  }

  final String title;
  final String subtitle;
  final String thumbnailUrl;
  final String bodyText;
  final String datePublished;
  final String author;
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

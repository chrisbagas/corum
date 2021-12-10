import 'package:flutter/material.dart';
import '../models/post.dart';
import './card_item.dart';

class SearchPost extends SearchDelegate<Post> {
  final Future<List<Post>> posts;

  SearchPost({
    required this.posts,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        titleSpacing: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFFECF2FF),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 22),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x80FFFFFF),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF0B0B22),
            style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        labelStyle: const TextStyle(
          color: Color(0xFFF2F8F2),
        ),
        hintStyle: const TextStyle(
          color: Color(0x60020802),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          const Post(
            title: '',
            subtitle: '',
            thumbnailUrl: '',
            bodyText: '',
            datePublished: '',
            author: '',
          ),
        );
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: posts,
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Nothing Found :(',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }

          final results = snapshot.data!.where(
            (post) => post.title.toLowerCase().contains(query.toLowerCase()),
          );

          return ListView(
            children: results.map<Widget>((result) {
              return CardItem(post: result);
            }).toList(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: posts,
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Nothing Found :(',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }

          final results = snapshot.data!.where(
            (post) => post.title.toLowerCase().contains(query.toLowerCase()),
          );

          return ListView(
            children: results.map<Widget>((result) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      result.title,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    tileColor: const Color(0x08FFAADD),
                    onTap: () {
                      query = result.title;
                    },
                  ),
                  const Divider(
                    color: Color(0xFF2C2E3D),
                    height: 0,
                  ),
                ],
              );
            }).toList(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../models/post.dart';
import './card_item.dart';

class SearchPost extends SearchDelegate<Post> {
  final Future<List<Post>> posts;

  SearchPost({
    required this.posts,
  });

  int _chipIndex = -1;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        titleSpacing: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color(0xe0F2F8F2),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 22),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black38,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black38,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x806082FF), // Color(0xFF0B0B22),
            style: BorderStyle.solid,
            width: 2,
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
            slug: '',
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

          Iterable<Post> results = snapshot.data!.where(
            (post) => post.title.toLowerCase().contains(query.toLowerCase()),
          );

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              switch (_chipIndex) {
                case 0:
                  setState(() {
                    results = snapshot.data!.where(
                      (post) => post.title
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    );
                  });

                  break;
                case 1:
                  setState(() {
                    results = snapshot.data!.where(
                      (post) => post.author
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    );
                  });
                  break;
                default:
                  setState(() {
                    results = snapshot.data!.where(
                      (post) => post.title
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    );
                  });
              }

              return ListView(
                children: results.map<Widget>((result) {
                  return CardItem(post: result);
                }).toList(),
              );
            },
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

          Iterable<Post> results = snapshot.data!.where(
            (post) => post.title.toLowerCase().contains(query.toLowerCase()),
          );

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              switch (_chipIndex) {
                case 0:
                  setState(() {
                    results = snapshot.data!.where(
                      (post) => post.title
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    );
                  });

                  break;
                case 1:
                  setState(() {
                    Set<String> _container = {};
                    results = snapshot.data!.where(
                      (post) {
                        String _q = post.author.toLowerCase();

                        if (_container.add(_q)) {
                          return _q.contains(query.toLowerCase());
                        }
                        return false;
                      },
                    );
                  });
                  break;
                default:
                  setState(
                    () {
                      results = snapshot.data!.where(
                        (post) => post.title
                            .toLowerCase()
                            .contains(query.toLowerCase()),
                      );
                    },
                  );
              }
              return ListView(
                children: results.map<Widget>((result) {
                  String _displayText =
                      (_chipIndex == 1) ? result.author : result.title;
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          _displayText,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        tileColor: const Color(0x08FFAADD),
                        onTap: () {
                          query = _displayText;
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
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(72),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Filter by...',
                    style: TextStyle(
                      color: Color(0xFFF2F8F2),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          backgroundColor: const Color(0xe0F2F8F2),
                          selectedColor: const Color(0xe0ACB0AC),
                          shape: const StadiumBorder(
                            side: BorderSide(
                              width: 1,
                              color: Colors.black38,
                            ),
                          ),
                          label: Text(
                            'title',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          selected: _chipIndex == 0,
                          onSelected: (bool selected) {
                            setState(() {
                              _chipIndex = selected ? 0 : -1;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          backgroundColor: const Color(0xe0F2F8F2),
                          selectedColor: const Color(0xe0ACB0AC),
                          shape: const StadiumBorder(
                            side: BorderSide(
                              width: 1,
                              color: Colors.black38,
                            ),
                          ),
                          label: Text(
                            'author',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          selected: _chipIndex == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              _chipIndex = selected ? 1 : -1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import '../models/post.dart';

class DetailedPost extends StatelessWidget {
  const DetailedPost({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final String _parsedBodyText =
        parse(parse(post.bodyText).body!.text).documentElement!.text;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade200,
        titleTextStyle: const TextStyle(
          color: Color(0xFFE6F8F2),
          fontSize: 18,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: post.slug,
                  child: Image.network(
                    post.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 7 / 8,
                  bottom: 10,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      // gradient: LinearGradient(
                      //   // 0x40632D37
                      //   colors: [
                      //     Color(0xff000000),
                      //     Color(0xc0000000),
                      //   ],
                      //   begin: Alignment.centerLeft,
                      //   end: Alignment.centerRight,
                      //   stops: [0.2, 1],
                      // ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      color: Color(0xe0000000),
                    ),
                    padding: const EdgeInsets.only(left: 12, top: 4, bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            post.title,
                            style: const TextStyle(
                              color: Color(0xFFF2F8F2),
                              fontSize: 18,
                              fontFamily: 'Playfair Display',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            post.subtitle,
                            style: const TextStyle(
                              color: Color(0xFFE6F8F2),
                              fontSize: 14,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 4, bottom: 6),
                          child: Text(
                            'Posted on ${post.datePublished}',
                            style: const TextStyle(
                              color: Color(0xC0E6F8F2),
                              fontSize: 10,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.fromLTRB(26, 30, 26, 100), // 20 40 20 100
                child: Text(
                  _parsedBodyText,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

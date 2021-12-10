import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Color(0xFFE6F8F2),
          fontSize: 18,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
        ),
        title: Text('Add a blog post'),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.subtitle1,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Write the title for your blog post here.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid title.";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    style: const TextStyle(
                      color: Color(0xFFF2F8F2),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Subtitle',
                      hintText:
                          'Write an appealing subtitle for your blog post here.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid subtitle.";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    maxLines: 12,
                    style: const TextStyle(
                      color: Color(0xFFF2F8F2),
                    ),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Body',
                      hintText: 'Write your post here.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid title.";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('TODO Implement this')),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

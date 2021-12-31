import 'package:flutter/material.dart';

import '../models/options.dart';
import '../models/survey.dart';

class SurveyResults extends StatefulWidget {
  const SurveyResults({ Key? key, required this.option }) : super(key: key);

  final Future<List<Options>> option;

  @override
  _SurveyResultsState createState() => _SurveyResultsState();
}

class _SurveyResultsState extends State<SurveyResults> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Options>>(
      future: widget.option,
      builder: (context, AsyncSnapshot<List<Options>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Column(
              children: const [
                Center(
                  child: Text(
                    "Page Not Found",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "The page you are looking for doesn't seem to exist...",
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            );
          }

          return Center(
            child: Text("Results"),
          );

        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
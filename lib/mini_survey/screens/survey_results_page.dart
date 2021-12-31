import 'package:flutter/material.dart';

import './survey_create_page.dart';
import '../models/options.dart';
import '../models/survey.dart';

class SurveyResultsPage extends StatefulWidget {
  const SurveyResultsPage({ Key? key }) : super(key: key);

  @override
  _SurveyResultsPageState createState() => _SurveyResultsPageState();
}

class _SurveyResultsPageState extends State<SurveyResultsPage> {
  final Future<List<Options>> options = fetchOptions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey Results"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Center(
        child:Text('Results Page'),
      )
    );
  }
}
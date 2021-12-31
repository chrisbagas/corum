import 'package:flutter/material.dart';
import 'package:http/http.dart';

import './survey_create_page.dart';
import '../widgets/search.dart';

class SurveyMainPage extends StatefulWidget {
  static const routeName = '/mini-survey';
  const SurveyMainPage({Key? key}) : super(key: key);

  @override
  _SurveyMainPageState createState() => _SurveyMainPageState();
}

class _SurveyMainPageState extends State<SurveyMainPage> {

  Widget buildHeader() {
    return Container(
      color: Colors.teal[200],
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 1,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Column(
              children: const [
                SizedBox(
                  height: 70,
                ),
                Text(
                  "SURVEY SEPUTAR COVID-19",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 8.0),
                  child: Text(
                    "Lihat dan ikuti sejumlah mini survey menarik untuk mengetahui preferensi orang terhadap sesuatu yang berkaitan dengan COVID-19",
                    style: TextStyle(fontSize: 11),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 40,
            child: Image.asset("assets/images/corona.png"),
          )
        ],
      )
    );
  }

  Widget buildContentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Text(
                "Survey List",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "0 survey available",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SurveyCreatePage())
              );
            }, 
            child: Text('Create New Survey')
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Survey'),
        backgroundColor: Colors.greenAccent.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(),
            const SizedBox(
              height: 10,
            ),
            buildContentHeader(),
            buildSearchBar(),
          ],
        ),
      ),
    );
  }
}

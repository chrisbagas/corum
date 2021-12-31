import 'package:flutter/material.dart';

import '../models/survey.dart';

class SurveyCards extends StatefulWidget {
  const SurveyCards({ Key? key, required this.survey, }) : super(key: key);

  final Future<List<Survey>> survey;

  @override
  _SurveyCardsState createState() => _SurveyCardsState();
}

class _SurveyCardsState extends State<SurveyCards> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Survey>>(
      future: widget.survey,
      builder: (context, AsyncSnapshot<List<Survey>> snapshot) {
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

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.black,
                elevation: 10,
                color: Theme.of(context).primaryColor,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
                ),
                child: InkWell(
                  onTap: () {

                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              snapshot.data![index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            width: 195,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.black, borderRadius: BorderRadius.circular(4.0)
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: 12.0,
                              ),
                            )
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.black, borderRadius: BorderRadius.circular(4.0)
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                                size: 12.0,
                              ),
                            )
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(snapshot.data![index].pubDate),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    const Icon(
                                      Icons.person,
                                      size: 12,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Text(snapshot.data![index].creator),
                                  ],
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ElevatedButton(
                              child: Text('Vote Now'),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
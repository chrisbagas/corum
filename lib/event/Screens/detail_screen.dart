import 'package:flutter/material.dart';
import 'package:corum/event/models/events.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as Events;
    final url = event.url;
    return Scaffold(
        resizeToAvoidBottomInset: false, // set it to false
        body: SingleChildScrollView(
          child: Container(
              color: Color(0xffC1FFD7),
              child: Card(
                color: Theme.of(context).primaryColor,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        event.image2,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            event.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 30),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(event.date, textAlign: TextAlign.start)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(event.time, textAlign: TextAlign.start)),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Link(
                              uri: Uri.parse(url),
                              builder: (context, followLink) => GestureDetector(
                                  onTap: followLink,
                                  child: Text(event.media,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      textAlign: TextAlign.start)))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(event.description,
                              textAlign: TextAlign.start)),
                    ],
                  ),
                ),
              )),
        ));
  }
}

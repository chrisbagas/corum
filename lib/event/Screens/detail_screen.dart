// @dart=2.9
import 'package:flutter/material.dart';
import 'package:corum/event/models/events.dart';
import 'package:corum/event/screens/body_home.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Events event = ModalRoute.of(context).settings.arguments;
    return Container(
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
                Ink.image(
                  image: AssetImage(
                    event.image,
                  ),
                  height: 300,
                  fit: BoxFit.fill,
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
                    child: Text(event.media, textAlign: TextAlign.start)),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(event.description, textAlign: TextAlign.start)),
              ],
            ),
          ),
        ));
  }
}

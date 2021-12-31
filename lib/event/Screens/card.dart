import 'package:corum/event/models/events.dart';
import 'package:corum/event/Screens/detail_screen.dart';
import 'package:flutter/material.dart';

class Cardlist extends StatefulWidget {
  const Cardlist({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Future<List<Events>> event;

  @override
  State<Cardlist> createState() => _CardlistState();
}

class _CardlistState extends State<Cardlist> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Events>>(
      future: widget.event,
      builder: (context, AsyncSnapshot<List<Events>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Nothing Found :(',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }

          return Container(
              child: Container(
                  child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "EVENTS SEPUTAR ",
                    style: TextStyle(fontSize: 45, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: "COVID-19",
                          style: TextStyle(
                              fontSize: 45,
                              color: Colors.amber.shade600,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(20),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Ikuti event-event untuk menambah wawasan seputar ",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: "COVID-19",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.amber.shade600,
                                fontWeight: FontWeight.bold)),
                      ],
                    ))),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: Colors.red,
                    elevation: 8,
                    color: Theme.of(context).primaryColor,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(),
                            settings:
                                RouteSettings(arguments: snapshot.data![index]),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            snapshot.data![index].image1,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                snapshot.data![index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30),
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(snapshot.data![index].date,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start)),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(snapshot.data![index].time,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start)),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(snapshot.data![index].media,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start)),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(snapshot.data![index].tipe,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start)),
                        ],
                      ),
                    ),
                  );
                })
          ])));
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      },
    );
  }
}

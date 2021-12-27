import 'package:flutter/material.dart';

class Events {
  String image, title, date, time, media, description;
  int id;
  Events(
      {required this.id,
      required this.title,
      required this.date,
      required this.time,
      required this.media,
      required this.description,
      required this.image});
}

List<Events> events = [
  Events(
    id: 0,
    title: "dummy",
    description: "",
    date: "dummy",
    time: "dummy",
    media: "dummy",
    image: "images/covid.jpg",
  ),
  Events(
    id: 1,
    title: "Covid Talk",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
    date: "15/01/2022",
    time: "15:00",
    media: "Zoom",
    image: "images/covid.jpg",
  ),
  Events(
    id: 2,
    title: "Keep Clean",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
    date: "10/12/2021",
    time: "12:00",
    media: "Google Meet",
    image: "images/handsanitizer.jpg",
  ),
  Events(
    id: 3,
    title: "Keep Your Distance",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
    date: "30/11/2021",
    time: "16:00",
    media: "Zoom",
    image: "images/safedistance.jpg",
  ),
  Events(
    id: 4,
    title: "Importance of Vaccine",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
    date: "25/11/2021",
    time: "09:30",
    media: "Google Meet",
    image: "images/vaccine.jpg",
  ),
];

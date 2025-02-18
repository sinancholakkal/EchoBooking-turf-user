import 'package:flutter/material.dart';

// final backGroundColor = Color.fromARGB(255, 3, 2, 37);
final backGroundColor = Color.fromARGB(255, 0, 5, 21);
final kWhite = Colors.white;
const kBlack = Colors.black;
const kGrey = Colors.grey;
const kblue = Color.fromARGB(255, 27, 70, 199);
const iconColorPerson = Color.fromARGB(255, 131, 183, 111);

//home sceen--
const searchBgColor = Color.fromARGB(74, 158, 158, 158);
const homeIconColor = Colors.yellow;
const bookingIconColor = Colors.white;
final starIconColor = Colors.red[400];
const buttonColor = Color.fromARGB(255, 41, 38, 236);

//card bg color
// const cardBgColor = Color.fromARGB(255, 245, 242, 199);
const cardBgColor = Color.fromARGB(255, 39, 10, 49);
//Color.fromARGB(255, 187, 223, 199);
const iconColor = Color.fromARGB(255, 245, 242, 199);

var linearGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: [0.1, 0.4, 0.7, 1],
  colors: [
    Color(0xFF000000), // Absolute Black
    Color(0xFF1B1B2F), // Deep Indigo
    Color.fromARGB(255, 18, 4, 49), // Dark Violet
    Color.fromARGB(255, 54, 7, 86), // Royal Purple
  ],
);

var backGroundGradient = LinearGradient(
  colors: [
    backGroundColor,
    backGroundColor,
    Color.fromARGB(255, 49, 0, 0),
    backGroundColor,
    Color.fromARGB(255, 49, 0, 0),
    backGroundColor
  ], // Dark purple to deep red
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

import 'package:flutter/material.dart';




const Color bluishColor = Color(0xFF4e5ae8);
const Color yellowColor = Color(0xFFFFB746);
const Color pinkColor = Color(0xFFff4667);
const Color darkGreyColor = Color(0xFF121212);
const Color darkHeaderColor = Color(0xFF424242);
class Themes{
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: bluishColor,
    brightness: Brightness.light
  );

  static final dark = ThemeData(
    backgroundColor: darkGreyColor,
      primaryColor: darkGreyColor,
      brightness: Brightness.dark
  );
}

// TextStyle get subHeadingStyle{
//   return GoogleFonts.lato(
//     textStyle: TextStyle(
//       fontSize: 24,
//       fontWeight: FontWeight.bold
//     )
//
//   );
// }
//
// TextStyle get headingStyle{
//   return GoogleFonts.lato(
//       textStyle: TextStyle(
//           fontSize: 30,
//           fontWeight: FontWeight.bold
//       )
//
//   );
// }
//Icons made by <a href="https://www.flaticon.com/authors/photo3idea-studio"

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

void main(){
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}


const MaterialColor primaryColor = MaterialColor(
  0xFFF48FB1,
  <int, Color>{
    50: Color(0xFFF48FB1),
    100: Color(0xFFF48FB1),
    200: Color(0xFFF48FB1),
    300: Color(0xFFF48FB1),
    400: Color(0xFFF48FB1),
    500: Color(0xFFF48FB1),
    600: Color(0xFFF48FB1),
    700: Color(0xFFF48FB1),
    800: Color(0xFFF48FB1),
    900: Color(0xFFF48FB1),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art filter',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: HomeScreen(),
    );
  }
}

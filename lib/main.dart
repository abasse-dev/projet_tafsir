import 'package:flutter/material.dart';
import 'package:projet_tafsir/constant/constant.dart';

import 'screens/home_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Application Tafsir",
      theme: ThemeData(
        
        primarySwatch: colorAmber,
        accentColor: accentColor
      ),
      home: Home(),
    );
  }
}


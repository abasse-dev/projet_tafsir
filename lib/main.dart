import 'package:flutter/material.dart';
import 'package:projet_tafsir/constant/constant.dart';
import 'package:flutter/services.dart';
import 'package:projet_tafsir/screens/apropo_screen.dart';
import 'package:projet_tafsir/screens/download_screen.dart';

import 'screens/home_screen.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: "Application Tafsir",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: colorAmber, accentColor: accentColor),
      initialRoute: "/apropo",
      routes: {
        "/": (context) => Home(),
        "/download": (context) => DownloadScreen(),
        "/apropo": (context) => Apropos()
      },
    );
  }
}

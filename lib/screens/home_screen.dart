import 'package:flutter/material.dart';
import 'package:projet_tafsir/components/drawer_component.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
      ),

      drawer: DrawerComponent(),
    );
  }
}
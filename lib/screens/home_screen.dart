import 'package:flutter/material.dart';
import 'package:projet_tafsir/components/drawer_component.dart';
import 'package:projet_tafsir/constant/constant.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double larger = MediaQuery.of(context).size.width;
    double hauter = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            "Lecture Tafsir",
            style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      drawer: DrawerComponent(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage("images/youssouf1.jpg"),
                height: hauter / 2,
                width: larger / 2,
              ),
            ),
            Text(
              "Cheikh El Hadj Youssoufou OUEDRAOGO",
              style: TextStyle(
                  color: colorAmber,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: hauter / 20,
            ),
            Text(
              "Tafsir Assise 001",
              style: TextStyle(color: colorAmber, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: hauter / 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.loop,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {}),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {}),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {}),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {}),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.playlist_play,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {}),
              ],
            ),
            SizedBox(
              height: hauter / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Text(
                  "30:20",
                  style: TextStyle(color: colorAmber),
                )),
                Container(
                    width: larger / 1.3,
                    child: Slider(
                      value: 50,
                      max: 100,
                      activeColor: Colors.blue,
                      inactiveColor: colorAmber,
                      onChanged: (value) {},
                    )),
                Container(
                    child: Text(
                  "30:20",
                  style: TextStyle(color: colorAmber),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

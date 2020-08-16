import 'package:flutter/material.dart';
import 'package:projet_tafsir/constant/constant.dart';

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width;
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/mosquee.jpg"), fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/youssouf1.jpg"),
                  radius: radius / 10,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Cheikh El Hadj Youssoufou OUEDRAOGO",
                  style:
                      TextStyle(color: colorAmber, fontWeight: FontWeight.bold),
                ),
                Text(
                  "trabasse84@gmail.com",
                  style:
                      TextStyle(color: colorAmber, fontStyle: FontStyle.italic),
                )
              ],
            )),
        ListTile(
          title: Text(
            "Téléchargement",
            style: TextStyle(color: colorAmber),
          ),
          leading: Icon(
            Icons.cloud_download,
            color: colorAmber,
          ),
          onTap: () {
      
             Navigator.pushNamedAndRemoveUntil(context, '/download', (route) => false);
          },
        ),
        ListTile(
          title: Text(
            "Lecture",
            style: TextStyle(color: colorAmber),
          ),
          leading: Icon(
            Icons.music_note,
            color: colorAmber,
          ),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),
        Divider(
          color: colorAmber,
          height: 5.0,
        ),
        ListTile(
          title: Text(
            "Partager",
            style: TextStyle(color: colorAmber),
          ),
          leading: Icon(
            Icons.share,
            color: colorAmber,
          ),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            "A propos",
            style: TextStyle(color: colorAmber),
          ),
          leading: Icon(
            Icons.info_outline,
            color: colorAmber,
          ),
          onTap: () {},
        ),
      ],
    ));
  }

  
}

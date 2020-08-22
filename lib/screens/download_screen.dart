import 'package:flutter/material.dart';
import 'package:projet_tafsir/components/drawer_component.dart';
import 'package:projet_tafsir/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:projet_tafsir/screens/active_downloaded.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  CollectionReference _firestore = Firestore.instance.collection('TAFSIR');
  Set<String> _downloadList = {};

  initList() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      _downloadList = pref.getKeys();
    });
  }

  @override
  void initState() {
    initList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_downloadList);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            "Téléchargement Tafsir",
            style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.white12,
      drawer: DrawerComponent(),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text(
                'une erreur de connexion !!',
                style: TextStyle(color: colorRed),
              );
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text(
                  'Attendre cela peut prendre un peu de temps',
                  style: TextStyle(color: colorGreen),
                );
                break;
              default:
                return ListView(
                  children: snapshot.data.documents.map((document) {
                    String titreh = document['titre'];
                    return ListTile(
                      trailing: CircleAvatar(
                        backgroundImage: AssetImage('images/baye.jpg'),
                      ),
                      title: Text(
                        'Tafsir ${document['titre']}',
                        style: TextStyle(
                            color: _downloadList.contains(titreh)
                                ? colorGreen
                                : accentColor,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: _downloadList.contains(titreh)
                          ? Icon(
                              Icons.done,
                              color: colorGreen,
                            )
                          : Icon(
                              Icons.file_download,
                              color: accentColor,
                            ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActiveDownload(
                                      titre: document['titre'],
                                      path: document['path'],
                                    )));
                      },
                    );
                  }).toList(),
                );
            }
          }),
    );
  }
}

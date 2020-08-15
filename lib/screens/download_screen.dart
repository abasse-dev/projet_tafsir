import 'package:flutter/material.dart';
import 'package:projet_tafsir/components/drawer_component.dart';
import 'package:projet_tafsir/constant/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  CollectionReference _firestore = Firestore.instance.collection('TAFSIR');
  @override
  Widget build(BuildContext context) {
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
                  children: snapshot.data.documents
                      .map((document) => ListTile(
                            title: Text(
                              'Tafsir ${document['titre']}',
                              style: TextStyle(color: accentColor,fontWeight: FontWeight.bold),
                              
                            ),
                            leading: Icon(
                              Icons.file_download,
                              color: accentColor,
                            ),
                            onTap: (){},
                          ))
                      .toList(),
                );
            }
          }),
    );
  }
}

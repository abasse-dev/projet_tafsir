import 'package:flutter/material.dart';
import 'package:projet_tafsir/constant/constant.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:projet_tafsir/data/shared_preferences.dart';

class ActiveDownload extends StatefulWidget {
  final String titre, path;
  ActiveDownload({this.titre, this.path});
  @override
  _ActiveDownloadState createState() => _ActiveDownloadState();
}

class _ActiveDownloadState extends State<ActiveDownload> {
  String termine = '';
  int _progress = 0;
  double _value = 0.0;
  bool isdownloading = false;
  bool isclicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Téléchargement',
          style: TextStyle(color: colorWhite),
        ),
        backgroundColor: accentColor,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              'images/baye.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Téléchargement de tafsir ${widget.titre}',
              style: TextStyle(color: colorAmber, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5.0,
            ),
            LinearProgressIndicator(
              minHeight: 5.0,
              value: _value,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              '$_progress %',
              style: TextStyle(color: colorAmber),
            ),
            SizedBox(
              height: 5.0,
            ),
            GestureDetector(
              child: Text(
                'Télécharger',
                style: TextStyle(
                    color: isdownloading ? colorGreen : accentColor,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () async {
              
                if (!isclicked) {
                    isclicked = true;
                  isdownloading = true;
                  var dir = await getExternalStorageDirectory();
                  var dio = Dio();
                  if (!await getSharedPreferences(widget.titre)) {
                    dio
                        .download(
                          widget.path,
                          '${dir.path}/TAFSIR/${widget.titre}.amr',
                          onReceiveProgress: (count, total) {
                            var progress = count / total;

                            setState(() {
                              _progress = (progress * 100).floor();
                              _value = progress.toDouble();
                            });

                            if (count == total) {
                              termine = 'Terminé avec succès !!';

                              isdownloading = false;
                            }
                          },
                        )
                        .then((value) => setSharedPreferences(widget.titre))
                        .catchError((error) {
                          var file =
                              File('${dir.path}/TAFSIR/${widget.titre}.amr');
                          file.deleteSync();
                        })
                        .catchError((error) => Text(
                              'Vérifier votre connexion internet',
                              style: TextStyle(color: colorRed),
                            ));
                  } else {
                    setState(() {
                      _value = 1;
                      _progress = 100;
                      termine = 'déjà téléchargé';
                    });
                  }
                }
              },
            ),
            Text(
              termine,
              style: TextStyle(color: colorRed),
            )
          ])
        ],
      ),
    );
  }
}

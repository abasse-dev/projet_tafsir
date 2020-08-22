import 'package:flutter/material.dart';
import 'package:projet_tafsir/constant/constant.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:android_device_info/android_device_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projet_tafsir/data/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apropos extends StatefulWidget {
  @override
  _AproposState createState() => _AproposState();
}

class _AproposState extends State<Apropos> {
  var _info;
  var store = Firestore.instance.collection('APPAREIL INSTALLED');
  String enregistrer = 'sur le net';
  _getInfo() async {
    if (!await getSharedPreferences(enregistrer)) {
      var info = await AndroidDeviceInfo().getSystemInfo().then((value) {
        {
          store.document().setData({'android info': value}).then(
              (value) => setSharedPreferences(enregistrer));
        }
      });
    }
  }

  @override
  void initState() {
    _getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.0,
          centerTitle: true,
          title: Text(
            'A propos de',
            style: TextStyle(color: colorWhite, fontStyle: FontStyle.italic),
          ),
          bottom: TabBar(tabs: [
            Text(
              'Cheikh',
              style: TextStyle(color: colorWhite, fontStyle: FontStyle.italic),
            ),
            Text('Application',
                style:
                    TextStyle(color: colorWhite, fontStyle: FontStyle.italic))
          ]),
        ),
        body: TabBarView(children: [Cheikh(), AppPropo()]),
      ),
    );
  }
}

class Cheikh extends StatefulWidget {
  @override
  _CheikhState createState() => _CheikhState();
}

class _CheikhState extends State<Cheikh> {
  String biographie = "images/cheikh.pdf";
  PDFDocument _doc;
  bool _loading;
  initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromAsset(biographie);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  void initState() {
    initPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : PDFViewer(
            document: _doc,
            showPicker: false,
            showIndicator: false,
          );
  }
}

class AppPropo extends StatefulWidget {
  @override
  _AppPropoState createState() => _AppPropoState();
}

class _AppPropoState extends State<AppPropo> {
  String biographie = "images/about.pdf";
  PDFDocument _doc;
  bool _loading;
  initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromAsset(biographie);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  void initState() {
    initPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : PDFViewer(
            document: _doc,
            showPicker: false,
            showIndicator: false,
          );
  }
}

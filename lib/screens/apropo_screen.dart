import 'package:flutter/material.dart';
import 'package:projet_tafsir/constant/constant.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class Apropos extends StatefulWidget {
  @override
  _AproposState createState() => _AproposState();
}

class _AproposState extends State<Apropos> {
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
        backgroundColor: Colors.white38,
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

class AppPropo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
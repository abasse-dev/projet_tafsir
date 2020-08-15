import 'package:flutter/material.dart';
import 'package:projet_tafsir/constant/constant.dart';

class ActiveDownload extends StatefulWidget {
  @override
  _ActiveDownloadState createState() => _ActiveDownloadState();
}

class _ActiveDownloadState extends State<ActiveDownload> {
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10.0,),
              Text(
                'Telechargement de tafsir Assise 001',
                style:
                    TextStyle(color: colorAmber, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0,),
              LinearProgressIndicator(
                minHeight: 5.0,
                value: 50/100,
              ),
              SizedBox(height: 5.0,),
              Text('50%',style: TextStyle(color: colorAmber),),
              SizedBox(height: 5.0,),
              GestureDetector(
                child: Text('Telecharger',style: TextStyle(color: accentColor,fontWeight: FontWeight.bold),),
              )
              ]
          )
        ],
      ),
    );
  }
}

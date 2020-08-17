import 'package:flutter/material.dart';
import 'package:projet_tafsir/components/drawer_component.dart';
import 'package:projet_tafsir/constant/constant.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _listTafsir = ['télécharger tafsir'];

  //final AudioPlayer player = AudioPlayer(playerId: 'tafsr');
  AudioPlayer player;
  Duration _duree = Duration(seconds: 0);
  Duration _position = Duration(seconds: 0);
  AudioPlayerState _playerState;
  bool _isPaused = true;
  bool _isLoop = true;
  int _index = 0;

  String _getTimeFormat(Duration d) {
    return d.toString().split('.').first;
  }

  _playPrevious() {
    if (_index > 0) {
      _index--;
      _playLocal(_listTafsir[_index]);
    } else {
      _index = _listTafsir.length - 1;
      _playLocal(_listTafsir[_index]);
    }
  }

  _playNext() {
    if (_index < _listTafsir.length - 1) {
      _index++;
      _playLocal(_listTafsir[_index]);
    } else {
      _index = 0;
      _playLocal(_listTafsir[_index]);
    }
  }

  _playLocal(String path) async {
    await player.stop();
    try {
      if (_listTafsir[0] == 'télécharger tafsir') return;
      await player.play(path, isLocal: true, stayAwake: true);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  _playPause() async {
    switch (_playerState) {
      case AudioPlayerState.PLAYING:
        await player.pause();
        setState(() {
          _isPaused = true;
        });
        break;
      case AudioPlayerState.PAUSED:
        await player.resume();
        setState(() {
          _isPaused = false;
        });
        break;
      default:
        _playLocal(_listTafsir[_index]);
        setState(() {
          _isPaused = false;
        });
        break;
    }
  }

  _configAudioPlayer() {
    player = AudioPlayer(playerId: 'tafsir');
    player.onAudioPositionChanged.listen((event) {
      setState(() {
        _position = event;
      });
    });

    player.onDurationChanged.listen((event) {
      setState(() {
        _duree = event;
      });
    });

    player.onPlayerStateChanged.listen((event) {
      setState(() {
        _playerState = event;
      });
    });

    player.onPlayerCompletion.listen((event) {
      if (_isLoop) {
        _playNext();
      } else {
        setState(() {
          _isPaused = true;
        });
      }
    });

    player.onPlayerError.listen((event) {
      setState(() {
        _duree = Duration(seconds: 0);
        _position = Duration(seconds: 0);
        _playerState = AudioPlayerState.STOPPED;
      });
    });
  }

  _fitchListTafsir() async {
    var dir = await getExternalStorageDirectory();
    List<String> listTafsir = [];
    dir.listSync(recursive: true).map((e) {
      if (e.path.contains('Assise')) listTafsir.add(e.path);
    }).toList();
    setState(() {
      listTafsir.length == 0
          ? _listTafsir = ['télécharger tafsir']
          : _listTafsir = listTafsir;
      _listTafsir.sort((a, b) => a.compareTo(b));
    });
  }

  @override
  void initState() {
    _configAudioPlayer();
    _fitchListTafsir();
    super.initState();
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

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
      backgroundColor: Colors.white12,
      drawer: DrawerComponent(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: hauter / 30,
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage("images/youssouf1.jpg"),
                radius: larger / 2.5,
              ),
            ),
            SizedBox(
              height: hauter / 35,
            ),
            Text(
              "Cheikh El Hadj Youssoufou OUEDRAOGO",
              style: TextStyle(
                  color: colorAmber,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: hauter / 25,
            ),
            Text(
              "Tafsir ${_listTafsir[_index].split('/').last.split('.').first}" ??
                  '',
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
                      color: _isLoop ? accentColor : colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {
                      setState(() {
                        _isLoop = !_isLoop;
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {
                      _playPrevious();
                    }),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: _isPaused
                        ? Icon(
                            Icons.play_circle_outline,
                            color: colorAmber,
                            size: larger / 10,
                          )
                        : Icon(
                            Icons.pause_circle_outline,
                            color: colorAmber,
                            size: larger / 10,
                          ),
                    onPressed: () {
                      switch (_playerState) {
                        case AudioPlayerState.STOPPED:
                          return _playLocal(_listTafsir[_index]);
                          break;
                        default:
                          return _playPause();
                          break;
                      }
                    }),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {
                      _playNext();
                    }),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.playlist_play,
                      color: colorAmber,
                      size: larger / 10,
                    ),
                    onPressed: () {
                      _showMyDialog();
                    }),
              ],
            ),
            SizedBox(
              height: hauter / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Text(
                  _getTimeFormat(_position),
                  style: TextStyle(color: colorAmber),
                )),
                Container(
                    width: larger / 1.5,
                    child: Slider(
                      value: _position.inSeconds.toDouble(),
                      max: _duree.inSeconds.toDouble(),
                      activeColor: Colors.blue,
                      inactiveColor: colorAmber,
                      onChanged: (value) {
                        player.seek(Duration(seconds: value.toInt()));
                      },
                    )),
                Container(
                    child: Text(
                  _getTimeFormat(_duree),
                  style: TextStyle(color: colorAmber),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white38,
          title: Text(
            'Play List',
            style: TextStyle(color: colorAmber),
          ),
          content: ListView.builder(
              itemCount: _listTafsir.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(
                      'Tafsir ${_listTafsir[index].split('/').last.split('.').first}' ??
                          '',
                      style: TextStyle(
                          color: colorAmber, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() {
                        _index = index;
                        _isPaused = false;
                      });
                      _playLocal(_listTafsir[index]);
                    },
                  )),
          actions: <Widget>[
            FlatButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

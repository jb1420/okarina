// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKARINA Page',
      home: const MyHomePage(title: 'OKARINA Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<void> _loadingFuture;
  final List<String> notes = [
    'C4.mp3',
    'D4.mp3',
    'E4.mp3',
    'F4.mp3',
    'G4.mp3',
    'A4.mp3',
    'B4.mp3',
    'C5.mp3',
    'D5.mp3',
  ];
  List<AudioPlayer> players = [];

  var color1 = Colors.blue;
  var color2 = Colors.blue;

  var clicked_list = [0,0,0,0,0];

  var nowPlaying = 0;

  void playSound() async{
    var exPlayed = nowPlaying;

    if(ListEquality().equals(clicked_list, [0,1,1,1,1])){
      players[0].resume();
      nowPlaying = 0;
    }
    else if(ListEquality().equals(clicked_list, [0,1,1,0,1])){
      players[1].resume();
      nowPlaying = 1;
    }
    else if(ListEquality().equals(clicked_list, [0,1,1,1,0])){
      players[2].resume();
      nowPlaying = 2;
    }
    else if(ListEquality().equals(clicked_list, [0,1,1,0,0])){
      players[3].resume();
      nowPlaying = 3;
    }
    else if(ListEquality().equals(clicked_list, [0,0,1,0,1])){
      players[4].resume();
      nowPlaying = 4;
    }
    else if(ListEquality().equals(clicked_list, [0,0,1,0,0])){
      players[5].resume();
      nowPlaying = 5;
    }
    else if(ListEquality().equals(clicked_list, [0,0,0,1,0])){
      players[6].resume();
      nowPlaying = 6;
    }
    else if(ListEquality().equals(clicked_list, [1,0,0,0,0])){
      players[7].resume();
      nowPlaying = 7;
    }
    else if(ListEquality().equals(clicked_list, [0,1,0,0,0])){
      players[8].resume();
      nowPlaying = 8;
    }

    players[exPlayed].pause();

  }


  @override
  void initState() {
    super.initState();
    _loadingFuture = _loadData();
  }

  Future<void> _loadData() async {
    for (var note in notes){
      AudioPlayer player = AudioPlayer();
      player.setPlayerMode(PlayerMode.lowLatency);
      await player.setSource(AssetSource(note));
      player.resume();
      player.pause();
      players.add(player);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<void>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading assets'),
            );
          } else {
            return buildMainContent(context);
          }
        },
      ),
    );
  }

  Widget buildMainContent(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 400,
            ),
            Positioned(
              left: 74,
              top: 0,
              width: 60,
              height: 60,
              child: GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    clicked_list[0] = 1;
                  });
                  playSound();
                },
                onTapUp: (details) {
                  setState(() {
                    clicked_list[0] = 0;
                  });
                  playSound();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    color: clicked_list[0]==1 ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 104,
              top: 151,
              width: 70,
              height: 70,
              child: GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    clicked_list[1] = 1;
                  });
                  playSound();
                },
                onTapUp: (details) {
                  setState(() {
                    clicked_list[1] = 0;
                  });
                  playSound();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    color: clicked_list[1]==1 ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 64,
              bottom: 0,
              width: 80,
              height: 80,
              child: GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    clicked_list[2] = 1;
                  });
                  playSound();
                },
                onTapUp: (details) {
                  setState(() {
                    clicked_list[2] = 0;
                  });
                  playSound();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    color: clicked_list[2]==1 ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
            ),



            Positioned(
              right: 78,
              top: 50,
              width: 70,
              height: 70,
              child: GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    clicked_list[3] = 1;
                  });
                  playSound();
                },
                onTapUp: (details) {
                  setState(() {
                    clicked_list[3] = 0;
                  });
                  playSound();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    color: clicked_list[3]==1 ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 64,
              bottom: 86,
              width: 75,
              height: 75,
              child: GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    clicked_list[4] = 1;
                  });
                  playSound();
                },
                onTapUp: (details) {
                  setState(() {
                    clicked_list[4] = 0;
                  });
                  playSound();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  decoration: BoxDecoration(
                    color: clicked_list[4]==1 ? Colors.red : Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

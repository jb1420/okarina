// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  var closed = [0, 0, 0, 0, 0];
  late AudioCache cache;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    cache = AudioCache(prefix: 'assets/',);
    player.setPlayerMode(PlayerMode.lowLatency);
    preloadAudio();
  }

  void preloadAudio(){
    cache.loadAll(['C4.mp3', 'D4.mp3', 'E4.mp3', 'F4.mp3', 'G4.mp3', 'A4.mp3', 'B4.mp3', 'C5.mp3', 'D5.mp3']);
  }


  String note() {
    var result = 'NOTHING'; // 기본 결과
    player.pause();

    if (closed.toString() == [0,1,1,1,1].toString()) {
      player.play(AssetSource('C4.mp3'));
      result = 'C4';
    } else if (closed.toString() == [0,1,1,0,1].toString()) {
      player.play(AssetSource('D4.mp3'));
      result = 'D4';
    } else if (closed.toString() == [0,1,1,1,0].toString()) {
      player.play(AssetSource('E4.mp3'));
      result = 'E4';
    } else if (closed.toString() == [0,1,1,0,0].toString()) {
      player.play(AssetSource('F4.mp3'));
      result = 'F4';
    } else if (closed.toString() == [0,0,1,0,1].toString()) {
      player.play(AssetSource('G4.mp3'));
      result = 'G4';
    } else if (closed.toString() == [0,0,1,0,0].toString()) {
      player.play(AssetSource('A4.mp3'));
      result = 'A4';
    } else if (closed.toString() == [0,0,0,1,0].toString()) {
      player.play(AssetSource('B4.mp3'));
      result = 'B4';
    } else if (closed.toString() == [1,0,0,0,0].toString()) {
      player.play(AssetSource('C5.mp3'));
      result = 'C5';
    } else if (closed.toString() == [0,1,0,0,0].toString() || closed.toString() == [1,1,0,0,0].toString()) {
      player.play(AssetSource('D5.mp3'));
      result = 'D5';
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              '${closed} ${note()}',
              style: TextStyle(fontSize: 30),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTapDown: (a1) {
                        setState(() {
                          closed[0] = 1;
                        });
                      },
                      onTapUp: (a) {
                        setState(() {
                          closed[0] = 0;
                        });
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(40),
                          color: closed[0] == 1 ? Colors.red : Colors.blue,
                          child: Text("1")),
                    ),
                    GestureDetector(
                      onTapDown: (a2) {
                        setState(() {
                          closed[1] = 1;
                        });
                      },
                      onTapUp: (a) {
                        setState(() {
                          closed[1] = 0;
                        });
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(40),
                          color: closed[1] == 1 ? Colors.red : Colors.blue,
                          child: Text("2")),
                    ),
                    GestureDetector(
                      onTapDown: (a3) {
                        setState(() {
                          closed[2] = 1;
                        });
                      },
                      onTapUp: (a) {
                        setState(() {
                          closed[2] = 0;
                        });
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(40),
                          color: closed[2] == 1 ? Colors.red : Colors.blue,
                          child: Text("3")),
                    ),
                  ]),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTapDown: (a4) {
                        setState(() {
                          closed[3] = 1;
                        });
                      },
                      onTapUp: (a) {
                        setState(() {
                          closed[3] = 0;
                        });
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(40),
                          color: closed[3] == 1 ? Colors.red : Colors.blue,
                          child: Text("4")),
                    ),
                    GestureDetector(
                      onTapDown: (a5) {
                        setState(() {
                          closed[4] = 1;
                        });
                      },
                      onTapUp: (a) {
                        setState(() {
                          closed[4] = 0;
                        });
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(40),
                          color: closed[4] == 1 ? Colors.red : Colors.blue,
                          child: Text("5")),
                    ),
                  ])
            ])
          ]),
        ));
  }
}

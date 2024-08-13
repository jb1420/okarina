import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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

  @override
  void initState() {
    super.initState();
    _loadingFuture = _loadData();
  }

  Future<void> _loadData() async {
    for (var note in notes){
      var player = AudioPlayer();
      await player.setSource(AssetSource("assets/$note"));  // 요기가 문제임
      // player.resume();
      // player.pause();
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
              // color: Colors.white,
              width: double.infinity,
              height: 400,
            ),
            Positioned(
              left: 74,
              top: 0,
              width: 60,
              height: 60,
              child: GestureDetector(
                onPanDown: (details) {
                  // resume
                },
                onPanEnd: (details) {
                  // pause
                  // stop
                  // resume
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
            Positioned(
              left: 64,
              bottom: 0,
              width: 80,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
              ),
            ),



            Positioned(
              right: 78,
              top: 50,
              width: 70,
              height: 70,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
            Positioned(
              right: 64,
              bottom: 86,
              width: 75,
              height: 75,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

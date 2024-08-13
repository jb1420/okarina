import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKARINA Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
  var closed = [0, 0, 0, 0, 0];
  var ex_note = 0;
  final Map<String, AudioPlayer> players = {};
  final List<String> notes = [
    'C4.mp3',
    'D4.mp3',
    'E4.mp3',
    'F4.mp3',
    'G4.mp3',
    'A4.mp3',
    'B4.mp3',
    'C5.mp3',
    'D5.mp3'
  ];

  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = preloadAudio();
  }

  Future<void> preloadAudio() async {
    for (var note in notes) {
      var player = AudioPlayer();
      await player.setAsset('assets/$note');
      players[note] = player;
    }
  }

  void playNote(String note)  {
    var player = players[note];
    if (player != null) {
      player.play(); // Play the note
    }
  }

  void stopNote() {
    var player = players[ex_note];
    if (player != null) {
      player.stop(); // Stop the note
    }
  }

  String getNote() {
    var result = 'NOTHING';

    if (closed.toString() == [0, 1, 1, 1, 1].toString()) {
      result = 'C4';
    } else if (closed.toString() == [0, 1, 1, 0, 1].toString()) {
      result = 'D4';
    } else if (closed.toString() == [0, 1, 1, 1, 0].toString()) {
      result = 'E4';
    } else if (closed.toString() == [0, 1, 1, 0, 0].toString()) {
      result = 'F4';
    } else if (closed.toString() == [0, 0, 1, 0, 1].toString()) {
      result = 'G4';
    } else if (closed.toString() == [0, 0, 1, 0, 0].toString()) {
      result = 'A4';
    } else if (closed.toString() == [0, 0, 0, 1, 0].toString()) {
      result = 'B4';
    } else if (closed.toString() == [1, 0, 0, 0, 0].toString()) {
      result = 'C5';
    } else if (closed.toString() == [0, 1, 0, 0, 0].toString() ||
        closed.toString() == [1, 1, 0, 0, 0].toString()) {
      result = 'D5';
    }

    playNote('$result.mp3');
    stopNote();
    ex_note = notes.indexOf(result + '.mp3');
    return result;
  }

  void updateButtonState(int index, bool isPressed) {
    setState(() {
      closed[index] = isPressed ? 1 : 0;
    });
    getNote(); // Play the note immediately when the button state changes
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
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonSize = constraints.maxWidth < 600 ? 80 : 120;
        double spacing = constraints.maxWidth < 600 ? 40 : 60;
        double columnSpacing = constraints.maxWidth < 600 ? 40 : 80;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Note: ${getNote()}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: columnSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 3; i++) ...[
                        GestureDetector(
                          onTapDown: (_) {
                            updateButtonState(i, true);
                          },
                          onTapUp: (_) {
                            updateButtonState(i, false);
                          },
                          onTapCancel: () {
                            updateButtonState(i, false);
                          },
                          onPanEnd: (_) {
                            updateButtonState(i, false);
                          },
                          child: Container(
                            width: buttonSize,
                            height: buttonSize,
                            margin: EdgeInsets.all(spacing / 2),
                            decoration: BoxDecoration(
                              color: closed[i] == 1 ? Colors.blueAccent : Colors.blue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: buttonSize / 2.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: spacing),
                      ],
                    ],
                  ),
                  SizedBox(width: columnSpacing),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 3; i < 5; i++) ...[
                        GestureDetector(
                          onTapDown: (_) {
                            updateButtonState(i, true);
                          },
                          onTapUp: (_) {
                            updateButtonState(i, false);
                          },
                          onTapCancel: () {
                            updateButtonState(i, false);
                          },
                          onPanEnd: (_) {
                            updateButtonState(i, false);
                          },
                          child: Container(
                            width: buttonSize,
                            height: buttonSize,
                            margin: EdgeInsets.all(spacing / 2),
                            decoration: BoxDecoration(
                              color: closed[i] == 1 ? Colors.blueAccent : Colors.blue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: buttonSize / 2.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (i == 3) SizedBox(height: spacing),
                      ],
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

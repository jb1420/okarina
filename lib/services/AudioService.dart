import 'package:audioplayers/audioplayers.dart';

class Audio {
  List<String> notes = [
    'G4.mp3',
    'G#4.mp3',
    'A4.mp3',
    'A#4.mp3',
    'B4.mp3',
    'C5.mp3',
    'C#5.mp3',
    'D5.mp3',
    'D#5.mp3',
    'E5.mp3',
    'F5.mp3',
    'F#5.mp3',
    'G5.mp3',
    'G#5.mp3',
    'A5.mp3',
    'A#5.mp3',
    'B5.mp3',
    'C6.mp3',
    'C#6.mp3',
    'D6.mp3',
    'D#6.mp3',
    'E6.mp3',
    'F6.mp3',
    'F#6.mp3',
    'G6.mp3',
    'G#6.mp3',
    'A6.mp3',
    'A#6.mp3',
    'B6.mp3',
    'C7.mp3',
    'C#7.mp3',
    'D7.mp3',
    'D#7.mp3',
  ];

  Map<int, List<int>> fingers = {
    5: [0, 1, 1, 1, 1],
    7: [0, 1, 1, 0, 1],
    9: [0, 1, 1, 1, 0],
    10: [0, 1, 1, 0, 0],
    11: [0, 0, 1, 1, 1],
    12: [0, 0, 1, 0, 1],
    13: [0, 0, 1, 1, 0],
    14: [0, 0, 1, 0, 0],
    4: [0, 1, 0, 1, 1],
    20: [0, 1, 0, 0, 1],
    8: [0, 1, 0, 1, 0],
    19: [0, 1, 0, 0, 0],
    0: [0, 0, 0, 1, 1],
    15: [0, 0, 0, 0, 1],
    16: [0, 0, 0, 1, 0],
    17: [1, 0, 0, 0, 0]
  };

  List<AudioPlayer> players = [];

  var clickedList = [0, 0, 0, 0, 0];
  var nowPlaying = 0;

  var settingOpened = false;

  var loadedNum = 0;

  var scaleList = [
    'C',
    'C#',
    'D',
    'D#',
    'E',
    'F',
    'F#',
    'G',
    'G#',
    'A',
    'A#',
    'B'
  ];
  var nowScale = 0; // C
  void increaseScale(){
    if(nowScale != 11){
      nowScale++;
    }
  }
  void decreaseScale(){
    if(nowScale != 0){
      nowScale--;
    }
  }

  double volume = 0.70;
  void changeVolume(double v) {
    volume = v;
    playSound();
  }

  void playSound() async {
    var exPlayed = nowPlaying;

    players[exPlayed].pause();

    for (var i in fingers.keys) {
      bool equal = true;
      for (int j = 1; j < 5; j++) {
        if (clickedList[j] != fingers[i]?[j]) {
          equal = false;
        }
      }
      if (i == 17) {
        if (clickedList[0] == 0) equal = false;
      }
      if (equal) {
        nowPlaying = i + nowScale;
        players[nowPlaying].setVolume(volume);
        players[nowPlaying].resume();
      }
    }
  }

  @override
  Future<String> initState() async {
    print("INIT!!!!!!!");
    for (int i = 0; i < notes.length; i++) {
      players.add(AudioPlayer());
      players[i].setPlayerMode(PlayerMode.lowLatency);
      players[i].setReleaseMode(ReleaseMode.loop);
      await players[i].setSource(AssetSource('audio/${notes[i]}'));
      print(notes[i] + " COMPLETE");
    }
    return "complete";
    // loadData();
  }

  void shutDown(){
    for (var player in players){
      player.stop();
    }
  }

  // Future<void> loadData() async {
  //   print("Start Loading Audio Assets");
  //   try {
  //     for (int i = 0; i < notes.length; i += 3) {
  //       // 3개씩 가져오기
  //       var futures = List.generate(3, (index) {
  //         if (i + index < notes.length) {
  //           return players[i + index]
  //               .setSource(AssetSource('audio/${notes[i + index]}')
  //           );
  //         }
  //         return Future.value(); // 인덱스 초과 시 빈 Future 반환
  //       });
  //
  //       // 3개씩 로딩 완료할 때까지 기다리기
  //       await Future.wait(futures);
  //     }
  //   } catch (e) {
  //     print('ERROR: $e');
  //   }
  //   print("Finish Loading Audio Assets");
  // }

}
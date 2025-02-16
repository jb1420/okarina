import 'package:flutter/material.dart';
import '../widgets/MainScreen/PlayButtonWidget.dart';
import '../services/AudioService.dart';
import '../utilities/UI.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.audio, required this.ui});

  final Audio audio;
  final UIConstants ui;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ui.bgColor, // UI에서 배경색 가져오기
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            // color: Colors.red,
            child: Stack(
              children: [
                Positioned(
                  left: 100,
                  top: 200,
                  child: PlayButton(id: 0, size: 60, audio: audio, ui: ui),
                ),
                Positioned(
                  left: 100,
                  top: 300,
                  child: PlayButton(id: 1, size: 50, audio: audio, ui: ui),
                ),
                Positioned(
                  left: 100,
                  top: 400,
                  child: PlayButton(id: 2, size: 60, audio: audio, ui: ui),
                ),
                Positioned(
                  right: 100,
                  top: 250,
                  child: PlayButton(id: 3, size: 40, audio: audio, ui: ui),
                ),
                Positioned(
                  right: 100,
                  top: 350,
                  child: PlayButton(id: 4, size: 50, audio: audio, ui: ui),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/settings');
              if (result != null) {
                (context as Element).markNeedsBuild(); // 간단하게 화면을 다시 그리기 위해 사용
              }
              print(audio.players.toString());
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // 앱이 백그라운드로 갈 때 오디오 중지
      audio.shutDown();
    }
  }
}

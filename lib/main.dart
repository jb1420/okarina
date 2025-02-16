import 'package:flutter/material.dart';

import 'screens/LoadingScreen.dart';
import 'screens/MainScreen.dart';
import 'screens/SettingScreen.dart';

import 'services/AudioService.dart';
import 'utilities/UI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Audio audio = Audio();
  final UIConstants ui = UIConstants();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MainScreen(audio: audio, ui: ui),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => LoadingScreen(audio: audio, ui: ui),
        '/main': (context) => MainScreen(audio: audio, ui: ui),
        '/settings': (context) => SettingScreen(audio: audio, ui: ui),
      },
    );
  }
}

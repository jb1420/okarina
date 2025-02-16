import 'package:flutter/material.dart';

import 'package:cleancode_okarina/services/AudioService.dart';
import 'package:cleancode_okarina/utilities/UI.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key,
    required this.ui,
    required this.audio,
  });

  final UIConstants ui;
  final Audio audio;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: widget.audio.initState(),
      builder: (context, snapshot) {
        // 로딩중
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
            color: widget.ui.bgColor,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: widget.ui.bgColor,
                color: widget.ui.color1,
              ),
            ),
          );
        }
        // 에러 처리
        else if(snapshot.hasError){
          return Dialog(
            child: Center(
              child: Text("Please Restart the Application...\n ${snapshot.error}")
            ),
          );
        }
        // 로딩 완료
        else if(snapshot.hasData){
          print("ALL FINISHED");

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/main');
          });
        }

        return Container();
      },
    );
  }
}


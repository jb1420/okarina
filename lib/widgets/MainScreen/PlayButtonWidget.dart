import 'package:flutter/material.dart';
import '../../services/AudioService.dart';
import '../../utilities/UI.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key, 
    required this.id,
    required this.size,
    required this.audio,
    required this.ui,
  });

  final int id;
  final double size;
  final Audio audio;
  final UIConstants ui;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          widget.audio.clickedList[widget.id] = 1;
        });
        widget.audio.playSound();
        print("clickedList : ${widget.audio.clickedList}");
      },
      onPanEnd: (details) {
        setState(() {
          widget.audio.clickedList[widget.id] = 0;
        });
        widget.audio.playSound();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.audio.clickedList[widget.id] == 1
                ? widget.ui.color2
                : widget.ui.color1,
            borderRadius: const BorderRadius.all(Radius.circular(35)),
            boxShadow: widget.ui.useGlow
              ? [
                BoxShadow(
                  color: widget.audio.clickedList[widget.id] == 1
                    ? widget.ui.color2.withValues(alpha:0.6)
                    : widget.ui.color1.withValues(alpha:0.6),
                  blurRadius: 25,
                  spreadRadius: 5,
                ),
              ]
              : []
          ),
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  color: widget.ui.bgColor,
                  width: 4,
                )),
          )),
    );
  }
}

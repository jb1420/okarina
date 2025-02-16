import 'package:flutter/material.dart';

import 'package:cleancode_okarina/services/AudioService.dart';
import 'package:cleancode_okarina/utilities/UI.dart';

class SettingScaleWidget extends StatefulWidget {
  const SettingScaleWidget({super.key,
    required this.audio
  });

  final Audio audio;

  @override
  State<SettingScaleWidget> createState() => _SettingScaleWidgetState();
}

class _SettingScaleWidgetState extends State<SettingScaleWidget> {
  @override
  Widget build(BuildContext context) {
    return SettingContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => setState(() {
              widget.audio.decreaseScale();
            }),
            icon: const Icon(Icons.arrow_left)
          ),

          Text(
            widget.audio.nowScale - 2 >= 0
                ? widget.audio.scaleList[widget.audio.nowScale-2]
                : "  ",
            style: const TextStyle(color: Colors.grey, fontSize: 30),
          ),
          Text(
            widget.audio.nowScale - 1 >= 0
                ? widget.audio.scaleList[widget.audio.nowScale-1]
                : "  ",
            style: const TextStyle(color: Colors.grey, fontSize: 30),
          ),

          Text(
            widget.audio.scaleList[widget.audio.nowScale],
            style: const TextStyle(color: Colors.black, fontSize: 50),
          ),

          Text(
            widget.audio.nowScale + 1 < 12
                ? widget.audio.scaleList[widget.audio.nowScale+1]
                : "  ",
            style: const TextStyle(color: Colors.grey, fontSize: 30),
          ),          Text(
            widget.audio.nowScale + 2 < 12
                ? widget.audio.scaleList[widget.audio.nowScale+2]
                : "  ",
            style: const TextStyle(color: Colors.grey, fontSize: 30),
          ),

          IconButton(
            onPressed: () => setState(() {
              widget.audio.increaseScale();
            }),
            icon: const Icon(Icons.arrow_right)
          )
        ],
      )
    );
  }
}

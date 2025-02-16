import 'package:flutter/material.dart';

import 'package:cleancode_okarina/services/AudioService.dart';
import 'package:cleancode_okarina/utilities/UI.dart';

class SettingVolumeWidget extends StatefulWidget {
  const SettingVolumeWidget({super.key,
    required this.audio
  });

  final Audio audio;

  @override
  State<SettingVolumeWidget> createState() => _SettingVolumeWidgetState();
}

class _SettingVolumeWidgetState extends State<SettingVolumeWidget> {

  @override
  Widget build(BuildContext context) {
    return SettingContainer(
      child: SliderTheme(
        data: SliderThemeData(
          overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
          trackHeight: 2.0
        ),
        child: Slider(
          min: 0.00,
          max: 1.00,
          value: widget.audio.volume,
          onChanged: (double val){
            setState(() {
              widget.audio.volume = val;
            });
          },
          activeColor: Colors.black,
          inactiveColor: Colors.black26,

        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../services/AudioService.dart';
import '../utilities/UI.dart';
import '../widgets/SettingScreen/export.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key,
    required this.audio,
    required this.ui,
  });

  final Audio audio;
  final UIConstants ui;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        shadowColor: Colors.black,
        scrolledUnderElevation: 10,
        centerTitle: true,
        toolbarHeight: 90,
        title: Container(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Settings',
            style: widget.ui.textStyle1,
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){Navigator.pop(context, widget.ui);},
              icon: const Icon(Icons.close)
          )
        ],
      ),

      body: SingleChildScrollView(
        // padding: EdgeInsets.only(top: 90),

        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Note", style: widget.ui.textStyle2,),
                  Text("Change the key of the ocarina", style: widget.ui.textStyle3,),
                  SettingScaleWidget(audio: widget.audio)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Volume", style: widget.ui.textStyle2,),
                  Text("Adjust the volume", style: widget.ui.textStyle3,),
                  SettingVolumeWidget(audio: widget.audio)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Theme", style: widget.ui.textStyle2,),
                  Text("Change theme of the app", style: widget.ui.textStyle3,),
                  SettingColorWidget(ui: widget.ui)
                ],
              ),
            ),
          ],
        ),
      )

    );
  }
}

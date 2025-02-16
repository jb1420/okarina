import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:cleancode_okarina/services/AudioService.dart';
import 'package:cleancode_okarina/utilities/UI.dart';

class SettingColorWidget extends StatefulWidget {
  const SettingColorWidget({super.key,
    required this.ui
  });

  final UIConstants ui;

  @override
  State<SettingColorWidget> createState() => _SettingColorWidgetState();
}

class _SettingColorWidgetState extends State<SettingColorWidget> {
  @override
  Widget build(BuildContext context) {
    return SettingContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Color1",
                style: TextStyle(fontSize: 20,),
              ),
              ColorPickerWidget(ui: widget.ui, name: "color1")
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Color2",
                  style: TextStyle(fontSize: 20,),
                ),
                ColorPickerWidget(ui: widget.ui, name: "color2")
              ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Background",
                style: TextStyle(fontSize: 20,),
              ),
              ColorPickerWidget(ui: widget.ui, name: "bg")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Use Glow",
                style: TextStyle(fontSize: 20),
              ),
              Switch(
                value: widget.ui.useGlow,
                onChanged: (bool value){
                  setState(() {
                    widget.ui.useGlow = value;
                  });
                },
                activeColor: Colors.black,
                inactiveThumbColor: Colors.black,
              )
            ],
          )
        ],
      ),
    );
  }
}


class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key,
    required this.ui,
    required this.name
  });

  final UIConstants ui;
  final String name;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            minimumSize: Size(100, 40),
            backgroundColor: widget.name == "bg" ? widget.ui.bgColor
                : widget.name == "color1" ? widget.ui.color1
                : widget.ui.color2,
        ),
        onPressed: () =>
            showDialog(context: context, builder: (context) {
              return Dialog(
                child: BlockPicker(
                    pickerColor: widget.name == "bg" ? widget.ui.bgColor
                        : widget.name == "color1" ? widget.ui.color1
                        : widget.ui.color2,
                    availableColors: widget.ui.colorList,
                    layoutBuilder: colorLayoutBuilder,
                    itemBuilder: colorItemBuilder,
                    onColorChanged: (color){
                      setState(() {
                        if (widget.name == "bg") {
                          widget.ui.bgColor = color;
                        } else if (widget.name == "color1") {
                          widget.ui.color1 = color;
                        } else {
                          widget.ui.color2 = color;
                        }
                      });
                    }),
              );
            },),
        child: Container()
    );
  }
}

Widget colorLayoutBuilder(BuildContext context, List<Color> colors, PickerItem child) {
  return Container(
    width: 360,
    height: 360,
    color: Colors.white,
    child: GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 5,
      children: [for (Color color in colors) child(color)],
    ),
  );
}


Widget colorItemBuilder(Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: color,
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 210),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(Icons.done, color: useWhiteForeground(color) ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}
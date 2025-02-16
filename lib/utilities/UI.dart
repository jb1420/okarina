import 'package:flutter/material.dart';

class UIConstants {
  Color color1 = Colors.green;
  Color color2 = Colors.red;
  Color bgColor = Colors.white;

  bool useGlow = true;

  var colorList = [
    Colors.white,
    Colors.black,
    Color(0xFF8EA6F7),
    Color(0xFFAED7F8),
    Color(0xFFB1FAE6),
    Color(0xFFADFBB9),
    Color(0xFFF5FB94),
    Color(0xFFE7C18D),
    Color(0xFFE3A278),
    Color(0xFFE1817D),
    Color(0xFFE9A9AC),
    Color(0xFFC998CF),
    Color(0xFF8870C4),
    Color(0xFF6D7AE9),
  ];

  TextStyle textStyle1 = const TextStyle(
      fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black);

  TextStyle textStyle2 = const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold);

  TextStyle textStyle3 = const TextStyle(fontSize: 16, color: Colors.grey);
}

class SettingContainer extends StatelessWidget {
  final Widget child;

  const SettingContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(0,08,0,0),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 0.25)
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: child,
    );
  }
}

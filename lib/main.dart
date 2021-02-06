import 'package:dolarbot_app/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DolarBotApp());
}

class DolarBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DolarBot App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

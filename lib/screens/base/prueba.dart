import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';

class PruebaScreen extends BaseInfoScreen {
  static const String routeName = "/prueba";

  @override
  _PruebaScreenState createState() => _PruebaScreenState();
}

class _PruebaScreenState extends BaseInfoScreenState<PruebaScreen>
    with BaseScreen {
  @override
  String appBarTitle() {
    // TODO: implement appBarTitle
    return "Prueba Base Screen 💪";
  }

  @override
  Widget body() {
    return Text("Hola Vigo!");
  }
}

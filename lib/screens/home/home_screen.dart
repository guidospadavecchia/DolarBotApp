import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseInfoScreen {
  final String title;

  HomeScreen({
    Key key,
    this.title,
  }) : super(key: key, title: title);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseInfoScreenState<HomeScreen> with BaseScreen {
  @override
  showRefreshButton() => false;

  @override
  bool showCalculatorButton() => false;

  @override
  Widget body() {
    return Center(
      child: Text(
        '🏡',
        style: TextStyle(
          fontSize: 80,
        ),
      ),
    );
  }
}

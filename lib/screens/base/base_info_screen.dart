import 'package:flutter/material.dart';

abstract class BaseInfoScreen extends StatefulWidget {
  BaseInfoScreen({
    Key key,
  }) : super(key: key);
}

abstract class BaseInfoScreenState<Page extends BaseInfoScreen>
    extends State<BaseInfoScreen> {
  String appBarTitle();
}

mixin BaseScreen<Page extends BaseInfoScreen> on BaseInfoScreenState<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.pink.shade300],
            ),
          ),
        ),
        title: Text(
          appBarTitle(),
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: body(),
        color: Colors.white,
      ),
    );
  }

  Widget body();
}

import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "DolarBot",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Versión 1.0.0",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Raleway',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/logos/border/logo.png',
              scale: 3.0,
              height: 164,
              width: 164,
              filterQuality: FilterQuality.high,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "© 2021\n\nGuido Spadavecchia\nJuan Manuel Flecha",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Raleway',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DrawerMenuHeader extends StatelessWidget {
  const DrawerMenuHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 20, bottom: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                'assets/images/logo_medium.png',
                scale: 3.0,
                height: 64,
                width: 64,
              ),
              width: 64,
              height: 64,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'DolarBot',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Raleway',
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

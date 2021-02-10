import 'package:flutter/material.dart';

class DrawerMenuHeader extends StatelessWidget {
  const DrawerMenuHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top + 15;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: paddingTop, left: 35, bottom: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/images/logo.png',
                    scale: 3.0,
                    height: 64,
                    width: 64,
                    filterQuality: FilterQuality.high,
                  ),
                  width: 64,
                  height: 64,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Dolar',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway',
                      letterSpacing: 0.5),
                ),
                Text(
                  'Bot',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway',
                      color: Color.fromRGBO(50, 177, 40, 1),
                      letterSpacing: 0.5),
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}

import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class DrawerMenuHeader extends StatelessWidget {
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
                    'assets/images/logos/borderless/logo.png',
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
                      color: ThemeManager.getPrimaryColor(),
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
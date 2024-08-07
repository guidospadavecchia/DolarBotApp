import 'package:flutter/material.dart';

import '../../classes/app_config.dart';
import '../../classes/size_config.dart';
import '../../classes/theme_manager.dart';

class DrawerMenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final paddingTop = SizeConfig.padding.top + 15;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: paddingTop, left: 20, bottom: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image.asset(
                    AppConfig.logo.borderless,
                    scale: 3.0,
                    height: 64,
                    width: 64,
                    filterQuality: FilterQuality.high,
                  ),
                  width: 64,
                  height: 64,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'Dolar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Raleway', letterSpacing: 0.5),
                ),
                Text(
                  'Bot',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Raleway', color: ThemeManager.getPrimaryColor(), letterSpacing: 0.5),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

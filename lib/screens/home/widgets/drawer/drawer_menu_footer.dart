import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/options/options_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:dolarbot_app/widgets/common/social/discord.dart';
import 'package:dolarbot_app/widgets/common/social/github.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:global_configuration/global_configuration.dart';

class DrawerMenuFooter extends StatelessWidget {
  final cfg = GlobalConfiguration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Divider(),
            MenuItem(
              text: "Opciones",
              leading: Icon(FontAwesomeIcons.cog,
                  color: ThemeManager.getDrawerMenuItemIconColor(context)),
              depthLevel: 1,
              onTap: () => {
                Navigator.of(context).popAndPushNamed(OptionsScreen.routeName),
              },
            ),
            MenuItem(
              text: "Salir",
              leading: Icon(FontAwesomeIcons.signOutAlt,
                  color: ThemeManager.getDrawerMenuItemIconColor(context)),
              depthLevel: 1,
              onTap: () => {
                exit(0),
              },
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                  ? Colors.blueGrey[50]
                  : Colors.grey[900],
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Discord(),
                  SizedBox(width: 30),
                  GitHub(),
                ],
              ),
            ),
            _getSloganFlutter(context),
          ],
        ),
      ),
    );
  }

  Container _getSloganFlutter(BuildContext context) {
    return Container(
      height: 30,
      color: ThemeManager.getDrawerMenuFooterSloganBackgroundColor(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BUILT WITH 💙 IN ",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.black87,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/general/flutter.png',
              width: 16, height: 16, filterQuality: FilterQuality.high),
        ],
      ),
    );
  }
}

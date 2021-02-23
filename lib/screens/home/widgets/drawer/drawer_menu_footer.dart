import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/options/options_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:dolarbot_app/widgets/common/social/discord.dart';
import 'package:dolarbot_app/widgets/common/social/github.dart';
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
            Divider(height: 1),
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
          ],
        ),
      ),
    );
  }
}

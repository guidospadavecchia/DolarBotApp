import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../classes/theme_manager.dart';
import '../../screens/options/options_screen.dart';
import '../common/menu_item.dart';

class DrawerMenuFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Divider(),
            MenuItem(
              text: "Opciones",
              leading: Icon(
                FontAwesomeIcons.gear,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              onTap: () => Navigator.of(context).popAndPushNamed(OptionsScreen.routeName),
            ),
            MenuItem(
              text: "Salir",
              leading: Icon(
                FontAwesomeIcons.rightFromBracket,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              onTap: () => exit(0),
            ),
          ],
        ),
      ),
    );
  }
}

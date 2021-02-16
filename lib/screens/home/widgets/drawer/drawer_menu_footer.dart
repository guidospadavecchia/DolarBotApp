import 'dart:io';

import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuFooter extends StatelessWidget {
  const DrawerMenuFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                Navigator.of(context).pushNamed("/o"),
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
          ],
        ),
      ),
    );
  }
}

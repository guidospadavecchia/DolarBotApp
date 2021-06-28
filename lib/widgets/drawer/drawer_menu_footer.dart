import 'dart:io';
import 'package:dolarbot_app/classes/app_config.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/options/options_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:dolarbot_app/widgets/common/pills/pro_pill.dart';
import 'package:dolarbot_app/widgets/common/pro_features/pro_features_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Divider(),
            if (!AppConfig.isProVersion)
              Column(
                children: [
                  MenuItem(
                    text: "DolarBot Pro",
                    leading: Image.asset(
                      "assets/images/general/googleplay.png",
                      width: 24,
                      height: 24,
                      filterQuality: FilterQuality.high,
                    ),
                    trailing: ProPill(),
                    depthLevel: 1,
                    onTap: () => showDialog(context: context, builder: (_) => ProFeaturesDialog()),
                  ),
                  const Divider(),
                ],
              ),
            MenuItem(
              text: "Opciones",
              leading: Icon(
                FontAwesomeIcons.cog,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              onTap: () => Navigator.of(context).popAndPushNamed(OptionsScreen.routeName),
            ),
            MenuItem(
              text: "Salir",
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
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

import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_item.dart';
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
            DrawerMenuItem(
              text: "Opciones",
              leftIcon: FontAwesomeIcons.cog,
              padding: EdgeInsets.only(left: 25),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}

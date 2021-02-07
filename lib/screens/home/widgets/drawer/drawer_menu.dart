import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_header.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerMenuHeader(),
        Divider(),
        DrawerMenuItem(
          text: "Dolar",
          leftIcon: Icon(FontAwesomeIcons.dollarSign),
          onTap: null,
        ),
        DrawerMenuItem(
          text: "Euro",
          leftIcon: Icon(FontAwesomeIcons.euroSign),
          onTap: null,
        ),
        DrawerMenuItem(
          text: "Cripto",
          leftIcon: Icon(FontAwesomeIcons.bitcoin),
          onTap: null,
        )

        //TO DO: DrawerMenuBody
      ],
    );
  }
}

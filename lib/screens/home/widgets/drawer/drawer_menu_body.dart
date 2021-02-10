import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuBody extends StatelessWidget {
  const DrawerMenuBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerMenuItem(
              text: "Dolar",
              leftIcon: FontAwesomeIcons.dollarSign,
              depthLevel: 1,
              subItems: [
                DrawerMenuItem(
                  text: "Oficial",
                  leftIcon: FontAwesomeIcons.accessibleIcon,
                  depthLevel: 2,
                  onTap: null,
                ),
                DrawerMenuItem(
                  text: "Blue",
                  leftIcon: FontAwesomeIcons.accessibleIcon,
                  depthLevel: 2,
                  onTap: null,
                ),
                DrawerMenuItem(
                  text: "Bancos",
                  leftIcon: FontAwesomeIcons.accessibleIcon,
                  depthLevel: 2,
                  onTap: null,
                  subItems: [
                    DrawerMenuItem(
                      text: "Supervielle",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      depthLevel: 3,
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Galicia",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      depthLevel: 3,
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      depthLevel: 3,
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      depthLevel: 3,
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      depthLevel: 3,
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      depthLevel: 3,
                      onTap: null,
                    ),
                  ],
                )
              ],
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Euro",
              leftIcon: FontAwesomeIcons.euroSign,
              depthLevel: 1,
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Real",
              leftIcon: FontAwesomeIcons.question,
              depthLevel: 1,
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Cripto",
              leftIcon: FontAwesomeIcons.ethereum,
              depthLevel: 1,
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Metales",
              leftIcon: FontAwesomeIcons.question,
              depthLevel: 1,
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Indicadores BCRA",
              leftIcon: FontAwesomeIcons.chartLine,
              depthLevel: 1,
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Venezuela",
              leftIcon: FontAwesomeIcons.question,
              depthLevel: 1,
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuBody extends StatelessWidget {
  const DrawerMenuBody({
    Key key,
  }) : super(key: key);

  final double paddingOffset = 25;

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
              padding: _calculatePaddingOffset(1),
              subItems: [
                DrawerMenuItem(
                  text: "Oficial",
                  leftIcon: FontAwesomeIcons.accessibleIcon,
                  padding: _calculatePaddingOffset(2),
                  onTap: null,
                ),
                DrawerMenuItem(
                  text: "Blue",
                  leftIcon: FontAwesomeIcons.accessibleIcon,
                  padding: _calculatePaddingOffset(2),
                  onTap: null,
                ),
                DrawerMenuItem(
                  text: "Bancos",
                  leftIcon: FontAwesomeIcons.piggyBank,
                  padding: _calculatePaddingOffset(2),
                  onTap: null,
                  subItems: [
                    DrawerMenuItem(
                      text: "Supervielle",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      padding: _calculatePaddingOffset(3),
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Galicia",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      padding: _calculatePaddingOffset(3),
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      padding: _calculatePaddingOffset(3),
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      padding: _calculatePaddingOffset(3),
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      padding: _calculatePaddingOffset(3),
                      onTap: null,
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: FontAwesomeIcons.accessibleIcon,
                      padding: _calculatePaddingOffset(3),
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
              padding: _calculatePaddingOffset(1),
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Real",
              leftIcon: FontAwesomeIcons.question,
              padding: _calculatePaddingOffset(1),
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Cripto",
              leftIcon: FontAwesomeIcons.ethereum,
              padding: _calculatePaddingOffset(1),
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Metales",
              leftIcon: FontAwesomeIcons.question,
              padding: _calculatePaddingOffset(1),
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Indicadores BCRA",
              leftIcon: FontAwesomeIcons.chartLine,
              padding: _calculatePaddingOffset(1),
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Venezuela",
              leftIcon: FontAwesomeIcons.question,
              padding: _calculatePaddingOffset(1),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }

  EdgeInsetsGeometry _calculatePaddingOffset(int depthLevel) {
    return EdgeInsets.only(left: depthLevel * paddingOffset, right: 20);
  }
}

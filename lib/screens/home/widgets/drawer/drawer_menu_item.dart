import 'package:dolarbot_app/classes/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final String text;
  final String subtitle;
  final IconData leftIcon;
  final Widget rightIcon;
  final Function onTap;
  final int depthLevel;
  final List<DrawerMenuItem> subItems;

  const DrawerMenuItem(
      {@required this.text,
      this.subtitle,
      @required this.leftIcon,
      this.rightIcon,
      @required this.onTap,
      this.subItems,
      @required this.depthLevel});

  @override
  Widget build(BuildContext context) {
    final double _paddingOffset = 25;

    EdgeInsetsGeometry _calculatePaddingOffset() {
      return EdgeInsets.only(left: depthLevel * _paddingOffset, right: 20);
    }

    return (subItems != null)
        ? Theme(
            data: ThemeManager.getThemeForDrawerMenu(context),
            child: (ExpansionTile(
              tilePadding: _calculatePaddingOffset(),
              title: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                ),
              ),
              leading: Icon(
                leftIcon,
              ),
              trailing: rightIcon,
              subtitle: subtitle != null ? Text(subtitle) : null,
              children: [...subItems],
            )),
          )
        : Theme(
            data: ThemeManager.getThemeForDrawerMenu(context),
            child: (ListTile(
              contentPadding: _calculatePaddingOffset(),
              title: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Raleway',
                ),
              ),
              leading: Icon(
                leftIcon,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              trailing: rightIcon,
              subtitle: subtitle != null ? Text(subtitle) : null,
              onTap: () => onTap(),
            )),
          );
  }
}

import 'package:dolarbot_app/classes/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final String text;
  final String subtitle;
  final IconData leftIcon;
  final Widget rightIcon;
  final Function onTap;
  final EdgeInsetsGeometry padding;
  final List<DrawerMenuItem> subItems;

  const DrawerMenuItem(
      {@required this.text,
      this.subtitle,
      @required this.leftIcon,
      this.rightIcon,
      @required this.onTap,
      this.subItems,
      @required this.padding});

  @override
  Widget build(BuildContext context) {
    return (subItems != null)
        ? (ExpansionTile(
            tilePadding: padding,
            title: Text(
              text,
              style: TextStyle(fontSize: 16, fontFamily: 'Raleway'),
            ),
            leading: Icon(
              leftIcon,
              color: ThemeManager.getDrawerMenuItemIconColor(context),
            ),
            trailing: rightIcon,
            subtitle: subtitle != null ? Text(subtitle) : null,
            children: [...subItems],
          ))
        : (ListTile(
            contentPadding: padding,
            title: Text(
              text,
              style: TextStyle(fontSize: 16, fontFamily: 'Raleway'),
            ),
            leading: Icon(
              leftIcon,
              color: ThemeManager.getDrawerMenuItemIconColor(context),
            ),
            trailing: rightIcon,
            subtitle: subtitle != null ? Text(subtitle) : null,
            onTap: () => onTap(),
          ));
  }
}

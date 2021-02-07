import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final String text;
  final String subtitle;
  final Widget leftIcon;
  final Widget rightIcon;
  final Function onTap;

  const DrawerMenuItem(
      {@required this.text,
      this.subtitle,
      @required this.leftIcon,
      this.rightIcon,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 25),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, fontFamily: 'Raleway'),
      ),
      leading: leftIcon,
      trailing: rightIcon,
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: () => onTap(),
    );
  }
}

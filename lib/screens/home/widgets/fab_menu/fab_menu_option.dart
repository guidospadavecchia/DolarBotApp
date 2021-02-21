import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class FabMenuOption extends StatelessWidget {
  final IconData icon;
  final Function onTap;

  const FabMenuOption({
    Key key,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: ThemeManager.getGlobalAccentColor(context),
        child: InkWell(
          splashColor: Colors.lightGreen[400],
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              icon,
              color: ThemeManager.getGlobalBackgroundColor(context),
            ),
          ),
          onTap: () => onTap(),
        ),
      ),
    );
  }
}

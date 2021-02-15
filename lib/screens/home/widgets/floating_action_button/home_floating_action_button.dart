import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        // decoration: BoxDecoration(
        //     border: Border.all(
        //       color: ThemeManager.getGlobalBackgroundColor(context),
        //       width: 5,
        //     ),
        //     shape: BoxShape.circle),
        child: FloatingActionButton(
          onPressed: () {
            AdaptiveTheme.of(context).toggleThemeMode();
          },
          backgroundColor: ThemeManager.getFloatingActionButtonColor(context),
          foregroundColor: ThemeManager.getGlobalBackgroundColor(context),
          tooltip: 'Opciones',
          elevation: 0,
          child: Icon(Icons.more_horiz),
        ),
      ),
    );
  }

  static FloatingActionButtonLocation getLocation() {
    return FloatingActionButtonLocation.centerFloat;
  }
}

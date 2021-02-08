import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static AdaptiveThemeMode getDefaultTheme() {
    return AdaptiveThemeMode.system;
  }

  static Color getPrimaryTextColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Colors.grey[800]
        : Colors.grey[200];
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Colors.grey[700]
        : Colors.grey[300];
  }

  static Color getDrawerMenuItemIconColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Colors.grey[600]
        : Colors.white;
  }

  static Color getGlobalBackgroundColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Color.fromRGBO(250, 250, 250, 1)
        : Color.fromRGBO(48, 48, 48, 1);
  }

  static Color getFloatingActionButtonColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Colors.green[500]
        : Colors.green[700];
  }

  static ThemeData getLightThemeData() {
    return ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.green[500],
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.grey[700],
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.grey[800],
          ),
          bodyText2: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        dividerColor: Colors.transparent,
        dividerTheme: DividerThemeData(
          color: Colors.grey[400],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.green[200],
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity);
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.green[500],
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.grey[300],
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.grey[200],
          ),
          bodyText2: TextStyle(
            color: Colors.grey[200],
          ),
        ),
        dividerColor: Colors.transparent,
        dividerTheme: DividerThemeData(
          color: Colors.grey[700],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.green[700],
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity);
  }
}

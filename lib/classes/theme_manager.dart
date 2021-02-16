import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeManager {
  static Color primaryColor = Color.fromRGBO(50, 177, 40, 1);
  static Color accentColor = Color.fromRGBO(140, 216, 18, 1);

  static AdaptiveThemeMode getDefaultTheme(BuildContext context) {
    Brightness brightness = SchedulerBinding.instance.window.platformBrightness;

    return brightness == Brightness.light
        ? AdaptiveThemeMode.light
        : AdaptiveThemeMode.dark;
  }

  static Color getPrimaryColor() {
    return primaryColor;
  }

  static Color getAccentColor() {
    return accentColor;
  }

  static Color getPrimaryTextColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Colors.grey[700]
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

  static Color getGlobalAccentColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? primaryColor
        : accentColor;
  }

  static ThemeData getThemeForDrawerMenu(
      BuildContext context, bool disableSplash) {
    return Theme.of(context).copyWith(
      splashColor:
          disableSplash ? Colors.transparent : Theme.of(context).splashColor,
      highlightColor:
          disableSplash ? Colors.transparent : Theme.of(context).highlightColor,
      unselectedWidgetColor: ThemeManager.getDrawerMenuItemIconColor(context),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: ThemeManager.getSecondaryTextColor(context),
          // fontWeight: FontWeight.w600,
        ),
      ),
      dividerColor: Colors.transparent,
    );
  }

  static ThemeData getLightThemeData() {
    return ThemeData(
        primaryColor: getPrimaryColor(),
        accentColor: Colors.green[500],
        brightness: Brightness.light,
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
        primaryColor: getPrimaryColor(),
        accentColor: Colors.green[500],
        brightness: Brightness.dark,
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

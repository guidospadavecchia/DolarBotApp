import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeManager {
  static Color _primaryColor = Color.fromRGBO(50, 177, 40, 1);
  static Color _secondaryColor = Color.fromRGBO(51, 148, 34, 1);
  static Color _accentColor = Color.fromRGBO(140, 216, 18, 1);

  static AdaptiveThemeMode getDefaultTheme(BuildContext context) {
    Brightness brightness = SchedulerBinding.instance.window.platformBrightness;

    return brightness == Brightness.light
        ? AdaptiveThemeMode.light
        : AdaptiveThemeMode.dark;
  }

  static Color getPrimaryColor() {
    return _primaryColor;
  }

  static Color getSecondaryColor() {
    return _secondaryColor;
  }

  static Color getAccentColor() {
    return _accentColor;
  }

  static Color getForegroundColor() {
    return Colors.grey[200];
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

  static Color getDrawerMenuFooterSloganBackgroundColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Colors.blueGrey[900]
        : Colors.black54;
  }

  static Color getButtonColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Color.fromRGBO(230, 230, 230, 1)
        : Color.fromRGBO(50, 50, 50, 1);
  }

  static Color getGlobalBackgroundColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Color.fromRGBO(250, 250, 250, 1)
        : Color.fromRGBO(48, 48, 48, 1);
  }

  static Color getPrimaryAccentColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? _primaryColor
        : _accentColor;
  }

  static Color getHighlightDrawerMenuItem(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Theme.of(context).highlightColor
        : Colors.grey[800];
  }

  static Color getDottedBorderColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
        ? Colors.grey[400]
        : Colors.grey[700];
  }

  static ThemeData getThemeForDrawerMenu(BuildContext context,
      {bool disableHighlight = false}) {
    return Theme.of(context).copyWith(
      accentColor: ThemeManager.getDrawerMenuItemIconColor(context),
      splashColor: Colors.transparent,
      highlightColor: disableHighlight
          ? Colors.transparent
          : getHighlightDrawerMenuItem(context),
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
        accentColor: getAccentColor(),
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
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: getPrimaryColor(),
          selectionHandleColor: getPrimaryColor(),
          cursorColor: getPrimaryColor(),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity);
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
        primaryColor: getPrimaryColor(),
        accentColor: getAccentColor(),
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
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: getSecondaryColor(),
          selectionHandleColor: getSecondaryColor(),
          cursorColor: getSecondaryColor(),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity);
  }
}

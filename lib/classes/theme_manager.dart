import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ThemeManager {
  static Color _primaryColor = const Color.fromRGBO(50, 177, 40, 1);
  static Color _secondaryColor = const Color.fromRGBO(51, 148, 34, 1);
  static Color _accentColor = const Color.fromRGBO(140, 216, 18, 1);

  static AdaptiveThemeMode getDefaultTheme(BuildContext context) {
    Brightness brightness = PlatformDispatcher.instance.platformBrightness;
    return brightness == Brightness.light ? AdaptiveThemeMode.light : AdaptiveThemeMode.dark;
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
    return Colors.grey[200]!;
  }

  static Color getPrimaryTextColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.grey[700]! : Colors.grey[200]!;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.grey[700]! : Colors.grey[300]!;
  }

  static Color getDrawerMenuItemIconColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.grey[600]! : Colors.white;
  }

  static Color getDrawerMenuFooterSloganBackgroundColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.blueGrey[900]! : Colors.black54;
  }

  static Color getButtonColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? const Color.fromRGBO(230, 230, 230, 1) : const Color.fromRGBO(50, 50, 50, 1);
  }

  static Color getSnackBarColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? _secondaryColor : const Color.fromRGBO(60, 60, 60, 1);
  }

  static Color getDividerColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.grey[300]! : Colors.grey[900]!;
  }

  static Color getGlobalBackgroundColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? const Color.fromRGBO(250, 250, 250, 1) : const Color.fromRGBO(48, 48, 48, 1);
  }

  static Color getPrimaryAccentColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? _primaryColor : _accentColor;
  }

  static Color getHighlightDrawerMenuItem(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Theme.of(context).highlightColor : Colors.grey[800]!;
  }

  static Color getLoadingIndicatorColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.grey[400]! : Colors.grey[700]!;
  }

  static Color getAdBorderColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.grey : Colors.black54;
  }

  static Color getAdErrorIconColor(BuildContext context) {
    return AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.white.withOpacity(0.5) : Colors.grey[700]!.withOpacity(0.5);
  }

  static ThemeData getTooltipTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      tooltipTheme: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? _getTooltipThemeLight() : _getTooltipThemeDark(),
    );
  }

  static TooltipThemeData _getTooltipThemeLight() {
    return TooltipThemeData(
      textStyle: const TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black87,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(3)),
        color: Colors.grey[200]!.withOpacity(0.95),
      ),
    );
  }

  static TooltipThemeData _getTooltipThemeDark() {
    return TooltipThemeData(
      textStyle: const TextStyle(
        fontFamily: 'Raleway',
        color: Colors.white70,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(3)),
        color: Colors.grey[800]!.withOpacity(0.95),
      ),
    );
  }

  static ThemeData getThemeForDrawerMenu(BuildContext context, {bool disableHighlight = false}) {
    return Theme.of(context).copyWith(
      splashColor: Colors.transparent,
      highlightColor: disableHighlight ? Colors.transparent : getHighlightDrawerMenuItem(context),
      unselectedWidgetColor: ThemeManager.getDrawerMenuItemIconColor(context),
      dividerColor: Colors.transparent,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ThemeManager.getDrawerMenuItemIconColor(context)),
    );
  }

  static ThemeData getLightThemeData() {
    return ThemeData(
        primaryColor: getPrimaryColor(),
        fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.grey[700],
          ),
        ),
        tooltipTheme: _getTooltipThemeLight(),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.grey[800],
          ),
          bodyMedium: TextStyle(
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(brightness: Brightness.light, secondary: getAccentColor()));
  }

  static ThemeData getDarkThemeData() {
    return ThemeData(
        primaryColor: getPrimaryColor(),
        fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.grey[300],
          ),
        ),
        tooltipTheme: _getTooltipThemeDark(),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.grey[200],
          ),
          bodyMedium: TextStyle(
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
        ).copyWith(secondary: getAccentColor()));
  }
}

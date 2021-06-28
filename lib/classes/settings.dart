import 'package:dolarbot_app/classes/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Settings extends ChangeNotifier {
  static const String CURRENCY_FORMAT_PATTERN = "#,###,##0.00";

  final settings = Hive.box('settings');

  void saveCurrencyFormat(String format) {
    settings.put('currencyFormat', format);
    notifyListeners();
  }

  String getCurrencyFormat() {
    return settings.get('currencyFormat') ?? CurrencyFormats.AR.value;
  }

  void saveIsTagColored(bool isColored) {
    settings.put('isTagColored', isColored);
    notifyListeners();
  }

  bool getTagIsColored() {
    return settings.get('isTagColored') ?? AppConfig.isProVersion;
  }

  void saveFabDirection(Axis direction) {
    settings.put('fabDirection', direction.index);
    notifyListeners();
  }

  Axis getFabDirection() {
    final value = settings.get('fabDirection');
    return value != null
        ? value == 0
            ? Axis.horizontal
            : Axis.vertical
        : Axis.vertical;
  }

  void saveCardGestureDismiss(DismissDirection direction) {
    settings.put('cardGestureDelete', direction.index);
    notifyListeners();
  }

  DismissDirection getCardGestureDismiss() {
    final int indexValue = settings.get('cardGestureDelete') ?? -1;

    switch (indexValue) {
      case 1:
        return DismissDirection.horizontal;
      case 2:
        return DismissDirection.endToStart;
      case 3:
        return DismissDirection.startToEnd;
      default:
        return DismissDirection.endToStart;
    }
  }

  NumberFormat getNumberFormat() {
    return NumberFormat(
      CURRENCY_FORMAT_PATTERN,
      getCurrencyFormat(),
    );
  }

  void notifyThemeChange() {
    notifyListeners();
  }
}

enum CurrencyFormats {
  AR,
  US,
}

extension CurrencyFormatsExtension on CurrencyFormats {
  static const formats = {
    CurrencyFormats.AR: 'es_AR',
    CurrencyFormats.US: 'en_US',
  };

  String get value => formats[this]!;
}

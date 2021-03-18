import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Settings extends ChangeNotifier {
  static const String FORMAT_PATTERN = "#,###,##0.00";

  final settings = Hive.box('settings');

  void saveCurrencyFormat(String format) {
    settings.put('currencyFormat', format);
    notifyListeners();
  }

  String getCurrencyFormat() {
    return settings.get('currencyFormat') ?? CurrencyFormats.AR;
  }

  NumberFormat getNumberFormat() {
    return NumberFormat(
      FORMAT_PATTERN,
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

  String get value => formats[this];
}

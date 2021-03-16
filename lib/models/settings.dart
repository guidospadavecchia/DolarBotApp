import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

class Settings extends ChangeNotifier {
  final settings = Hive.box('settings');

  void saveCurrencyFormat(String format) {
    settings.put('currencyFormat', format);
    notifyListeners();
  }

  String getCurrencyFormat() {
    return settings.get('currencyFormat') ?? "es_AR";
  }

  String getThousandSeparator() {
    return getDecimalSeparator() == "." ? "," : ".";
  }

  String getDecimalSeparator() {
    return (settings.get('currencyFormat') ?? "es_AR") == "es_AR" ? "," : ".";
  }

  String getCurrencyPattern() {
    return "#,###,##0.00";
  }

  Tuple2<NumberFormat, String> getNumberFormat() {
    final format = new NumberFormat(
      getCurrencyPattern(),
      getCurrencyFormat(),
    );
    final decimal = getDecimalSeparator();

    return Tuple2<NumberFormat, String>(format, decimal);
  }

  void notifyThemeChange() {
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class Settings extends ChangeNotifier {
  final settings = Hive.box('settings');

  void saveCurrencyFormat(String format) {
    settings.put('currencyFormat', format);
    notifyListeners();
  }

  String getCurrencyFormat() {
    return settings.get('currencyFormat') ?? "es_AR";
  }

  void notifyThemeChange() {
    notifyListeners();
  }
}

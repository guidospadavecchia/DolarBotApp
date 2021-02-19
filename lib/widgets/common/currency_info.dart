import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CurrencyInfo extends StatelessWidget {
  final String title;
  final String symbol;
  final String value;
  final bool hideDecimals;

  const CurrencyInfo({
    Key key,
    @required this.title,
    this.symbol,
    @required this.value,
    this.hideDecimals = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getTitle(context),
              _getCurrencyValue(context, settings.getCurrencyFormat()),
            ],
          ),
        );
      },
    );
  }

  Text _getTitle(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18,
          fontFamily: 'Raleway',
          color: ThemeManager.getSecondaryTextColor(context),
          fontWeight: FontWeight.normal),
    );
  }

  Padding _getCurrencyValue(BuildContext context, String currencyFormat) {
    final numberFormat = new NumberFormat("#,###,###", currencyFormat);
    final decimalSeparator = currencyFormat == "es_AR" ? "," : ".";

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (symbol != null && isNumeric(value))
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 32,
                    color: ThemeManager.getPrimaryTextColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Text(
              isNumeric(value)
                  ? numberFormat.format(int.parse(value.split('.')[0]))
                  : 'N/A',
              style: TextStyle(
                fontSize: 92,
                color: ThemeManager.getPrimaryTextColor(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (value.split('.').length == 2 && !hideDecimals)
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 38),
                child: Text(
                  '$decimalSeparator${value.split('.')[1].substring(0, 2)}',
                  style: TextStyle(
                    fontSize: 32,
                    color: ThemeManager.getSecondaryTextColor(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

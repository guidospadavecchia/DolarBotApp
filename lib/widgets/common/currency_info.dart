import 'package:dolarbot_app/classes/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyInfo extends StatelessWidget {
  final String title;
  final String symbol;
  final String value;

  const CurrencyInfo({
    Key key,
    @required this.title,
    @required this.symbol,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _getTitle(context),
          _getCurrencyValue(context),
        ],
      ),
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

  Padding _getCurrencyValue(BuildContext context) {
    final currencyFormat = new NumberFormat("#,###,###", "en_US");

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              currencyFormat.format(int.parse(value.split('.')[0])),
              style: TextStyle(
                fontSize: 92,
                color: ThemeManager.getPrimaryTextColor(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 38),
              child: Text(
                '.${value.split('.')[1]}',
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
}

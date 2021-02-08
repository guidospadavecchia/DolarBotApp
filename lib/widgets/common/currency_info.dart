import 'package:dolarbot_app/classes/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class CurrencyInfo extends StatelessWidget {
  final String symbol;
  final String title;
  final String value;

  const CurrencyInfo({
    Key key,
    @required this.symbol,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontSize: 18,
                color: ThemeManager.getSecondaryTextColor(context),
                fontWeight: FontWeight.w400)),
        Row(
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
              value.split('.')[0],
              style: TextStyle(
                fontSize: 72,
                color: ThemeManager.getPrimaryTextColor(context),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 28),
              child: Text(
                '.${value.split('.')[1]}',
                style: TextStyle(
                  fontSize: 28,
                  color: ThemeManager.getSecondaryTextColor(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

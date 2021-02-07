import 'package:adaptive_theme/adaptive_theme.dart';
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title,
            style: TextStyle(
                fontSize: 18,
                color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                    ? Colors.grey[800]
                    : Colors.grey[500],
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
                  color:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                          ? Colors.grey[800]
                          : Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value.split('.')[0],
              style: TextStyle(
                fontSize: 72,
                color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                    ? Colors.grey[800]
                    : Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 28),
              child: Text(
                '.${value.split('.')[1]}',
                style: TextStyle(
                  fontSize: 28,
                  color:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                          ? Colors.grey[700]
                          : Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

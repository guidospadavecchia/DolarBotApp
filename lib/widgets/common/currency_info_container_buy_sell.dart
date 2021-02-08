import 'package:flutter/material.dart';
import 'currency_info.dart';

class CurrencyInfoContainerBuySell extends StatelessWidget {
  final String title;
  final String symbol;
  final String valueBuy;
  final String valueSell;

  const CurrencyInfoContainerBuySell({
    Key key,
    @required this.title,
    @required this.symbol,
    @required this.valueBuy,
    @required this.valueSell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
        Divider(
          endIndent: 75,
          indent: 75,
          height: 20,
        ),
        SizedBox(height: 30),
        CurrencyInfo(symbol: symbol, title: 'COMPRA', value: valueBuy),
        Divider(
          endIndent: 125,
          indent: 125,
          height: 60,
        ),
        CurrencyInfo(symbol: symbol, title: 'VENTA', value: valueSell),
      ],
    );
  }
}

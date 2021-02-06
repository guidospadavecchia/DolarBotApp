import 'package:flutter/material.dart';
import 'currency_info.dart';

class CurrencyInfoBuySell extends StatelessWidget {
  final String symbol;
  final String valueBuy;
  final String valueSell;

  const CurrencyInfoBuySell({
    Key key,
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
        CurrencyInfo(symbol: symbol, title: 'COMPRA', value: valueBuy),
        Divider(
          color: Colors.grey[400],
          endIndent: 80,
          indent: 80,
          height: 80,
        ),
        CurrencyInfo(symbol: symbol, title: 'VENTA', value: valueSell),
      ],
    );
  }
}

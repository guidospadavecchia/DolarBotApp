import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
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
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
          color: Colors.grey[200],
          fontWeight: FontWeight.normal),
    );
  }

  Padding _getCurrencyValue(BuildContext context) {
    final settings = Provider.of<Settings>(context, listen: false);
    final numberFormat = settings.getNumberFormat()..maximumFractionDigits = 0;

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (symbol != null && value.isNumeric())
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Text(
              value.isNumeric() ? numberFormat.format(int.parse(value.split('.')[0])) : 'N/A',
              style: TextStyle(
                fontSize: 92,
                color: Colors.grey[200],
                fontWeight: FontWeight.w600,
              ),
            ),
            if (value.split('.').length == 2 && !hideDecimals)
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 38),
                child: Text(
                  '${numberFormat.symbols.DECIMAL_SEP}${value.split('.')[1].substring(0, 2)}',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.grey[300],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

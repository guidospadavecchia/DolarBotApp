import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyInfo extends StatelessWidget {
  final String title;
  final String symbol;
  final String/*!*/ value;
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
          fontSize: SizeConfig.blockSizeVertical * 2.2,
          fontFamily: 'Raleway',
          color: Colors.grey[200],
          fontWeight: FontWeight.normal),
    );
  }

  Padding _getCurrencyValue(BuildContext context) {
    final settings = Provider.of<Settings>(context, listen: false);
    final numberFormat = settings.getNumberFormat()..maximumFractionDigits = 0;

    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeVertical * 6, right: SizeConfig.blockSizeVertical * 6),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (symbol != null && value.isNumeric())
              Padding(
                padding: EdgeInsets.only(right: SizeConfig.blockSizeVertical * 1.5),
                child: Text(
                  symbol,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 5,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            Text(
              value.isNumeric() ? numberFormat.format(int.parse(value.split('.')[0])) : 'N/A',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 10,
                color: Colors.grey[200],
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
            if (value.split('.').length == 2 && !hideDecimals)
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeVertical * 0.5,
                    bottom: SizeConfig.blockSizeVertical * 5),
                child: Text(
                  '${numberFormat.symbols.DECIMAL_SEP}${value.split('.')[1].substring(0, 2)}',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 3,
                    color: Colors.grey[200].withAlpha(150),
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

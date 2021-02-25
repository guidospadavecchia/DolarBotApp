import 'package:dolarbot_app/widgets/currency_info/currency_info.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/widgets/currency_info/currency_info.dart';

class CurrencyInfoContainer extends StatelessWidget {
  final List<CurrencyInfo> items;

  const CurrencyInfoContainer({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Wrap(
        children: [
          for (var i = 0; i < items.length; i++)
            Container(
              child: Wrap(
                children: [
                  items[i],
                  if (i != items.length - 1)
                    Divider(
                        endIndent: 100,
                        indent: 100,
                        color: Colors.white38,
                        height: _getHeight(items.length))
                ],
              ),
            ),
        ],
      ),
    );
  }

  double _getHeight(int itemsLength) {
    if (itemsLength == 2) return 100;
    if (items.length >= 5) return 30;

    return (100 - (items.length * 20)).toDouble();
  }
}

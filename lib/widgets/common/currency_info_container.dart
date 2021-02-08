import 'package:dolarbot_app/widgets/common/currency_info.dart';
import 'package:flutter/material.dart';

class CurrencyInfoContainer extends StatelessWidget {
  final List<CurrencyInfo> items;

  const CurrencyInfoContainer({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < items.length; i++)
          Column(
            children: [
              items[i],
              if (i != items.length - 1)
                Divider(endIndent: 125, indent: 125, height: 50)
            ],
          ),
      ],
    );
  }
}

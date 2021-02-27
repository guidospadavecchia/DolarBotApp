import 'package:dolarbot_app/screens/home/widgets/cards/card_value.dart';
import 'package:flutter/material.dart';

class CardBankRates extends StatelessWidget {
  final double buyValue;
  final double sellValue;
  final double sellValueWithTaxes;

  const CardBankRates({
    Key key,
    @required this.buyValue,
    @required this.sellValue,
    @required this.sellValueWithTaxes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 21),
            child: Wrap(
              verticalDirection: VerticalDirection.down,
              direction: Axis.horizontal,
              spacing: 30,
              children: [
                CardValue(
                  title: "Compra",
                  value: buyValue,
                  symbol: "\$",
                ),
                CardValue(
                  title: "Venta",
                  value: sellValue,
                  symbol: "\$",
                ),
                CardValue(
                  title: "Ahorro",
                  value: sellValueWithTaxes,
                  symbol: "\$",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

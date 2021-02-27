import 'package:dolarbot_app/screens/home/widgets/cards/banks/card_bank_rates.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_header.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_last_updated.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_logo.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/screens/home/widgets/cards/banks/card_bank_rates.dart';
export 'package:dolarbot_app/screens/home/widgets/cards/card_header.dart';
export 'package:dolarbot_app/screens/home/widgets/cards/card_last_updated.dart';
export 'package:dolarbot_app/screens/home/widgets/cards/card_logo.dart';

class CardBank extends StatelessWidget {
  final CardHeader header;
  final CardBankRates rates;
  final CardLogo logo;
  final CardLastUpdated lastUpdated;
  final List<Color> gradiantColors;
  final double height;

  const CardBank({
    Key key,
    @required this.header,
    @required this.rates,
    @required this.logo,
    @required this.lastUpdated,
    @required this.gradiantColors,
    this.height = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradiantColors,
          ),
        ),
        height: height,
        constraints: BoxConstraints(minHeight: 130),
        child: Row(
          children: [
            logo,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 13),
                child: Column(
                  children: [
                    header,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          rates,
                          lastUpdated,
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

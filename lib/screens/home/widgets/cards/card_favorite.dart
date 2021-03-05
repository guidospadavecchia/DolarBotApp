import 'package:dolarbot_app/screens/home/widgets/cards/card_header.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_last_updated.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_logo.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_powered_by.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_value.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/screens/home/widgets/cards/card_header.dart';
export 'package:dolarbot_app/screens/home/widgets/cards/card_last_updated.dart';
export 'package:dolarbot_app/screens/home/widgets/cards/card_logo.dart';
export 'package:dolarbot_app/screens/home/widgets/cards/card_value.dart';

class CardFavorite extends StatelessWidget {
  final CardHeader header;
  final List<CardValue> rates;
  final CardLogo logo;
  final CardLastUpdated lastUpdated;
  final List<Color> gradiantColors;
  final double height;
  final Spacing spaceBetweenHeader;
  final Spacing spaceBetweenItems;
  final Axis direction;
  final bool showPoweredBy;

  const CardFavorite({
    Key key,
    @required this.header,
    @required this.rates,
    @required this.logo,
    @required this.lastUpdated,
    @required this.gradiantColors,
    this.height = 140,
    this.spaceBetweenHeader = Spacing.large,
    this.spaceBetweenItems = Spacing.none,
    this.direction = Axis.horizontal,
    this.showPoweredBy = false,
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
        height: showPoweredBy ? height + 30 : height,
        constraints: BoxConstraints(minHeight: showPoweredBy ? 150 : height),
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
                          //BEGIN - CARD VALUE
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: _getSpaceBetweenHeader(),
                                  ),
                                  child: Wrap(
                                    verticalDirection: VerticalDirection.down,
                                    direction: direction,
                                    runSpacing: _getSpaceBetweenItems(),
                                    spacing: _getSpaceBetweenItems(),
                                    children: [
                                      ...rates,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //END - CARD VALUE
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: showPoweredBy ? 0 : 12),
                            child: lastUpdated,
                          ),
                          if (showPoweredBy) CardPoweredBy(),
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

  double _getSpaceBetweenHeader() {
    double spaceSize;

    switch (spaceBetweenHeader) {
      case Spacing.none:
        spaceSize = 6;
        break;
      case Spacing.small:
        spaceSize = 11;
        break;
      case Spacing.medium:
        spaceSize = 16;
        break;
      case Spacing.large:
        spaceSize = 21;
        break;
    }

    return spaceSize;
  }

  double _getSpaceBetweenItems() {
    double spaceSize;

    switch (spaceBetweenItems) {
      case Spacing.none:
        spaceSize = 5;
        break;
      case Spacing.small:
        spaceSize = 10;
        break;
      case Spacing.medium:
        spaceSize = 15;
        break;
      case Spacing.large:
        spaceSize = 20;
        break;
    }

    return spaceSize;
  }
}

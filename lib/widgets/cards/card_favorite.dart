import 'package:dolarbot_app/widgets/cards/card_header.dart';
import 'package:dolarbot_app/widgets/cards/card_last_updated.dart';
import 'package:dolarbot_app/widgets/cards/card_logo.dart';
import 'package:dolarbot_app/widgets/cards/card_value.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/widgets/cards/card_header.dart';
export 'package:dolarbot_app/widgets/cards/card_last_updated.dart';
export 'package:dolarbot_app/widgets/cards/card_logo.dart';
export 'package:dolarbot_app/widgets/cards/card_value.dart';

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            color: Colors.black26,
            offset: Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradiantColors,
        ),
      ),
      height: height,
      constraints: BoxConstraints(minHeight: height),
      child: Container(
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
                        ],
                      ),
                    ),
                    if (lastUpdated != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: lastUpdated,
                      ),
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
        spaceSize = 8;
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

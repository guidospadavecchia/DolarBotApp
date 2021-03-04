import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/metalResponse.dart';

class MetalCard extends StatelessWidget {
  final String title;
  final String tag;
  final IconData iconData;
  final String iconAsset;
  final List<Color> gradiantColors;
  final MetalResponse data;

  const MetalCard({
    Key key,
    @required this.title,
    @required this.data,
    @required this.tag,
    @required this.gradiantColors,
    this.iconAsset,
    this.iconData,
  })  : assert(iconData != null || iconAsset != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFavorite(
      showPoweredBy: true,
      height: 110,
      header: CardHeader(
        title: title,
        showButtons: false,
      ),
      spaceBetweenHeader: Spacing.small,
      rates: [
        CardValue(
          title: "/ ${data.unit}",
          value: data.value,
          symbol: data.currency == 'USD' ? 'US\$' : '\$',
          direction: Axis.horizontal,
          textDirection: TextDirection.rtl,
          spaceBetweenTitle: Spacing.small,
          crossAlignment: WrapCrossAlignment.center,
          valueSize: 32,
        ),
      ],
      logo: CardLogo(
        iconAsset: iconAsset,
        tag: tag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
      ),
      gradiantColors: gradiantColors,
    );
  }
}

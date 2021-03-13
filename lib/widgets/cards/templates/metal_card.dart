import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card_template.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/metalResponse.dart';

class MetalCard extends BaseCardTemplate {
  static const double height = 130;

  final GlobalKey<HomeScreenState> homeKey;
  final String title;
  final String tag;
  final MetalResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;

  const MetalCard({
    Key key,
    this.homeKey,
    @required this.title,
    @required this.tag,
    @required this.data,
    @required this.gradiantColors,
    this.iconData,
    this.iconAsset,
    this.showPoweredBy = false,
    this.showButtons = true,
    @required this.endpoint,
  }) : super(
          homeKey: homeKey,
          title: title,
          tag: tag,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showButtons: showButtons,
          endpoint: endpoint,
        );

  @override
  _MetalCardState createState() => _MetalCardState(data);
}

class _MetalCardState extends BaseCardTemplateState<MetalCard> {
  final MetalResponse data;

  _MetalCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: MetalCard.height,
      header: CardHeader(
        title: widget.title,
        showButtons: showButtons,
        onSharePressed: () => onSharePressed(),
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
          valueSize: 26,
        ),
      ],
      logo: CardLogo(
        iconAsset: widget.iconAsset,
        tag: widget.tag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
        showPoweredBy: showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}

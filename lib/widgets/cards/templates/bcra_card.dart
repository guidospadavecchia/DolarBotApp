import 'package:dolarbot_app/api/responses/bcra_response.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card_template.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/bcra_response.dart';

class BcraCard extends BaseCardTemplate {
  static const double height = 140;

  final String title;
  final String subtitle;
  final String tag;
  final String symbol;
  final BcraResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;

  const BcraCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.tag,
    @required this.symbol,
    @required this.data,
    @required this.gradiantColors,
    this.iconAsset,
    this.iconData,
    this.showPoweredBy = false,
    this.showButtons = true,
    @required this.endpoint,
  }) : super(
          title: title,
          subtitle: subtitle,
          tag: tag,
          symbol: symbol,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showButtons: showButtons,
          endpoint: endpoint,
        );

  @override
  _BcraCardState createState() => _BcraCardState(data);
}

class _BcraCardState extends BaseCardTemplateState<BcraCard> {
  final BcraResponse data;

  _BcraCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: BcraCard.height,
      header: CardHeader(
        title: widget.title,
        showButtons: showButtons,
        onSharePressed: () => onSharePressed(),
      ),
      spaceBetweenHeader: Spacing.small,
      spaceBetweenItems: Spacing.large,
      direction: Axis.vertical,
      rates: [
        CardValue(
          title: widget.subtitle,
          value: data.value,
          symbol: widget.symbol,
          valueSize: 22,
        ),
      ],
      logo: CardLogo(
        iconData: widget.iconData,
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

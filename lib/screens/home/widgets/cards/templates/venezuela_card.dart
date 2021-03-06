import 'package:dolarbot_app/api/responses/venezuelaResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/base/base_card_template.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/venezuelaResponse.dart';

class VenezuelaCard extends BaseCardTemplate {
  static const double height = 200;

  final String title;
  final String tag;
  final VenezuelaResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;

  const VenezuelaCard({
    Key key,
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
  _VenezuelaCardState createState() => _VenezuelaCardState(data);
}

class _VenezuelaCardState extends BaseCardTemplateState<VenezuelaCard> {
  final VenezuelaResponse data;

  _VenezuelaCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      showPoweredBy: showPoweredBy,
      height: VenezuelaCard.height,
      header: CardHeader(
        title: widget.title,
        showButtons: showButtons,
        onFavoritePressed: () => onFavoritePressed(),
        onSharePressed: () => onSharePressed(),
      ),
      spaceBetweenHeader: Spacing.medium,
      rates: [
        CardValue(
          title: "Promedio Bancos",
          value: data.bankPrice,
          symbol: "Bs.",
          spaceMainAxisEnd: Spacing.large,
          titleSize: 16,
          valueSize: 20,
        ),
        CardValue(
          title: "Paralelo",
          value: data.blackMarketPrice,
          symbol: "Bs.",
          spaceMainAxisEnd: Spacing.none,
          titleSize: 16,
          valueSize: 20,
        ),
      ],
      logo: CardLogo(
        iconAsset: widget.iconAsset,
        iconData: widget.iconData,
        tag: widget.tag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}

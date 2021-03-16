import 'package:dolarbot_app/api/responses/venezuela_response.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/venezuela_response.dart';

class VenezuelaCard extends BaseCard {
  static const double height = 200;

  final String title;
  final String tag;
  final VenezuelaResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showShareButton;
  final String endpoint;
  final Tuple2<NumberFormat, String> numberFormat;

  const VenezuelaCard({
    Key key,
    @required this.title,
    @required this.tag,
    @required this.data,
    @required this.gradiantColors,
    this.iconData,
    this.iconAsset,
    this.showPoweredBy = false,
    this.showShareButton = true,
    @required this.endpoint,
    @required this.numberFormat,
  }) : super(
          title: title,
          tag: tag,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showShareButton: showShareButton,
          endpoint: endpoint,
          numberFormat: numberFormat,
        );

  @override
  _VenezuelaCardState createState() => _VenezuelaCardState(data);
}

class _VenezuelaCardState extends BaseCardState<VenezuelaCard> {
  final VenezuelaResponse data;

  _VenezuelaCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: VenezuelaCard.height,
      header: CardHeader(
        title: widget.title,
        shareButton:
            widget.showShareButton ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenHeader: Spacing.small,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Promedio Bancos",
          value: data.bankPrice,
          symbol: "Bs.",
          spaceMainAxisEnd: Spacing.large,
          titleSize: 16,
          valueSize: 20,
        ),
        CardValue(
          numberFormat: widget.numberFormat,
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
        showPoweredBy: widget.showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}

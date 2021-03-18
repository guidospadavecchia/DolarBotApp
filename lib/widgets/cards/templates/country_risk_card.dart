import 'package:dolarbot_app/api/responses/country_risk_response.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

export 'package:dolarbot_app/api/responses/country_risk_response.dart';

class CountryRiskCard extends BaseCard {
  static const double height = 130;

  final String title;
  final String tag;
  final CountryRiskResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showShareButton;
  final String endpoint;
  final Tuple2<NumberFormat, String> numberFormat;

  const CountryRiskCard({
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
  _CountryRiskCardState createState() => _CountryRiskCardState(data);
}

class _CountryRiskCardState extends BaseCardState<CountryRiskCard> {
  final CountryRiskResponse data;

  _CountryRiskCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: CountryRiskCard.height,
      header: CardHeader(
        title: widget.title,
        shareButton:
            widget.showShareButton ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenHeader: Spacing.none,
      spaceBetweenItems: Spacing.large,
      direction: Axis.vertical,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: "puntos",
          value: data.value,
          symbol: "",
          hideDecimals: true,
          direction: Axis.horizontal,
          textDirection: ui.TextDirection.rtl,
          spaceBetweenTitle: Spacing.medium,
          crossAlignment: WrapCrossAlignment.center,
          valueSize: 26,
        ),
      ],
      logo: CardLogo(
        iconData: widget.iconData,
        iconAsset: widget.iconAsset,
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

import 'package:dolarbot_app/api/responses/country_risk_response.dart';
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

export 'package:dolarbot_app/api/responses/country_risk_response.dart';

class CountryRiskCard extends BaseCard {
  static const double kHeight = 130;

  final String title;
  final String bannerTitle;
  final String tag;
  final bool coloredTag;
  final CountryRiskResponse data;
  final List<Color> gradiantColors;
  final IconData? iconData;
  final String? iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;
  final NumberFormat numberFormat;

  const CountryRiskCard({
    Key? key,
    required this.title,
    required this.bannerTitle,
    required this.tag,
    required this.coloredTag,
    required this.data,
    required this.gradiantColors,
    this.iconData,
    this.iconAsset,
    this.showPoweredBy = false,
    this.showButtons = true,
    required this.endpoint,
    required this.numberFormat,
  }) : super(
          title: title,
          bannerTitle: bannerTitle,
          tag: tag,
          coloredTag: coloredTag,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showButtons: showButtons,
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
      height: CountryRiskCard.kHeight,
      header: CardHeader(
        title: widget.bannerTitle,
        shareButton:
            widget.showButtons ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
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
          titleSize: SizeConfig.blockSizeVertical * 2.2,
          valueSize: SizeConfig.blockSizeVertical * 4,
        ),
      ],
      logo: CardLogo(
        iconData: widget.iconData,
        iconAsset: widget.iconAsset,
        showDragHandle: widget.showButtons,
        tag: widget.tag,
        coloredTag: widget.coloredTag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
        showPoweredBy: widget.showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}

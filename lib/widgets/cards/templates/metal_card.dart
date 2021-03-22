import 'package:dolarbot_app/api/responses/metal_response.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

export 'package:dolarbot_app/api/responses/metal_response.dart';

class MetalCard extends BaseCard {
  static const double height = 130;

  final String title;
  final String bannerTitle;
  final String tag;
  final MetalResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showShareButton;
  final String endpoint;
  final NumberFormat numberFormat;

  const MetalCard({
    Key key,
    @required this.title,
    @required this.bannerTitle,
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
          bannerTitle: bannerTitle,
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
  _MetalCardState createState() => _MetalCardState(data);
}

class _MetalCardState extends BaseCardState<MetalCard> {
  final MetalResponse data;

  _MetalCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: MetalCard.height,
      header: CardHeader(
        title: widget.bannerTitle,
        shareButton:
            widget.showShareButton ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenHeader: Spacing.small,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: "/ ${data.unit}",
          value: data.value,
          symbol: data.currency == 'USD' ? 'US\$' : '\$',
          direction: Axis.horizontal,
          textDirection: ui.TextDirection.rtl,
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
        showPoweredBy: widget.showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}

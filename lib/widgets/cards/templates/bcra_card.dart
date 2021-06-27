import 'package:dolarbot_app/api/responses/bcra_response.dart';
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/bcra_response.dart';

class BcraCard extends BaseCard {
  static const double kHeight = 140;

  final String title;
  final String bannerTitle;
  final String subtitle;
  final String tag;
  final bool coloredTag;
  final String symbol;
  final BcraResponse data;
  final List<Color> gradiantColors;
  final IconData? iconData;
  final String? iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;
  final NumberFormat numberFormat;

  const BcraCard({
    Key? key,
    required this.title,
    required this.bannerTitle,
    required this.subtitle,
    required this.tag,
    required this.coloredTag,
    required this.symbol,
    required this.data,
    required this.gradiantColors,
    this.iconAsset,
    this.iconData,
    this.showPoweredBy = false,
    this.showButtons = true,
    required this.endpoint,
    required this.numberFormat,
  }) : super(
          title: title,
          bannerTitle: bannerTitle,
          subtitle: subtitle,
          tag: tag,
          coloredTag: coloredTag,
          symbol: symbol,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showButtons: showButtons,
          endpoint: endpoint,
          numberFormat: numberFormat,
        );

  @override
  _BcraCardState createState() => _BcraCardState(data);
}

class _BcraCardState extends BaseCardState<BcraCard> {
  final BcraResponse data;

  _BcraCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: BcraCard.kHeight,
      header: CardHeader(
        title: widget.bannerTitle,
        titleFontSize: SizeConfig.blockSizeVertical * 2.5,
        shareButton:
            widget.showButtons ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenHeader: Spacing.small,
      spaceBetweenItems: Spacing.large,
      direction: Axis.vertical,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: widget.subtitle!,
          value: data.value,
          symbol: widget.symbol!,
          titleSize: SizeConfig.blockSizeVertical * 2.2,
          valueSize: SizeConfig.blockSizeVertical * 2,
          spaceBetweenTitle: Spacing.small,
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

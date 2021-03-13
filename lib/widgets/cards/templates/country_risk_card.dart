import 'package:dolarbot_app/api/responses/countryRiskResponse.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card_template.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/countryRiskResponse.dart';

class CountryRiskCard extends BaseCardTemplate {
  static const double height = 130;

  final GlobalKey<HomeScreenState> homeKey;
  final String title;
  final String tag;
  final CountryRiskResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;

  const CountryRiskCard({
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
  _CountryRiskCardState createState() => _CountryRiskCardState(data);
}

class _CountryRiskCardState extends BaseCardTemplateState<CountryRiskCard> {
  final CountryRiskResponse data;

  _CountryRiskCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: CountryRiskCard.height,
      header: CardHeader(
        title: widget.title,
        showButtons: showButtons,
        onSharePressed: () => onSharePressed(),
      ),
      spaceBetweenHeader: Spacing.none,
      spaceBetweenItems: Spacing.large,
      direction: Axis.vertical,
      rates: [
        CardValue(
          title: "puntos",
          value: data.value,
          symbol: "",
          hideDecimals: true,
          direction: Axis.horizontal,
          textDirection: TextDirection.rtl,
          spaceBetweenTitle: Spacing.medium,
          crossAlignment: WrapCrossAlignment.center,
          valueSize: 32,
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

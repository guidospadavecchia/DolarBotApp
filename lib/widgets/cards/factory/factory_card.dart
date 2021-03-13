import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/templates/bcra_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/country_risk_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/crypto_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/fiat_currency_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/metal_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/venezuela_card.dart';
import 'package:dotted_border/dotted_border.dart';

abstract class BuildCard {
  factory BuildCard(ApiResponse data) {
    if (data is GenericCurrencyResponse) return _FiatCurrency(data, FiatCurrencyCard.height);
    if (data is CryptoResponse) return _Crypto(data, CryptoCard.height);
    if (data is MetalResponse) return _Metal(data, MetalCard.height);
    if (data is BcraResponse) return _Bcra(data, BcraCard.height);
    if (data is CountryRiskResponse) return _CountryRisk(data, CountryRiskCard.height);
    if (data is VenezuelaResponse) return _Venezuela(data, VenezuelaCard.height);

    return EmptyCard();
  }

  Widget fromCardData(BuildContext context, CardData buildCardData);
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate);
}

class EmptyCard implements BuildCard {
  @override
  Widget fromCardData(BuildContext context, CardData buildCardData) {
    return SizedBox.shrink();
  }

  @override
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate) {
    return SizedBox.shrink();
  }
}

class _FiatCurrency implements BuildCard {
  final GenericCurrencyResponse data;
  final double height;

  _FiatCurrency(this.data, this.height);

  @override
  Widget fromCardData(context, buildCardData) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: FiatCurrencyCard(
        title: buildCardData.title,
        data: data,
        tag: buildCardData.tag,
        iconAsset: buildCardData.iconAsset,
        iconData: buildCardData.iconData,
        gradiantColors: buildCardData.colors,
        showButtons: buildCardData.showButtons,
        showPoweredBy: buildCardData.showPoweredBy,
        endpoint: buildCardData.endpoint,
      ),
    );
  }

  @override
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: FiatCurrencyCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: "FontAwesomeSolid", fontPackage: "font_awesome_flutter"),
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        endpoint: favoriteRate.endpoint,
      ),
    );
  }
}

class _Crypto implements BuildCard {
  final CryptoResponse data;
  final double height;

  _Crypto(this.data, this.height);

  @override
  Widget fromCardData(context, buildCardData) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: CryptoCard(
        title: buildCardData.title,
        data: data,
        tag: buildCardData.tag,
        iconAsset: buildCardData.iconAsset,
        iconData: buildCardData.iconData,
        gradiantColors: buildCardData.colors,
        showButtons: buildCardData.showButtons,
        showPoweredBy: buildCardData.showPoweredBy,
        endpoint: buildCardData.endpoint,
      ),
    );
  }

  @override
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: CryptoCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: 'CryptoFont', fontPackage: 'crypto_font_icons'),
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        endpoint: favoriteRate.endpoint,
      ),
    );
  }
}

class _Metal implements BuildCard {
  final MetalResponse data;
  final double height;

  _Metal(this.data, this.height);

  @override
  Widget fromCardData(context, buildCardData) {
    print(height);
    return _InternalBuildCard(
      context: context,
      height: height,
      child: MetalCard(
        title: buildCardData.title,
        data: data,
        tag: buildCardData.tag,
        iconAsset: buildCardData.iconAsset,
        iconData: buildCardData.iconData,
        gradiantColors: buildCardData.colors,
        showButtons: buildCardData.showButtons,
        showPoweredBy: buildCardData.showPoweredBy,
        endpoint: buildCardData.endpoint,
      ),
    );
  }

  @override
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate) {
    print(height);
    return _InternalBuildCard(
      context: context,
      height: height,
      child: MetalCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData),
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        endpoint: favoriteRate.endpoint,
      ),
    );
  }
}

class _Bcra implements BuildCard {
  final BcraResponse data;
  final double height;

  _Bcra(this.data, this.height);

  @override
  Widget fromCardData(context, buildCardData) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: BcraCard(
        title: buildCardData.title,
        subtitle: buildCardData.subtitle,
        symbol: buildCardData.symbol,
        data: data,
        tag: buildCardData.tag,
        iconAsset: buildCardData.iconAsset,
        iconData: buildCardData.iconData,
        gradiantColors: buildCardData.colors,
        showButtons: buildCardData.showButtons,
        showPoweredBy: buildCardData.showPoweredBy,
        endpoint: buildCardData.endpoint,
      ),
    );
  }

  @override
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: BcraCard(
        title: favoriteRate.cardTitle,
        subtitle: favoriteRate.cardSubtitle,
        symbol: favoriteRate.cardSymbol,
        data: data,
        tag: favoriteRate.cardTag,
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: "FontAwesomeSolid", fontPackage: "font_awesome_flutter"),
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        endpoint: favoriteRate.endpoint,
      ),
    );
  }
}

class _CountryRisk implements BuildCard {
  final CountryRiskResponse data;
  final double height;

  _CountryRisk(this.data, this.height);

  @override
  Widget fromCardData(context, buildCardData) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: CountryRiskCard(
        title: buildCardData.title,
        data: data,
        tag: buildCardData.tag,
        iconAsset: buildCardData.iconAsset,
        iconData: buildCardData.iconData,
        gradiantColors: buildCardData.colors,
        showButtons: buildCardData.showButtons,
        showPoweredBy: buildCardData.showPoweredBy,
        endpoint: buildCardData.endpoint,
      ),
    );
  }

  @override
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: CountryRiskCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: "FontAwesomeSolid", fontPackage: "font_awesome_flutter"),
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        endpoint: favoriteRate.endpoint,
      ),
    );
  }
}

class _Venezuela implements BuildCard {
  final VenezuelaResponse data;
  final double height;

  _Venezuela(this.data, this.height);

  @override
  Widget fromCardData(context, buildCardData) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: VenezuelaCard(
        title: buildCardData.title,
        data: data,
        tag: buildCardData.tag,
        gradiantColors: buildCardData.colors,
        iconAsset: buildCardData.iconAsset,
        iconData: buildCardData.iconData,
        endpoint: buildCardData.endpoint,
        showButtons: buildCardData.showButtons,
        showPoweredBy: buildCardData.showPoweredBy,
      ),
    );
  }

  @override
  Widget fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate) {
    return _InternalBuildCard(
      context: context,
      height: height,
      child: VenezuelaCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData),
        endpoint: favoriteRate.endpoint,
      ),
    );
  }
}

class _InternalBuildCard extends StatelessWidget {
  final BuildContext context;
  final Widget child;
  final double height;

  const _InternalBuildCard({
    Key key,
    @required this.context,
    @required this.child,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          height: height,
          child: Transform.scale(
            scale: 0.98,
            child: DottedBorder(
              strokeWidth: 2,
              color: ThemeManager.getDottedBorderColor(context),
              dashPattern: [8, 6],
              radius: Radius.circular(10),
              borderType: BorderType.RRect,
              child: Container(
                height: height,
              ),
            ),
          ),
        ),
        child
      ],
    );
  }
}

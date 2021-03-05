import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/bcra_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/country_risk_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/crypto_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/fiat_currency_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/metal_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/venezuela_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends BaseInfoScreen {
  HomeScreen({
    Key key,
  }) : super(key: key, title: "Inicio");

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseInfoScreenState<HomeScreen> with BaseScreen {
  List<FavoriteRate> favoriteRates = List<FavoriteRate>();

  @override
  showRefreshButton() => false;

  @override
  bool showFabMenu() => false;

  @override
  bool extendBodyBehindAppBar() => false;

  @override
  CardFavorite card() => null;

  @override
  FavoriteRate createFavorite() => null;

  @override
  Type getResponseType() => null;

  @override
  void initState() {
    _loadFavorites();
    super.initState();
  }

  @override
  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: Consumer<Settings>(builder: (context, settings, child) {
          return Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 110),
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: _buildCards(),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _loadFavorites() {
    Box favoritesBox = Hive.box('favorites');
    List<dynamic> cards = favoritesBox.get('favoriteCards');
    if (cards != null) {
      favoriteRates.addAll(cards.cast<FavoriteRate>());
    }
  }

  List<Widget> _buildCards() {
    List<Widget> futureCards = List<Widget>();
    for (FavoriteRate favoriteRate in favoriteRates) {
      if (favoriteRate.cardResponseType == (DollarResponse).toString() ||
          favoriteRate.cardResponseType == (EuroResponse).toString() ||
          favoriteRate.cardResponseType == (RealResponse).toString())
        futureCards.add(_buildFutureFiatCurrencyCard(favoriteRate));

      if (favoriteRate.cardResponseType == (CryptoResponse).toString())
        futureCards.add(_buildFutureCryptoCard(favoriteRate));

      if (favoriteRate.cardResponseType == (MetalResponse).toString())
        futureCards.add(_buildFutureMetalCard(favoriteRate));

      if (favoriteRate.cardResponseType == (CountryRiskResponse).toString())
        futureCards.add(_buildFutureCountryRiskCard(favoriteRate));

      if (favoriteRate.cardResponseType == (BcraResponse).toString())
        futureCards.add(_buildFutureBcraCard(favoriteRate));

      if (favoriteRate.cardResponseType == (VenezuelaResponse).toString())
        futureCards.add(_buildFutureVenezuelaCard(favoriteRate));
    }

    return futureCards;
  }

  FutureScreenDelegate
      _buildFutureFiatCurrencyCard<T extends GenericCurrencyResponse>(
          FavoriteRate favoriteRate) {
    return FutureScreenDelegate<GenericCurrencyResponse>(
      response: API.getData(
        favoriteRate.endpoint,
        (json) => new GenericCurrencyResponse(json),
        true,
      ),
      screen: (data) => FiatCurrencyCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: "FontAwesomeSolid",
            fontPackage: "font_awesome_flutter"),
      ),
    );
  }

  FutureScreenDelegate _buildFutureCryptoCard(FavoriteRate favoriteRate) {
    return FutureScreenDelegate<CryptoResponse>(
      response: API.getData(
        favoriteRate.endpoint,
        (json) => new CryptoResponse(json),
        true,
      ),
      screen: (data) => CryptoCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: 'CryptoFont', fontPackage: 'crypto_font_icons'),
      ),
    );
  }

  FutureScreenDelegate _buildFutureMetalCard(FavoriteRate favoriteRate) {
    return FutureScreenDelegate<MetalResponse>(
      response: API.getData(
        favoriteRate.endpoint,
        (json) => new MetalResponse(json),
        true,
      ),
      screen: (data) => MetalCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData),
      ),
    );
  }

  FutureScreenDelegate _buildFutureCountryRiskCard(FavoriteRate favoriteRate) {
    return FutureScreenDelegate<CountryRiskResponse>(
      response: API.getData(
        favoriteRate.endpoint,
        (json) => new CountryRiskResponse(json),
        true,
      ),
      screen: (data) => CountryRiskCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: "FontAwesomeSolid",
            fontPackage: "font_awesome_flutter"),
      ),
    );
  }

  FutureScreenDelegate _buildFutureBcraCard(FavoriteRate favoriteRate) {
    return FutureScreenDelegate<BcraResponse>(
      response: API.getData(
        favoriteRate.endpoint,
        (json) => new BcraResponse(json),
        true,
      ),
      screen: (data) => BcraCard(
        title: favoriteRate.cardTitle,
        subtitle: favoriteRate.cardSubtitle,
        symbol: favoriteRate.cardSymbol,
        data: data,
        tag: favoriteRate.cardTag,
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData,
            fontFamily: "FontAwesomeSolid",
            fontPackage: "font_awesome_flutter"),
      ),
    );
  }

  FutureScreenDelegate _buildFutureVenezuelaCard(FavoriteRate favoriteRate) {
    return FutureScreenDelegate<VenezuelaResponse>(
      response: API.getData(
        favoriteRate.endpoint,
        (json) => new VenezuelaResponse(json),
        false,
      ),
      screen: (data) => VenezuelaCard(
        title: favoriteRate.cardTitle,
        data: data,
        tag: favoriteRate.cardTag,
        gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
        iconAsset: favoriteRate.cardIconAsset,
        iconData: IconData(favoriteRate.cardIconData),
      ),
    );
  }
}

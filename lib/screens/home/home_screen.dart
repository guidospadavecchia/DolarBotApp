import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/bcra_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/country_risk_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/crypto_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/fiat_currency_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/metal_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/venezuela_card.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
import 'package:dotted_border/dotted_border.dart';
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
  Color setColorAppbar() => ThemeManager.getPrimaryTextColor(context);

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
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 110),
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: _buildCards(),
            ),
          ),
        ),
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

  Widget _buildFutureFiatCurrencyCard<T extends GenericCurrencyResponse>(
      FavoriteRate favoriteRate) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardBackground(FiatCurrencyCard.height),
        FutureScreenDelegate<GenericCurrencyResponse>(
          loading: _buildLoadingFutureForCard(),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new GenericCurrencyResponse(json),
            false,
          ),
          screen: (data) => FiatCurrencyCard(
            title: favoriteRate.cardTitle,
            data: data,
            tag: favoriteRate.cardTag,
            gradiantColors:
                favoriteRate.cardColors.map((n) => Color(n)).toList(),
            iconAsset: favoriteRate.cardIconAsset,
            iconData: IconData(favoriteRate.cardIconData,
                fontFamily: "FontAwesomeSolid",
                fontPackage: "font_awesome_flutter"),
            endpoint: favoriteRate.endpoint,
          ),
        ),
      ],
    );
  }

  Widget _buildFutureCryptoCard(FavoriteRate favoriteRate) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardBackground(CryptoCard.height),
        FutureScreenDelegate<CryptoResponse>(
          loading: _buildLoadingFutureForCard(),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new CryptoResponse(json),
            false,
          ),
          screen: (data) => CryptoCard(
            title: favoriteRate.cardTitle,
            data: data,
            tag: favoriteRate.cardTag,
            gradiantColors:
                favoriteRate.cardColors.map((n) => Color(n)).toList(),
            iconAsset: favoriteRate.cardIconAsset,
            iconData: IconData(favoriteRate.cardIconData,
                fontFamily: 'CryptoFont', fontPackage: 'crypto_font_icons'),
            endpoint: favoriteRate.endpoint,
          ),
        ),
      ],
    );
  }

  Widget _buildFutureMetalCard(FavoriteRate favoriteRate) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardBackground(MetalCard.height),
        FutureScreenDelegate<MetalResponse>(
          loading: _buildLoadingFutureForCard(),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new MetalResponse(json),
            false,
          ),
          screen: (data) => MetalCard(
            title: favoriteRate.cardTitle,
            data: data,
            tag: favoriteRate.cardTag,
            gradiantColors:
                favoriteRate.cardColors.map((n) => Color(n)).toList(),
            iconAsset: favoriteRate.cardIconAsset,
            iconData: IconData(favoriteRate.cardIconData),
            endpoint: favoriteRate.endpoint,
          ),
        ),
      ],
    );
  }

  Widget _buildFutureCountryRiskCard(FavoriteRate favoriteRate) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardBackground(CountryRiskCard.height),
        FutureScreenDelegate<CountryRiskResponse>(
          loading: _buildLoadingFutureForCard(),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new CountryRiskResponse(json),
            false,
          ),
          screen: (data) => CountryRiskCard(
            title: favoriteRate.cardTitle,
            data: data,
            tag: favoriteRate.cardTag,
            gradiantColors:
                favoriteRate.cardColors.map((n) => Color(n)).toList(),
            iconAsset: favoriteRate.cardIconAsset,
            iconData: IconData(favoriteRate.cardIconData,
                fontFamily: "FontAwesomeSolid",
                fontPackage: "font_awesome_flutter"),
            endpoint: favoriteRate.endpoint,
          ),
        ),
      ],
    );
  }

  Widget _buildFutureBcraCard(FavoriteRate favoriteRate) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardBackground(BcraCard.height),
        FutureScreenDelegate<BcraResponse>(
          loading: _buildLoadingFutureForCard(),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new BcraResponse(json),
            false,
          ),
          screen: (data) => BcraCard(
            title: favoriteRate.cardTitle,
            subtitle: favoriteRate.cardSubtitle,
            symbol: favoriteRate.cardSymbol,
            data: data,
            tag: favoriteRate.cardTag,
            gradiantColors:
                favoriteRate.cardColors.map((n) => Color(n)).toList(),
            iconAsset: favoriteRate.cardIconAsset,
            iconData: IconData(favoriteRate.cardIconData,
                fontFamily: "FontAwesomeSolid",
                fontPackage: "font_awesome_flutter"),
            endpoint: favoriteRate.endpoint,
          ),
        ),
      ],
    );
  }

  Widget _buildFutureVenezuelaCard(FavoriteRate favoriteRate) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardBackground(VenezuelaCard.height),
        FutureScreenDelegate<VenezuelaResponse>(
          loading: _buildLoadingFutureForCard(),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new VenezuelaResponse(json),
            false,
          ),
          screen: (data) => VenezuelaCard(
            title: favoriteRate.cardTitle,
            data: data,
            tag: favoriteRate.cardTag,
            gradiantColors:
                favoriteRate.cardColors.map((n) => Color(n)).toList(),
            iconAsset: favoriteRate.cardIconAsset,
            iconData: IconData(favoriteRate.cardIconData),
            endpoint: favoriteRate.endpoint,
          ),
        ),
      ],
    );
  }

  Widget _buildCardBackground(double height) {
    return Container(
      margin: EdgeInsets.all(15),
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
    );
  }

  LoadingFuture _buildLoadingFutureForCard() {
    return LoadingFuture(
      indicatorType: Indicator.ballPulseSync,
      size: 32,
      color: ThemeManager.getDottedBorderColor(context),
    );
  }
}

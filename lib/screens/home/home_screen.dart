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
import 'package:dolarbot_app/screens/home/widgets/empty_favorites.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:simple_animations/simple_animations.dart';

class HomeScreen extends BaseInfoScreen {
  HomeScreen({
    Key key,
  }) : super(key: key, title: "Inicio");

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends BaseInfoScreenState<HomeScreen> with BaseScreen {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final Duration kCardAnimationDuration = Duration(milliseconds: 300);
  final settings = Hive.box('settings');

  HomeScreenState();

  List<Widget> _cards;
  List<FavoriteRate> _favoriteRates = [];
  bool _animateEmptyFavorites = false;

  @override
  bool showRefreshButton() => false;

  @override
  bool showFabMenu() => false;

  @override
  bool showDescriptionButton() => false;

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
  String getEndpointIdentifier() => null;

  @override
  void initState() {
    super.initState();

    _loadFavorites();
    _cards = _buildCards();

    if (_checkIsFirstTime()) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        await Util.showFirstTimeDialog(context, false);
      });
    }
  }

  bool _checkIsFirstTime() {
    return settings.get('isFirstTime') == null ? true : false;
  }

  @override
  Widget body() {
    if (_cards.length > 0)
      return Container(
        height: MediaQuery.of(context).size.height,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overScroll) {
            overScroll.disallowGlow();
            return false;
          },
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 110),
            child: ListView.builder(
                itemCount: _cards.length,
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Dismissible(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        child: _cards[i],
                      ),
                      direction: DismissDirection.endToStart,
                      background: SizedBox.shrink(),
                      secondaryBackground: Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                          right: 40,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red[800],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              size: 32,
                              color: Colors.white,
                            ),
                            Text(
                              "Quitar",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      key: ValueKey('${_cards[i]}'),
                      onDismissed: (direction) {
                        setState(() {
                          _cards.removeAt(i);
                        });
                      },
                    ),
                  );
                }),
          ),
        ),
      );
    else {
      if (_animateEmptyFavorites) {
        return PlayAnimation<double>(
            tween: Tween(begin: 0, end: 1),
            duration: kCardAnimationDuration,
            child: EmptyFavorites(),
            builder: (context, child, value) {
              return Opacity(
                opacity: value,
                child: child,
              );
            });
      } else {
        return EmptyFavorites();
      }
    }
  }

  // void _addCards() {
  //   for (var i = 0; i < _cards.length; i++) {
  //     Future.delayed(Duration(milliseconds: 50 * i), () {
  //       listKey.currentState
  //           .insertItem(i, duration: Duration(milliseconds: 500));
  //     });
  //   }
  // }

  void refresh({bool showAnimations = false}) {
    setState(() {
      _animateEmptyFavorites = showAnimations;
    });
  }

  // void removeCard(int index) {
  //   Widget removedItem = _cards.removeAt(index);
  //   AnimatedListRemovedItemBuilder builder = (context, animation) {
  //     return _buildRemoveItem(removedItem, animation);
  //   };
  //   listKey.currentState.removeItem(
  //     index,
  //     builder,
  //     duration: kCardAnimationDuration,
  //   );
  // }

  // Widget _buildRemoveItem(Widget item, Animation animation) {
  //   return SlideTransition(
  //     position: Tween<Offset>(
  //       begin: const Offset(1, 0),
  //       end: Offset(0, 0),
  //     ).animate(animation),
  //     child: item,
  //   );
  // }

  void _loadFavorites() {
    Box favoritesBox = Hive.box('favorites');
    List<dynamic> cards = favoritesBox.get('favoriteCards');
    if (cards != null) {
      _favoriteRates.addAll(cards.cast<FavoriteRate>());
    }
  }

  List<Widget> _buildCards() {
    List<Widget> futureCards = [];
    for (FavoriteRate favoriteRate in _favoriteRates) {
      String type = favoriteRate.cardResponseType;
      if (type == (DollarResponse).toString() ||
          type == (EuroResponse).toString() ||
          type == (RealResponse).toString())
        futureCards.add(_buildFutureFiatCurrencyCard(favoriteRate));
      else if (type == (CryptoResponse).toString())
        futureCards.add(_buildFutureCryptoCard(favoriteRate));
      else if (type == (MetalResponse).toString())
        futureCards.add(_buildFutureMetalCard(favoriteRate));
      else if (type == (CountryRiskResponse).toString())
        futureCards.add(_buildFutureCountryRiskCard(favoriteRate));
      else if (type == (BcraResponse).toString())
        futureCards.add(_buildFutureBcraCard(favoriteRate));
      else if (type == (VenezuelaResponse).toString())
        futureCards.add(_buildFutureVenezuelaCard(favoriteRate));
    }

    return futureCards;
  }

  Widget _buildFutureFiatCurrencyCard<T extends GenericCurrencyResponse>(
      FavoriteRate favoriteRate) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCardBackground(FiatCurrencyCard.height),
          FutureScreenDelegate<GenericCurrencyResponse>(
            loadingWidget: _buildLoadingFutureForCard(FiatCurrencyCard.height),
            response: API.getData(
              favoriteRate.endpoint,
              (json) => new GenericCurrencyResponse(json),
              false,
            ),
            screen: (data) => FiatCurrencyCard(
              homeKey: widget.key,
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
      ),
    );
  }

  Widget _buildFutureCryptoCard(FavoriteRate favoriteRate) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildCardBackground(CryptoCard.height),
        FutureScreenDelegate<CryptoResponse>(
          loadingWidget: _buildLoadingFutureForCard(CryptoCard.height),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new CryptoResponse(json),
            false,
          ),
          screen: (data) => CryptoCard(
            homeKey: widget.key,
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
          loadingWidget: _buildLoadingFutureForCard(MetalCard.height),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new MetalResponse(json),
            false,
          ),
          screen: (data) => MetalCard(
            homeKey: widget.key,
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
          loadingWidget: _buildLoadingFutureForCard(CountryRiskCard.height),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new CountryRiskResponse(json),
            false,
          ),
          screen: (data) => CountryRiskCard(
            homeKey: widget.key,
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
          loadingWidget: _buildLoadingFutureForCard(BcraCard.height),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new BcraResponse(json),
            false,
          ),
          screen: (data) => BcraCard(
            homeKey: widget.key,
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
          loadingWidget: _buildLoadingFutureForCard(VenezuelaCard.height),
          response: API.getData(
            favoriteRate.endpoint,
            (json) => new VenezuelaResponse(json),
            false,
          ),
          screen: (data) => VenezuelaCard(
            homeKey: widget.key,
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

  LoadingFuture _buildLoadingFutureForCard(double cardHeight) {
    return LoadingFuture(
      indicatorType: Indicator.ballPulseSync,
      size: 32,
      color: ThemeManager.getDottedBorderColor(context),
    );
  }
}

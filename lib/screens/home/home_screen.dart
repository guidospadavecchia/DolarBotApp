import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/empty_favorites.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
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
  final Duration kAnimationDuration = Duration(milliseconds: 500);
  final settings = Hive.box('settings');
  final Map<String, Map> _responses = Map<String, Map>();
  final List<Widget> _cards = [];
  final List<FavoriteRate> _favoriteRates = [];

  bool _cardsLoaded = false;
  bool _animateEmptyFavorites = false;

  @override
  bool showRefreshButton() => false;

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
  String getEndpointIdentifier() => null;

  @override
  void initState() {
    super.initState();

    if (!_cardsLoaded) {
      _loadFavorites().then(
        (_) => WidgetsBinding.instance
            .addPostFrameCallback((_) => setState(() => _buildCards())),
      );
    } else {
      _buildCards();
    }

    if (_checkIsFirstTime()) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        await Util.showFirstTimeDialog(context, false);
      });
    }
  }

  @override
  Widget body() {
    if (!_cardsLoaded)
      return LoadingFuture(
        indicatorType: Indicator.ballPulseSync,
        size: 64,
        color: ThemeManager.getDottedBorderColor(context),
      );

    if (_cards.length > 0)
      return _AnimationContainer(
        duration: kAnimationDuration,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 110),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: ListView.builder(
                itemCount: _cards.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Dismissible(
                      dismissThresholds: {
                        DismissDirection.endToStart: 0.4,
                      },
                      child: _cards[i],
                      direction: DismissDirection.endToStart,
                      background: _DismissFavoriteButton(),
                      key: ValueKey(_cards[i]),
                      onDismissed: (direction) {
                        _onDismissCard(i);
                      },
                    ),
                  );
                }),
          ),
        ),
      );
    else {
      if (_animateEmptyFavorites) {
        return _AnimationContainer(
          duration: kAnimationDuration,
          child: EmptyFavorites(),
        );
      } else {
        return EmptyFavorites();
      }
    }
  }

  bool _checkIsFirstTime() {
    return settings.get('isFirstTime') == null ? true : false;
  }

  void _onDismissCard(int cardIndex) {
    Box favoritesBox = Hive.box('favorites');
    List<FavoriteRate> favoriteCards = favoritesBox
        .get('favoriteCards', defaultValue: []).cast<FavoriteRate>();

    _cards.removeAt(cardIndex);
    favoriteCards.removeAt(cardIndex);
    favoritesBox.put('favoriteCards', favoriteCards);

    Future.delayed(
      kAnimationDuration ?? Duration(milliseconds: 0),
      () => setState(() {
        _animateEmptyFavorites = favoriteCards.isEmpty;
      }),
    );
  }

  Future _loadFavorites() async {
    Box favoritesBox = Hive.box('favorites');
    List<dynamic> cards = favoritesBox.get('favoriteCards');
    if (cards != null) {
      _favoriteRates.addAll(cards.cast<FavoriteRate>());
      await Future.wait(
        _favoriteRates.map(
          (x) => API
              .getRawData(x.endpoint, false)
              .then((value) => _responses[x.endpoint] = value),
        ),
      );
    }
  }

  void _buildCards() {
    for (FavoriteRate favoriteRate in _favoriteRates) {
      String type = favoriteRate.cardResponseType;
      Map json = _responses[favoriteRate.endpoint];

      if (type == (DollarResponse).toString() ||
          type == (EuroResponse).toString() ||
          type == (RealResponse).toString())
        _cards.add(BuildCard(GenericCurrencyResponse(json))
            .fromFavoriteRate(context, favoriteRate));
      else if (type == (CryptoResponse).toString())
        _cards.add(BuildCard(CryptoResponse(json))
            .fromFavoriteRate(context, favoriteRate));
      else if (type == (MetalResponse).toString())
        _cards.add(BuildCard(MetalResponse(json))
            .fromFavoriteRate(context, favoriteRate));
      else if (type == (CountryRiskResponse).toString())
        _cards.add(BuildCard(CountryRiskResponse(json))
            .fromFavoriteRate(context, favoriteRate));
      else if (type == (BcraResponse).toString())
        _cards.add(BuildCard(BcraResponse(json))
            .fromFavoriteRate(context, favoriteRate));
      else if (type == (VenezuelaResponse).toString())
        _cards.add(BuildCard(VenezuelaResponse(json))
            .fromFavoriteRate(context, favoriteRate));
    }

    _cardsLoaded = true;
  }
}

class _DismissFavoriteButton extends StatelessWidget {
  const _DismissFavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 40),
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
    );
  }
}

class _AnimationContainer extends StatelessWidget {
  final Duration duration;
  final Widget child;

  const _AnimationContainer({
    Key key,
    this.duration,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      child: child,
      builder: (context, child, value) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
    );
  }
}

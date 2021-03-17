import 'dart:io';

import 'package:dolarbot_app/api/responses/factory/api_response_builder.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/common/error_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/empty_favorites.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
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
  final Duration kDoubleTapToLeaveDuration = Duration(seconds: 2);
  final Box settings = Hive.box('settings');
  final Box favoritesBox = Hive.box('favorites');
  final Map<String, Map> _responses = Map<String, Map>();
  final List<Widget> _cards = [];
  final List<FavoriteRate> _favoriteRates = [];

  bool _cardsLoaded = false;
  bool _hasErrorsAll = false;
  bool _animateEmptyFavorites = false;
  DateTime lastBackPressTimestamp;

  @override
  bool canPop() => false;

  @override
  bool showFabMenu() => false;

  @override
  FabOptionCalculatorDialog getCalculatorWidget() => null;

  @override
  bool extendBodyBehindAppBar() => false;

  @override
  CardFavorite card() => null;

  @override
  FavoriteRate createFavorite() => null;

  @override
  Type getResponseType() => null;

  @override
  String getShareText() => '';

  @override
  Future loadData() => null;

  @override
  Color setColorAppbar() => ThemeManager.getPrimaryTextColor(context);

  @override
  Future<bool> onWillPopScope() {
    DateTime now = DateTime.now();

    dismissAllToast();
    if (lastBackPressTimestamp == null ||
        now.difference(lastBackPressTimestamp) > kDoubleTapToLeaveDuration) {
      lastBackPressTimestamp = now;
      showSnackBar('Presioná atrás nuevamente para salir');
      return Future.value(false);
    } else {
      exit(0);
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_cardsLoaded) {
      _loadFavorites(false).then(
        (_) {
          if (this.mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _buildCards()));
          }
        },
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
      return LoadingScreen(
        indicatorType: Indicator.ballPulseSync,
        size: 64,
        color: ThemeManager.getDottedBorderColor(context),
      );

    if (_hasErrorsAll) {
      return ErrorScreen(
        color: ThemeManager.getPrimaryTextColor(context),
        opacity: 0.2,
      );
    }

    if (_cards.length > 0)
      return _AnimationContainer(
        duration: kAnimationDuration,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 110),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: Theme(
              data: ThemeData(canvasColor: Colors.transparent, shadowColor: Colors.transparent),
              child: ReorderableListView(
                physics: AlwaysScrollableScrollPhysics(),
                onReorder: (int oldIndex, int newIndex) {
                  _onReorder(oldIndex, newIndex);
                },
                children: [
                  for (var i = 0; i < _cards.length; i++)
                    Container(
                      key: ValueKey(_cards[i]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
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
                    ),
                ],
              ),
            ),
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

  @override
  Future onRefresh() async {
    _cards.clear();
    _cardsLoaded = false;
    _hasErrorsAll = false;
    showRefreshButton = false;
    hideSnackBar();
    await Future.delayed(Duration.zero, () {
      setState(() {
        _loadFavorites(true)
            .then((_) => WidgetsBinding.instance.addPostFrameCallback(
                  (_) => setState(() => _buildCards()),
                ))
            .then(
          (_) {
            if (_cards.length > 0) showSnackBar('¡Cotizaciones actualizadas!');
          },
        );
      });
    });
  }

  bool _checkIsFirstTime() {
    return settings.get('isFirstTime') == null ? true : false;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }

      Widget oldCard = _cards.removeAt(oldIndex);
      _cards.insert(newIndex, oldCard);

      FavoriteRate oldFavoriteRate = _favoriteRates.removeAt(oldIndex);
      _favoriteRates.insert(newIndex, oldFavoriteRate);
      favoritesBox.put('favoriteCards', _favoriteRates);
    });
  }

  void _onDismissCard(int cardIndex) {
    _cards.removeAt(cardIndex);
    _favoriteRates.removeAt(cardIndex);
    favoritesBox.put('favoriteCards', _favoriteRates);

    Future.delayed(
      kAnimationDuration ?? Duration.zero,
      () => setState(() {
        _animateEmptyFavorites = _favoriteRates.isEmpty;
        showRefreshButton = _favoriteRates.isNotEmpty;
      }),
    );
  }

  Future _loadFavorites(bool forceRefresh) async {
    List<dynamic> cards = favoritesBox.get('favoriteCards');
    if (cards != null) {
      if (!forceRefresh) {
        _favoriteRates.addAll(cards.cast<FavoriteRate>());
      }
      await Future.wait(
        _favoriteRates.map((x) => API
            .getRawData(x.endpoint, forceRefresh)
            .then((value) => _responses[x.endpoint] = value)),
      );
    }
  }

  void _buildCards() {
    for (FavoriteRate favoriteRate in _favoriteRates) {
      String type = favoriteRate.cardResponseType;
      Map json = _responses[favoriteRate.endpoint];
      ApiResponse response = json != null ? ApiResponseBuilder.fromType(type, json) : null;

      _cards.add(
        Consumer<Settings>(builder: (context, settings, child) {
          return BuildCard(response).fromFavoriteRate(context, favoriteRate, settings);
        }),
      );
    }

    _cardsLoaded = true;
    _hasErrorsAll = _favoriteRates.isNotEmpty && _cards.length == 0;
    showRefreshButton = _favoriteRates.isNotEmpty;

    if (ModalRoute.of(context)?.isCurrent ?? false) {
      if (_favoriteRates.length > 0 && _favoriteRates.length != _cards.length && !_hasErrorsAll) {
        showSnackBar(
          'Algunas cotizaciones no pudieron cargarse',
          duration: Duration(seconds: 8),
          leadingIcon: Icon(
            Icons.warning_rounded,
            color: Colors.yellow,
          ),
        );
      }
    }
  }
}

class _DismissFavoriteButton extends StatelessWidget {
  const _DismissFavoriteButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
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

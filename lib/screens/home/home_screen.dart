import 'dart:io';
import 'dart:async';
import 'package:dolarbot_app/api/responses/factory/api_response_builder.dart';
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/widgets/historical_chart/historical_rate_manager.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/common/error_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/empty_favorites.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Duration kAnimationDuration = const Duration(milliseconds: 500);
  final Duration kDoubleTapToLeaveDuration = const Duration(seconds: 2);
  final Box settings = Hive.box('settings');
  final Box favoritesBox = Hive.box('favorites');
  final Map<String, Map?> _responses = Map<String, Map?>();
  final List<Widget> _cards = [];
  final List<FavoriteRate> _favoriteRates = [];
  final ScrollController _scrollController = ScrollController();

  bool _cardsLoaded = false;
  bool _hasErrorsAll = false;
  bool _animateEmptyFavorites = false;
  bool _hideIconTrashCard = false;
  bool _showRefreshButton = false;
  DateTime? lastBackPressTimestamp;

  Future<bool> onWillPopScope(BuildContext context) {
    final DateTime now = DateTime.now();

    dismissAllToast();
    if (lastBackPressTimestamp == null ||
        now.difference(lastBackPressTimestamp!) > kDoubleTapToLeaveDuration) {
      lastBackPressTimestamp = now;
      Util.showSnackBar(
        context,
        'Presioná atrás nuevamente para salir',
        ThemeManager.getSnackBarColor(context),
      );
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
            WidgetsBinding.instance!.addPostFrameCallback((_) => setState(() => _buildCards()));
          }
        },
      );
    } else {
      _buildCards();
    }

    if (_checkIsFirstTime() && SchedulerBinding.instance != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) async {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        await Util.showFirstTimeDialog(context, false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPopScope(context),
      child: Consumer<Settings>(builder: (context, settings, child) {
        return Scaffold(
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
          appBar: CoolAppBar(
            title: 'Inicio',
            isMainMenu: true,
            foregroundColor: ThemeManager.getPrimaryTextColor(context),
            showRefreshButton: _showRefreshButton,
            onRefresh: () => onRefresh(context),
          ),
          drawer: Container(
            width: 290,
            child: Drawer(
              child: DrawerMenu(
                onDrawerDisplayChanged: (_) => dismissAllToast(),
              ),
            ),
          ),
          drawerEdgeDragWidth: SizeConfig.screenWidth / 3,
          drawerEnableOpenDragGesture: true,
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ThemeManager.getGlobalBackgroundColor(context),
                  ThemeManager.getGlobalBackgroundColor(context),
                ],
              ),
            ),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              runSpacing: 0,
              children: [
                _body(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _body() {
    if (!_cardsLoaded)
      return LoadingScreen(
        indicatorType: Indicator.ballPulseSync,
        size: SizeConfig.blockSizeVertical * 8,
        color: ThemeManager.getLoadingIndicatorColor(context),
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
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 110),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overScroll) {
                overScroll.disallowGlow();
                return false;
              },
              child: Theme(
                data: ThemeData(canvasColor: Colors.transparent, shadowColor: Colors.transparent),
                child: ScrollWrapper(
                  scrollController: _scrollController,
                  promptAlignment: Alignment.bottomRight,
                  promptDuration: const Duration(milliseconds: 500),
                  promptTheme: PromptButtonTheme(
                    color: ThemeManager.getDarkThemeData().backgroundColor.withOpacity(0.9),
                    padding: const EdgeInsets.only(right: 25, bottom: 30),
                    iconPadding: const EdgeInsets.all(12),
                  ),
                  child: RefreshIndicator(
                    strokeWidth: 3,
                    color: ThemeManager.getPrimaryAccentColor(context),
                    displacement: 40,
                    backgroundColor: ThemeManager.getButtonColor(context).withOpacity(0.8),
                    onRefresh: () => Future.delayed(
                      const Duration(milliseconds: 200),
                      () => onRefresh(context),
                    ),
                    child: ReorderableListView(
                      scrollController: _scrollController,
                      proxyDecorator: (Widget child, int index, Animation<double> animation) {
                        return Transform.scale(
                          scale: 0.95,
                          child: Opacity(
                            opacity: 0.9,
                            child: child,
                          ),
                        );
                      },
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      onReorder: (int oldIndex, int newIndex) {
                        _onReorder(oldIndex, newIndex);
                      },
                      children: [
                        for (var i = 0; i < _cards.length; i++)
                          Container(
                            alignment: Alignment.center,
                            key: ValueKey(_cards[i]),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Consumer<Settings>(builder: (context, settings, child) {
                              return Dismissible(
                                dismissThresholds: {
                                  DismissDirection.endToStart: 0.4,
                                  DismissDirection.startToEnd: 0.4,
                                },
                                child: _cards[i],
                                direction: settings.getCardGestureDismiss(),
                                background: _DismissFavoriteButton(
                                    direction: DismissDirection.startToEnd,
                                    hideIcon: _hideIconTrashCard),
                                secondaryBackground: _DismissFavoriteButton(
                                    direction: DismissDirection.endToStart,
                                    hideIcon: _hideIconTrashCard),
                                key: ValueKey(_cards[i]),
                                confirmDismiss: (direction) => Future.delayed(Duration.zero, () {
                                  setState(() => _hideIconTrashCard = true);
                                  return true;
                                }),
                                onDismissed: (direction) {
                                  _onDismissCard(i);
                                },
                              );
                            }),
                          ),
                      ],
                    ),
                  ),
                ),
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

  void onRefresh(BuildContext context) async {
    setState(() {
      _cards.clear();
      _cardsLoaded = false;
      _hasErrorsAll = false;
      _showRefreshButton = false;
    });
    Util.hideSnackBar(context);
    _loadFavorites(true)
        .then(
          (_) => WidgetsBinding.instance!.addPostFrameCallback(
            (_) => setState(() => _buildCards()),
          ),
        )
        .then(
          (_) => Util.showSnackBar(
            context,
            '¡Cotizaciones actualizadas!',
            ThemeManager.getSnackBarColor(context),
          ),
        );
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
      kAnimationDuration,
      () => setState(() {
        _animateEmptyFavorites = _favoriteRates.isEmpty;
        _showRefreshButton = _favoriteRates.isNotEmpty;
        _hideIconTrashCard = false;
      }),
    );
  }

  Future _loadFavorites(bool forceRefresh) async {
    List<dynamic> cards = favoritesBox.get('favoriteCards') ?? [];
    if (cards.isNotEmpty) {
      if (!forceRefresh) {
        _favoriteRates.addAll(cards.cast<FavoriteRate>());
      }
      await Future.wait(
        _favoriteRates.map(
          (x) => API
              .getRawData(x.endpoint, forceRefresh)
              .then((value) => _responses[x.endpoint] = value),
        ),
      );

      _favoriteRates.forEach((x) {
        Map? json = _responses[x.endpoint];
        ApiResponse? response =
            json != null ? ApiResponseBuilder.fromTypeName(x.cardResponseType, json) : null;
        if (response != null && response.timestamp != null) {
          HistoricalRateManager.saveRate(
            x.endpoint,
            x.cardResponseType,
            response.timestamp!,
            response,
          );
        }
      });
    }
  }

  void _buildCards() {
    for (FavoriteRate favoriteRate in _favoriteRates) {
      String type = favoriteRate.cardResponseType;
      Map? json = _responses[favoriteRate.endpoint];
      ApiResponse? response = json != null ? ApiResponseBuilder.fromTypeName(type, json) : null;

      _cards.add(
        Consumer<Settings>(builder: (context, settings, child) {
          return BuildCard(response).fromFavoriteRate(context, favoriteRate, settings);
        }),
      );
    }

    _cardsLoaded = true;
    _hasErrorsAll = _favoriteRates.isNotEmpty && _cards.length == 0;
    _showRefreshButton = _favoriteRates.isNotEmpty;

    if (ModalRoute.of(context)?.isCurrent ?? false) {
      if (_favoriteRates.length > 0 && _favoriteRates.length != _cards.length && !_hasErrorsAll) {
        Util.showSnackBar(
          context,
          'Algunas cotizaciones no pudieron cargarse',
          ThemeManager.getSnackBarColor(context),
          duration: const Duration(seconds: 8),
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
  final DismissDirection direction;
  final bool hideIcon;

  const _DismissFavoriteButton({
    Key? key,
    required this.direction,
    this.hideIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildRemoveButton() {
      return Offstage(
        offstage: hideIcon,
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
              style: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      alignment:
          direction == DismissDirection.endToStart ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 40, right: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red[800],
      ),
      child: _buildRemoveButton(),
    );
  }
}

class _AnimationContainer extends StatelessWidget {
  final Duration duration;
  final Widget child;

  const _AnimationContainer({
    Key? key,
    required this.duration,
    required this.child,
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

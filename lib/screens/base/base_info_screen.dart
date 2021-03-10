import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/fab_menu.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:dolarbot_app/widgets/common/simple_fab_menu.dart';
import 'package:dolarbot_app/widgets/toasts/toast_error.dart';
import 'package:dolarbot_app/widgets/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

export 'package:dolarbot_app/api/api.dart';
export 'package:dolarbot_app/api/responses/base/apiResponse.dart';
export 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
export 'package:dolarbot_app/widgets/currency_info/currency_info_container.dart';
export 'package:dolarbot_app/util/extensions/datetime_extensions.dart';
export 'package:dolarbot_app/util/extensions/string_extensions.dart';
export 'package:dolarbot_app/classes/hive/favorite_rate.dart';
export 'package:provider/provider.dart';
export 'package:flutter/material.dart';

abstract class BaseInfoScreen extends StatefulWidget {
  final String title;
  final String bannerTitle;
  final String bannerIconAsset;
  final IconData bannerIconData;
  final List<Color> gradiantColors;
  final String endpoint;

  BaseInfoScreen({
    Key key,
    this.title,
    this.bannerTitle,
    this.bannerIconAsset,
    this.bannerIconData,
    this.gradiantColors,
    this.endpoint,
  })  : assert(bannerIconAsset == null || bannerIconData == null),
        super(key: key);
}

abstract class BaseInfoScreenState<Page extends BaseInfoScreen>
    extends State<BaseInfoScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<SimpleFabMenuState> simpleFabKey = GlobalKey();

  bool isMainMenu() => true;
  bool showRefreshButton() => true;
  bool showFabMenu() => true;
  bool showShareButton() => true;
  bool showClipboardButton() => true;
  bool showCalculatorButton() => true;
  bool showFavoriteButton() => true;
  bool extendBodyBehindAppBar() => true;
  Color setColorAppbar() => Colors.white;
}

//TODO: Hacer que levante descripciones de un JSON en cada screen
mixin BaseScreen<Page extends BaseInfoScreen> on BaseInfoScreenState<Page> {
  bool shouldForceRefresh = false;

  ScreenshotController screenshotController = ScreenshotController();

  Widget body();
  Widget card();
  FavoriteRate createFavorite();
  Type getResponseType();

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, settings, child) {
        return WillPopScope(
          onWillPop: () async {
            bool result = isMainMenu();
            if (result) {
              dismissAllToast();
              Util.navigateTo(
                context,
                HomeScreen(
                  key: GlobalKey<HomeScreenState>(),
                ),
              );
            }

            return !result;
          },
          child: Scaffold(
            extendBodyBehindAppBar: extendBodyBehindAppBar(),
            resizeToAvoidBottomInset: false,
            appBar: CoolAppBar(
              title: widget.title,
              isMainMenu: isMainMenu(),
              foregroundColor: setColorAppbar(),
              showRefreshButton: showRefreshButton(),
              onRefresh: () => _refresh(),
            ),
            drawer: Container(
              width: 290,
              child: Drawer(
                child: DrawerMenu(
                  onDrawerDisplayChanged: (isOpen) =>
                      _onDrawerDisplayChange(isOpen),
                ),
              ),
            ),
            drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2.2,
            drawerEnableOpenDragGesture: true,
            body: (widget.bannerTitle != null || isMainMenu())
                ? Stack(children: [
                    card() != null
                        ? Screenshot(
                            child: card(),
                            controller: screenshotController,
                          )
                        : SizedBox.shrink(),
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: widget.gradiantColors == null
                              ? [
                                  ThemeManager.getGlobalBackgroundColor(
                                      context),
                                  ThemeManager.getGlobalBackgroundColor(
                                      context),
                                ]
                              : widget.gradiantColors,
                        ),
                      ),
                      child: Wrap(
                        runAlignment: WrapAlignment.center,
                        runSpacing: 0,
                        children: [
                          body(),
                        ],
                      ),
                    ),
                  ])
                : body(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: showFabMenu()
                ? FabMenu(
                    simpleFabKey: simpleFabKey,
                    showFavoriteButton: showFavoriteButton(),
                    onFavoriteButtonTap: _onFavoriteStatusChange,
                    isFavorite: _getIsFavorite(),
                    showShareButton: showShareButton(),
                    onShareButtonTap: () =>
                        Util.shareCard(screenshotController),
                    showClipboardButton: showClipboardButton(),
                    showCalculatorButton: showCalculatorButton(),
                    onOpened: () => dismissAllToast(),
                    visible: false,
                  )
                : null,
          ),
        );
      },
    );
  }

  @nonVirtual
  void setActiveData(ApiResponse data, String shareTitle, String shareText) {
    ActiveScreenData activeScreenData =
        Provider.of<ActiveScreenData>(context, listen: false);
    activeScreenData.setActiveData(data, shareTitle, shareText);
  }

  @nonVirtual
  Widget banner() {
    if (widget.bannerTitle != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          color: Colors.black12,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.bannerIconAsset != null
                  ? Container(
                      child: Image.asset(
                        widget.bannerIconAsset,
                        width: 36,
                        height: 36,
                        filterQuality: FilterQuality.high,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      child: Icon(
                        widget.bannerIconData,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
              SizedBox(width: 20),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: FittedBox(
                  fit: widget.bannerTitle.length > 10
                      ? BoxFit.fitWidth
                      : BoxFit.none,
                  child: Text(
                    widget.bannerTitle,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @nonVirtual
  void onLoading() {
    simpleFabKey?.currentState?.hide();
  }

  @nonVirtual
  void onSuccessfulLoad() {
    simpleFabKey?.currentState?.show();
  }

  @nonVirtual
  void onErrorLoad() {
    simpleFabKey?.currentState?.hide();
  }

  void _onDrawerDisplayChange(bool isOpen) {
    if (isOpen && (simpleFabKey?.currentState?.isOpen ?? false)) {
      simpleFabKey.currentState.closeMenu();
    }
    dismissAllToast();
  }

  bool _getIsFavorite() {
    Box favoritesBox = Hive.box('favorites');
    List<FavoriteRate> favoriteCards = favoritesBox
        .get('favoriteCards', defaultValue: []).cast<FavoriteRate>();

    return favoriteCards.any(
      (fav) => fav.endpoint == widget.endpoint,
    );
  }

  Future<bool> _onFavoriteStatusChange() async {
    bool isFavorite;

    try {
      Box favoritesBox = Hive.box('favorites');
      List<FavoriteRate> favoriteCards = favoritesBox
          .get('favoriteCards', defaultValue: []).cast<FavoriteRate>();

      FavoriteRate favoriteCard = favoriteCards.firstWhere(
          (fav) => fav.endpoint == widget.endpoint,
          orElse: () => null);
      if (favoriteCard == null) {
        //Add favorite
        favoriteCards.add(createFavorite());
        isFavorite = true;
      } else {
        //Remove favorite
        favoriteCards.remove(favoriteCard);
        isFavorite = false;
      }

      //Save favorite list
      await favoritesBox.put('favoriteCards', favoriteCards);

      Future.delayed(
        Duration(milliseconds: 500),
        () => showToastWidget(ToastOk()),
      );
    } catch (error) {
      Future.delayed(
        Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    } finally {
      return isFavorite;
    }
  }

  void _refresh() async {
    setState(() {
      shouldForceRefresh = true;
    });
  }
}

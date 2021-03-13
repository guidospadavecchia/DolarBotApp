import 'dart:convert';

import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_error.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_ok.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/widgets/common/simple_fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

export 'package:dolarbot_app/api/api.dart';
export 'package:dolarbot_app/api/responses/base/apiResponse.dart';
export 'package:dolarbot_app/classes/hive/favorite_rate.dart';
export 'package:dolarbot_app/util/extensions/datetime_extensions.dart';
export 'package:dolarbot_app/util/extensions/string_extensions.dart';
export 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
export 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
export 'package:dolarbot_app/widgets/currency_info/currency_info_container.dart';
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';

abstract class BaseInfoScreen extends StatefulWidget {
  final String title;
  final CardData cardData;

  BaseInfoScreen({
    Key key,
    this.title,
    this.cardData,
  }) : super(key: key);
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

mixin BaseScreen<Page extends BaseInfoScreen> on BaseInfoScreenState<Page> {
  final String kDescriptionsFile = 'assets/cfg/rate_descriptions.json';
  bool shouldForceRefresh = false;
  bool _shouldShowDescriptionButton = false;

  ScreenshotController screenshotController = ScreenshotController();

  Widget body();
  Widget card();
  FavoriteRate createFavorite();
  Type getResponseType();
  String getEndpointIdentifier();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (this.mounted && getEndpointIdentifier() != null) {
        _getRateDescription().then(
          (value) => setState(
            () {
              _shouldShowDescriptionButton = (value ?? '') != '';
            },
          ),
        );
      }
    });
  }

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
            drawerEdgeDragWidth: MediaQuery.of(context).size.width / 3,
            drawerEnableOpenDragGesture: true,
            body: (widget.title != null && isMainMenu())
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
                          colors: widget.cardData?.colors == null
                              ? [
                                  ThemeManager.getGlobalBackgroundColor(
                                      context),
                                  ThemeManager.getGlobalBackgroundColor(
                                      context),
                                ]
                              : widget.cardData.colors,
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
                    showDescriptionButton: _shouldShowDescriptionButton,
                    onShowDescriptionTap: () => _onShowRateDescription(),
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
    if (widget.cardData?.title != null) {
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
              widget.cardData?.iconAsset != null
                  ? Container(
                      child: Image.asset(
                        widget.cardData.iconAsset,
                        width: 36,
                        height: 36,
                        filterQuality: FilterQuality.high,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      child: Icon(
                        widget.cardData?.iconData,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
              SizedBox(width: 20),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: FittedBox(
                  fit: widget.cardData.title.length > 10
                      ? BoxFit.fitWidth
                      : BoxFit.none,
                  child: Text(
                    widget.cardData.title,
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

  Future<String> _getRateDescription() async {
    String descriptionsString = await rootBundle.loadString(kDescriptionsFile);
    Map<String, dynamic> descriptions =
        json.decode(descriptionsString) as Map<String, dynamic>;
    return descriptions[getEndpointIdentifier()];
  }

  Future<void> _onShowRateDescription() async {
    String description = await _getRateDescription();
    if (description != null && description != '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlurDialog(
            dialog: Dialog(
              insetPadding: EdgeInsets.all(25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Descripción",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 15,
                      endIndent: 15,
                      height: 0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(description, textAlign: TextAlign.justify),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: DialogButton(
                          text: 'Cerrar',
                          icon: Icons.close,
                          onPressed: () {
                            if (Navigator.of(context).canPop())
                              Navigator.of(context).pop();
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      Future.delayed(
        Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    }
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
      (fav) => fav.endpoint == widget.cardData.endpoint,
    );
  }

  Future<bool> _onFavoriteStatusChange() async {
    bool isFavorite;

    try {
      Box favoritesBox = Hive.box('favorites');
      List<FavoriteRate> favoriteCards = favoritesBox
          .get('favoriteCards', defaultValue: []).cast<FavoriteRate>();

      FavoriteRate favoriteCard = favoriteCards.firstWhere(
          (fav) => fav.endpoint == widget.cardData.endpoint,
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

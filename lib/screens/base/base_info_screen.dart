import 'dart:convert';

import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/metal_response.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/calculator/exports/calculator_exports.dart';
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
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:dolarbot_app/util/extensions/datetime_extensions.dart';

export 'package:dolarbot_app/api/api.dart';
export 'package:dolarbot_app/api/responses/base/api_response.dart';
export 'package:dolarbot_app/classes/hive/favorite_rate.dart';
export 'package:dolarbot_app/util/extensions/datetime_extensions.dart';
export 'package:dolarbot_app/util/extensions/string_extensions.dart';
export 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
export 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
export 'package:dolarbot_app/widgets/calculator/exports/calculator_exports.dart';
export 'package:dolarbot_app/widgets/currency_info/currency_info_container.dart';
export 'package:dolarbot_app/util/extensions/string_extensions.dart';
export 'package:dolarbot_app/util/extensions/datetime_extensions.dart';
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';

abstract class BaseInfoScreen extends StatefulWidget {
  final CardData cardData;

  BaseInfoScreen({
    Key key,
    this.cardData,
  }) : super(key: key);
}

abstract class BaseInfoScreenState<Page extends BaseInfoScreen> extends State<BaseInfoScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<SimpleFabMenuState> simpleFabKey = GlobalKey();

  bool isMainMenu() => true;
  bool canPop() => true;
  bool showFabMenu() => true;
  bool showShareButton() => true;
  bool showClipboardButton() => true;
  bool showCalculatorButton() => true;
  bool showFavoriteButton() => true;
  bool showHistoricalChartButton() => true;
  bool extendBodyBehindAppBar() => true;
  Color setColorAppbar() => Colors.white;
}

mixin BaseScreen<Page extends BaseInfoScreen> on BaseInfoScreenState<Page> implements IShareable {
  static final cfg = GlobalConfiguration();

  String timestamp;
  bool showRefreshButton = false;
  bool shouldForceRefresh = false;
  bool isDataLoaded = false;
  bool errorOnLoad = false;
  bool _shouldShowDescriptionButton = false;

  Widget body();
  Widget card();
  FavoriteRate createFavorite();
  String getShareTitle();
  String getShareText();
  Future loadData();
  FabOptionCalculatorDialog getCalculatorWidget();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      hideSnackBar();
      if (this.mounted && widget.cardData?.endpoint != null) {
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
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0) {
      setState(() {});
    }
  }

  @nonVirtual
  String getTimestamp() {
    if (timestamp != null) {
      return DateTime.parse(timestamp.replaceAll('/', '-')).toRelativeString();
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPopScope,
      child: Consumer<Settings>(builder: (context, settings, child) {
        return Scaffold(
          extendBodyBehindAppBar: extendBodyBehindAppBar(),
          resizeToAvoidBottomInset: false,
          appBar: CoolAppBar(
            title: widget.cardData.title,
            isMainMenu: isMainMenu(),
            foregroundColor: setColorAppbar(),
            showRefreshButton: showRefreshButton,
            onRefresh: () => onRefresh(),
          ),
          drawer: Container(
            width: 290,
            child: Drawer(
              child: DrawerMenu(
                onDrawerDisplayChanged: (isOpen) => _onDrawerDisplayChange(isOpen),
              ),
            ),
          ),
          drawerEdgeDragWidth: 80,
          drawerEnableOpenDragGesture: true,
          body: (widget.cardData.title != null && isMainMenu())
              ? Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: widget.cardData?.colors == null
                          ? [
                              ThemeManager.getGlobalBackgroundColor(context),
                              ThemeManager.getGlobalBackgroundColor(context),
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
                )
              : body(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: showFabMenu()
              ? FabMenu(
                  simpleFabKey: simpleFabKey,
                  showFavoriteButton: showFavoriteButton(),
                  onFavoriteButtonTap: _onFavoriteStatusChange,
                  isFavorite: _getIsFavorite(),
                  showShareButton: showShareButton(),
                  onShareButtonTap: () => _onShareButtonTap(),
                  showClipboardButton: showClipboardButton(),
                  onClipboardButtonTap: () => _onClipboardButtonTap(),
                  showCalculatorButton: showCalculatorButton(),
                  onCalculatorButtonTap: () => _onCalculatorButtonTap(),
                  showDescriptionButton: _shouldShowDescriptionButton,
                  onShowDescriptionTap: () => _onShowDescriptionTap(),
                  showHistoricalChartButton: showHistoricalChartButton(),
                  //TODO Abrir y mostrar gráfico
                  onHistoricalChartButtonTap: () => null,
                  onOpened: () => dismissAllToast(),
                  visible: isDataLoaded,
                  direction: settings.getFabDirection(),
                )
              : null,
        );
      }),
    );
  }

  @nonVirtual
  void showSnackBar(
    String text, {
    Duration duration,
    TextAlign textAlign = TextAlign.center,
    Icon leadingIcon = null,
  }) {
    hideSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ThemeManager.getSnackBarColor(context),
        duration: duration ?? Duration(seconds: 2),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (leadingIcon != null) leadingIcon,
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @nonVirtual
  Widget banner() {
    if (widget.cardData?.bannerTitle != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
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
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    child: FittedBox(
                      fit: widget.cardData.bannerTitle.length > 10 ? BoxFit.fitWidth : BoxFit.none,
                      child: Text(
                        widget.cardData.bannerTitle,
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
            if (timestamp != null)
              Opacity(
                opacity: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: 22,
                  width: double.infinity,
                  color: Colors.black26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 16,
                        color: Colors.white70,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 0),
                        child: Text(
                          "Última actualización: ${getTimestamp()}",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @nonVirtual
  void hideSimpleFabMenu() {
    simpleFabKey?.currentState?.hide();
  }

  @nonVirtual
  void showSimpleFabMenu() {
    simpleFabKey?.currentState?.show();
  }

  Future<void> saveHistoricalRate(
      String endpoint, String responseType, String timestamp, ApiResponse data) {
    Box historicalRatesBox = Hive.box('historicalRates');
    List<HistoricalRate> historicalRates =
        historicalRatesBox.get('historicalRates', defaultValue: []).cast<HistoricalRate>();

    int saveFreq = cfg.get("historicalRateSaveFrequencyMinutes") ?? Duration.minutesPerDay;
    timestamp = timestamp.replaceAll('/', '-');
    bool rateExists = historicalRates.any((x) =>
        x.endpoint == endpoint &&
        (saveFreq <= 0 ||
            DateTime.parse(x.timestamp).difference(DateTime.parse(timestamp)).inMinutes <
                saveFreq));

    if (!rateExists) {
      HistoricalRate historicalRate = HistoricalRate(
        endpoint: endpoint,
        responseType: responseType,
        timestamp: timestamp,
        json: data.serialize(),
      );
      historicalRates.add(historicalRate);
      return historicalRatesBox.put('historicalRates', historicalRates);
    }

    return Future.value();
  }

  void onRefresh() async {
    hideSimpleFabMenu();
    setState(() {
      isDataLoaded = false;
      errorOnLoad = false;
      showRefreshButton = false;
      shouldForceRefresh = true;
      loadData();
    });
  }

  Future<bool> onWillPopScope() async {
    if (canPop()) {
      dismissAllToast();
      Util.navigateTo(
        context,
        HomeScreen(
          key: GlobalKey<HomeScreenState>(),
        ),
      );
    }
    return false;
  }

  Future _onShareButtonTap() async {
    await Util.shareCard(context, card());
  }

  Future<void> _onClipboardButtonTap() async {
    String shareText = getShareText();
    String shareTitle = getShareTitle();
    String poweredBy = Util.cfg.getDeepValue("share:poweredBy");
    String text = "$shareTitle\n\n$shareText\n\n$poweredBy";

    simpleFabKey.currentState.closeMenu();
    await Clipboard.setData(
      new ClipboardData(text: text),
    ).then(
      (_) async => {
        Future.delayed(
          Duration(milliseconds: 100),
          () => showToastWidget(
            ToastOk(),
          ),
        ),
      },
    );
  }

  void _onCalculatorButtonTap() {
    simpleFabKey.currentState.closeMenu();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return getCalculatorWidget();
      },
    );
  }

  Future<String> _getRateDescription() async {
    String descriptionsString = await rootBundle.loadString(DolarBotConstants.kDescriptionsFile);
    Map<String, dynamic> descriptions = json.decode(descriptionsString) as Map<String, dynamic>;
    return descriptions[_getEndpointType(widget.cardData?.responseType)];
  }

  String _getEndpointType(Type response) {
    String endpointName;

    switch (response) {
      case DollarResponse:
        endpointName = DollarEndpoints.values
            .firstWhere((e) => e.value == widget.cardData?.endpoint, orElse: () => null)
            .toString();
        break;

      case EuroResponse:
        endpointName = EuroEndpoints.values
            .firstWhere((e) => e.value == widget.cardData?.endpoint, orElse: () => null)
            .toString();
        break;

      case RealResponse:
        endpointName = RealEndpoints.values
            .firstWhere((e) => e.value == widget.cardData?.endpoint, orElse: () => null)
            .toString();
        break;

      case CryptoResponse:
        endpointName = CryptoEndpoints.values
            .firstWhere((e) => e.value == widget.cardData?.endpoint, orElse: () => null)
            .toString();
        break;

      case MetalResponse:
        endpointName = MetalEndpoints.values
            .firstWhere((e) => e.value == widget.cardData?.endpoint, orElse: () => null)
            .toString();
        break;

      case CountryRiskResponse:
      case BcraResponse:
        endpointName = BcraEndpoints.values
            .firstWhere((e) => e.value == widget.cardData?.endpoint, orElse: () => null)
            .toString();
        break;

      case VenezuelaResponse:
        endpointName = VenezuelaEndpoints.values
            .firstWhere((e) => e.value == widget.cardData?.endpoint, orElse: () => null)
            .toString();
        break;
      default:
    }

    return endpointName;
  }

  Future<void> _onShowDescriptionTap() async {
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
                          color: ThemeManager.getPrimaryTextColor(context),
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
                            if (Navigator.of(context).canPop()) Navigator.of(context).pop();
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
    List<FavoriteRate> favoriteCards =
        favoritesBox.get('favoriteCards', defaultValue: []).cast<FavoriteRate>();

    return favoriteCards.any(
      (fav) => fav.endpoint == widget.cardData.endpoint,
    );
  }

  Future<bool> _onFavoriteStatusChange() async {
    bool isFavorite;

    try {
      Box favoritesBox = Hive.box('favorites');
      List<FavoriteRate> favoriteCards =
          favoritesBox.get('favoriteCards', defaultValue: []).cast<FavoriteRate>();

      FavoriteRate favoriteCard = favoriteCards
          .firstWhere((fav) => fav.endpoint == widget.cardData.endpoint, orElse: () => null);
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
}

import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/metal_response.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/widgets/title_banner.dart';
import 'package:dolarbot_app/screens/historical_rates/historical_rates_screen.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/calculator/exports/calculator_exports.dart';
import 'package:dolarbot_app/widgets/common/text_dialog.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_error.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_ok.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:dolarbot_app/widgets/common/simple_fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:oktoast/oktoast.dart';
import 'package:page_transition/page_transition.dart';
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
export 'package:dolarbot_app/models/settings.dart';
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';

abstract class BaseInfoScreen extends StatefulWidget {
  final CardData cardData;

  BaseInfoScreen({
    Key? key,
    required this.cardData,
  }) : super(key: key);
}

abstract class BaseInfoScreenState<Page extends BaseInfoScreen> extends State<BaseInfoScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<SimpleFabMenuState> simpleFabKey = GlobalKey();

  bool canPop() => true;
  bool showFabMenu() => true;
  bool showShareButton() => true;
  bool showClipboardButton() => true;
  bool showCalculatorButton() => true;
  bool showFavoriteButton() => true;
  bool showHistoricalChartButton() => true;
  bool extendBodyBehindAppBar() => true;
}

mixin BaseScreen<Page extends BaseInfoScreen> on BaseInfoScreenState<Page> {
  static final cfg = GlobalConfiguration();

  String? timestamp;
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
  FabOptionCalculatorDialog? getCalculatorWidget();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      hideSnackBar();
      if (this.mounted) {
        _getRateDescription().then(
          (value) => setState(
            () {
              _shouldShowDescriptionButton = value != '';
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
      return DateTime.parse(timestamp!.replaceAll('/', '-')).toRelativeString();
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
            isMainMenu: true,
            foregroundColor: Colors.white,
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
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.cardData.colors,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _banner(),
                Expanded(
                  child: Center(
                    child: body(),
                  ),
                ),
              ],
            ),
          ),
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
                  onHistoricalChartButtonTap: () => _onHistoricalChartButtonTap(),
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
    Duration duration = const Duration(seconds: 2),
    TextAlign textAlign = TextAlign.center,
    Icon? leadingIcon = null,
  }) {
    hideSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ThemeManager.getSnackBarColor(context),
        duration: duration,
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
  void hideSimpleFabMenu() {
    simpleFabKey.currentState?.hide();
  }

  @nonVirtual
  void showSimpleFabMenu() {
    simpleFabKey.currentState?.show();
  }

  void onRefresh() async {
    simpleFabKey.currentState?.closeMenu();
    hideSimpleFabMenu();
    setState(() {
      isDataLoaded = false;
      errorOnLoad = false;
      showRefreshButton = false;
      shouldForceRefresh = true;
    });
    loadData();
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

  Widget _banner() {
    if (isDataLoaded) {
      String timestampValue = getTimestamp();
      return TitleBanner(
        text: widget.cardData.bannerTitle,
        iconAsset: widget.cardData.iconAsset,
        iconData: widget.cardData.iconData,
        showTimeStamp: timestampValue != '',
        timeStampValue: "Última actualización: $timestampValue",
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future _onShareButtonTap() async {
    await Util.shareCard(context, card());
  }

  Future<void> _onClipboardButtonTap() async {
    String shareText = getShareText();
    String shareTitle = getShareTitle();
    String? poweredBy = Util.cfg.getDeepValue("share:poweredBy");
    String text = "$shareTitle\n\n$shareText\n\n$poweredBy";

    if (simpleFabKey.currentState != null) {
      simpleFabKey.currentState!.closeMenu();
    }
    await Clipboard.setData(
      new ClipboardData(text: text),
    ).then(
      (_) async => {
        Future.delayed(
          const Duration(milliseconds: 100),
          () => showToastWidget(
            ToastOk(),
          ),
        ),
      },
    );
  }

  void _onCalculatorButtonTap() {
    simpleFabKey.currentState?.closeMenu();
    FabOptionCalculatorDialog? calculatorWidget = getCalculatorWidget();
    if (calculatorWidget != null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return calculatorWidget;
        },
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    }
  }

  void _onHistoricalChartButtonTap() {
    Util.navigateTo(
      context,
      HistoricalRatesScreen(
        title: widget.cardData.title,
        subtitle: widget.cardData.bannerTitle,
        endpoint: widget.cardData.endpoint,
        responseType: widget.cardData.responseType,
        colors: widget.cardData.colors,
        iconAsset: widget.cardData.iconAsset,
        iconData: widget.cardData.iconData,
      ),
      withReplacement: false,
      transitionType: PageTransitionType.rightToLeft,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );
  }

  Future<String> _getRateDescription() async {
    String descriptionsString = await rootBundle.loadString(DolarBotConstants.kDescriptionsFile);
    Map<String, dynamic> descriptions = json.decode(descriptionsString) as Map<String, dynamic>;
    return descriptions[_getEndpointType(widget.cardData.responseType)] ?? '';
  }

  String _getEndpointType(Type response) {
    String endpointName;

    switch (response) {
      case DollarResponse:
        endpointName = DollarEndpoints.values
            .firstWhereOrNull((e) => e.value == widget.cardData.endpoint)
            .toString();
        break;
      case EuroResponse:
        endpointName = EuroEndpoints.values
            .firstWhereOrNull((e) => e.value == widget.cardData.endpoint)
            .toString();
        break;
      case RealResponse:
        endpointName = RealEndpoints.values
            .firstWhereOrNull((e) => e.value == widget.cardData.endpoint)
            .toString();
        break;
      case CryptoResponse:
        endpointName = CryptoEndpoints.values
            .firstWhereOrNull((e) => e.value == widget.cardData.endpoint)
            .toString();
        break;
      case MetalResponse:
        endpointName = MetalEndpoints.values
            .firstWhereOrNull((e) => e.value == widget.cardData.endpoint)
            .toString();
        break;
      case CountryRiskResponse:
      case BcraResponse:
        endpointName = BcraEndpoints.values
            .firstWhereOrNull((e) => e.value == widget.cardData.endpoint)
            .toString();
        break;
      case VenezuelaResponse:
        endpointName = VenezuelaEndpoints.values
            .firstWhereOrNull((e) => e.value == widget.cardData.endpoint)
            .toString();
        break;
      default:
        throw 'Unknown ApiResponse type';
    }

    return endpointName;
  }

  Future<void> _onShowDescriptionTap() async {
    String description = await _getRateDescription();
    if (description != '') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return TextDialog(
            title: "Descripción",
            text: description,
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    }
  }

  void _onDrawerDisplayChange(bool isOpen) {
    if (isOpen && (simpleFabKey.currentState?.isOpen ?? false)) {
      simpleFabKey.currentState!.closeMenu();
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
    bool isFavorite = false;

    try {
      Box favoritesBox = Hive.box('favorites');
      List<FavoriteRate> favoriteCards =
          favoritesBox.get('favoriteCards', defaultValue: []).cast<FavoriteRate>();

      FavoriteRate? favoriteCard =
          favoriteCards.firstWhereOrNull((fav) => fav.endpoint == widget.cardData.endpoint);
      if (favoriteCard == null) {
        //Add favorite
        favoriteCards.add(createFavorite());
        isFavorite = true;
      } else {
        //Remove favorite
        favoriteCards.remove(favoriteCard);
      }

      //Save favorite list
      await favoritesBox.put('favoriteCards', favoriteCards);

      Future.delayed(
        const Duration(milliseconds: 500),
        () => showToastWidget(ToastOk()),
      );
    } catch (error) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    } finally {
      return isFavorite;
    }
  }
}

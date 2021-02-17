import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/root_menus/exports/root_menu_exports.dart';
import 'package:flutter/material.dart';

class DrawerMenuBody extends StatelessWidget {
  final GlobalKey<CurrencyInfoScreenState> _keyCurrency = GlobalKey();
  final GlobalKey<CryptoInfoScreenState> _keyCrypto = GlobalKey();
  final GlobalKey<MetalInfoScreenState> _keyMetal = GlobalKey();
  final GlobalKey<BcraInfoScreenState> _keyBCRA = GlobalKey();
  final GlobalKey<VenezuelaInfoScreenState> _keyVenezuela = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Function _refreshCurrency = () => _keyCurrency.currentState.refresh();
    Function _refreshCrypto = () => _keyCrypto.currentState.refresh();
    Function _refreshMetal = () => _keyMetal.currentState.refresh();
    Function _refreshBCRA = () => _keyBCRA.currentState.refresh();
    Function _refreshVenezuela = () => _keyVenezuela.currentState.refresh();

    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            RootMenuDollar(key: _keyCurrency, onRefresh: _refreshCurrency),
            RootMenuEuro(key: _keyCurrency, onRefresh: _refreshCurrency),
            RootMenuReal(key: _keyCurrency, onRefresh: _refreshCurrency),
            RootMenuCrypto(key: _keyCrypto, onRefresh: _refreshCrypto),
            RootMenuMetals(key: _keyMetal, onRefresh: _refreshMetal),
            RootMenuBCRA(key: _keyBCRA, onRefresh: _refreshBCRA),
            RootMenuVenezuela(key: _keyVenezuela, onRefresh: _refreshVenezuela)
          ],
        ),
      ),
    );
  }
}

getIconAsset(BuildContext context, String assetPath) {
  return Image.asset(
    assetPath,
    color: ThemeManager.getDrawerMenuItemIconColor(context),
    width: 24,
    height: 24,
    filterQuality: FilterQuality.high,
  );
}

getIconData(BuildContext context, IconData iconData) {
  return Icon(
    iconData,
    color: ThemeManager.getDrawerMenuItemIconColor(context),
  );
}

navigateTo({
  BuildContext context,
  String title,
  Widget bodyContent,
  Function onRefresh,
}) async {
  Navigator.pop(context, true);
  await Future.delayed(Duration(milliseconds: 200)).then(
    (value) => Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomeScreen(
          title: title,
          bodyContent: bodyContent,
          onAppBarRefresh: onRefresh,
        ),
      ),
    ),
  );
}

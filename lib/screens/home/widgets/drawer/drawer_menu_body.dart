import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/root_menus/exports/root_menu_exports.dart';
import 'package:flutter/material.dart';

class DrawerMenuBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            RootMenuDollar(),
            RootMenuEuro(),
            RootMenuReal(),
            RootMenuCrypto(),
            RootMenuMetals(),
            RootMenuBCRA(),
            RootMenuVenezuela()
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

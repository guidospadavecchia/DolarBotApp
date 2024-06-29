import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';

import '../../classes/theme_manager.dart';
import '../../screens/base/base_info_screen.dart';
import 'root_menus/exports/root_menu_exports.dart';

export 'package:dolarbot_app/util/util.dart';

class DrawerMenuBody extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: ScrollWrapper(
          scrollController: _scrollController,
          promptAlignment: Alignment.topCenter,
          promptDuration: const Duration(milliseconds: 500),
          promptTheme: PromptButtonTheme(
            color: ThemeManager.getDrawerMenuFooterSloganBackgroundColor(context),
            padding: const EdgeInsets.only(top: 15),
            iconPadding: const EdgeInsets.all(10),
          ),
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            children: [
              RootMenuHome(),
              RootMenuDollar(),
              RootMenuEuro(),
              RootMenuReal(),
              RootMenuBanks(),
              RootMenuCrypto(),
              RootMenuMetals(),
              RootMenuBCRA(),
              RootMenuVenezuela()
            ],
          ),
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

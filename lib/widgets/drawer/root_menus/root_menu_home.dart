import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../screens/home/home_screen.dart';
import '../../common/menu_item.dart';
import '../drawer_menu_body.dart';

class RootMenuHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<HomeScreenState> homeKey = GlobalKey<HomeScreenState>();

    return MenuItem(
      text: "Inicio",
      depthLevel: 1,
      leading: getIconData(context, FontAwesomeIcons.house),
      onTap: () => Util.navigateTo(
        context,
        HomeScreen(key: homeKey),
      ),
    );
  }
}

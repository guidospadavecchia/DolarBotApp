import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<HomeScreenState> homeKey = GlobalKey<HomeScreenState>();

    return MenuItem(
      text: "Inicio",
      depthLevel: 1,
      leading: getIconData(context, FontAwesomeIcons.home),
      onTap: () => Util.navigateTo(
        context,
        HomeScreen(key: homeKey),
      ),
    );
  }
}

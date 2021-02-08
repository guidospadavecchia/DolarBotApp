import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_footer.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_header.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerMenuHeader(),
        DrawerMenuBody(),
        DrawerMenuFooter(),
      ],
    );
  }
}

import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_footer.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_header.dart';

import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  final DrawerCallback onDrawerDisplayChanged;

  const DrawerMenu({
    Key key,
    this.onDrawerDisplayChanged,
  }) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  void initState() {
    if (widget.onDrawerDisplayChanged != null) {
      widget.onDrawerDisplayChanged(true);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDrawerDisplayChanged != null) {
      widget.onDrawerDisplayChanged(false);
    }
    super.dispose();
  }

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

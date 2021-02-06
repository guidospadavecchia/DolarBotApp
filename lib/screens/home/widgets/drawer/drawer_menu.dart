import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_header.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerMenuHeader(),
          Divider(
            color: Colors.grey[500],
            height: 25,
          ),
          //TO DO: DrawerMenuBody
        ],
      ),
    );
  }
}

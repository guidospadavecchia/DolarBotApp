import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onRefresh;

  const CommonAppBar({
    Key key,
    @required this.title,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: true,
      toolbarHeight: 70,
      leadingWidth: 80,
      leading: Builder(
        builder: (BuildContext context) {
          if (ModalRoute.of(context)?.settings?.name == "/o") {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              splashRadius: 25,
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Volver',
            );
          } else {
            return IconButton(
              icon: Icon(Icons.menu),
              splashRadius: 25,
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: 'Abrir menú',
            );
          }
        },
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: IconButton(
            icon: Icon(FontAwesomeIcons.redo),
            iconSize: 18,
            splashRadius: 25,
            tooltip: 'Refrescar cotización',
            onPressed: () => onRefresh(),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          color: ThemeManager.getPrimaryTextColor(context),
        ),
      ),
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(70);
}

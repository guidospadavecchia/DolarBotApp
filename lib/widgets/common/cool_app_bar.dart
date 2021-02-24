import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoolAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMainMenu;
  final bool showRefreshButton;
  final Function onRefresh;
  final Color leadingButtonColor;

  const CoolAppBar({
    Key key,
    this.title,
    this.isMainMenu = true,
    this.showRefreshButton = false,
    this.onRefresh,
    this.leadingButtonColor,
  })  : assert(!showRefreshButton || onRefresh != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: true,
      toolbarHeight: 70,
      leadingWidth: 80,
      leading: Builder(
        builder: (BuildContext context) {
          if (isMainMenu) {
            return IconButton(
              icon: Icon(Icons.menu),
              splashRadius: 25,
              color: leadingButtonColor,
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: 'Abrir menú',
            );
          } else {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              splashRadius: 25,
              color: leadingButtonColor,
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Volver',
            );
          }
        },
      ),
      actions: [
        Container(
          child: showRefreshButton
              ? Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.redo),
                    iconSize: 18,
                    splashRadius: 25,
                    tooltip: 'Refrescar cotización',
                    onPressed: () => onRefresh(),
                  ),
                )
              : null,
        )
      ],
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Consumer<Settings>(
        builder: (context, settings, child) {
          return FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
            child: Text(
              title ?? ' ',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: ThemeManager.getPrimaryTextColor(context),
              ),
            ),
          );
        },
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(70);
}

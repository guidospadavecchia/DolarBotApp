import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoolAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMainMenu;
  final bool showRefreshButton;
  final Function onRefresh;
  final Color foregroundColor;

  const CoolAppBar({
    Key key,
    this.title,
    this.isMainMenu = true,
    this.showRefreshButton = false,
    this.onRefresh,
    this.foregroundColor,
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
              icon: const Icon(Icons.menu),
              splashRadius: 25,
              color: foregroundColor,
              onPressed: () => Scaffold.of(context).openDrawer(),
              tooltip: 'Abrir menú',
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              splashRadius: 25,
              color: foregroundColor,
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
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: const Icon(FontAwesomeIcons.redo),
                    color: foregroundColor,
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
      title: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.fitWidth,
        child: Text(
          title ?? ' ',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: foregroundColor,
          ),
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

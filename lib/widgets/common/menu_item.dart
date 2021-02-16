import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final String subtitle;
  final Widget leading;
  final Widget trailing;
  final Function onTap;
  final int depthLevel;
  final List<MenuItem> subItems;
  final bool disableSplash;

  const MenuItem({
    @required this.text,
    this.subtitle,
    @required this.leading,
    this.trailing,
    this.onTap,
    this.subItems,
    @required this.depthLevel,
    this.disableSplash = false,
  });

  @override
  Widget build(BuildContext context) {
    final double _paddingOffset = leading == null ? 22 : 25;

    EdgeInsetsGeometry _calculatePaddingOffset() {
      return EdgeInsets.only(left: depthLevel * _paddingOffset, right: 20);
    }

    return (subItems != null)
        ? Theme(
            data: ThemeManager.getThemeForDrawerMenu(context, disableSplash),
            child: (ExpansionTile(
              tilePadding: _calculatePaddingOffset(),
              title: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    color: ThemeManager.getPrimaryTextColor(context),
                    fontWeight: FontWeight.w600),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: 3),
                child: leading,
              ),
              trailing: trailing,
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        color: Colors.grey,
                      ),
                    )
                  : null,
              children: [...subItems],
            )),
          )
        : Theme(
            data: ThemeManager.getThemeForDrawerMenu(context, disableSplash),
            child: (ListTile(
              contentPadding: _calculatePaddingOffset(),
              title: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    color: ThemeManager.getPrimaryTextColor(context),
                    fontWeight: FontWeight.w600),
              ),
              leading: Padding(
                padding:
                    EdgeInsets.only(top: subtitle != null ? 7 : 0, left: 3),
                child: leading,
              ),
              trailing: trailing,
              subtitle: subtitle != null
                  ? Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        color: Colors.grey,
                      ),
                    )
                  : null,
              onTap: () => onTap(),
            )),
          );
  }
}

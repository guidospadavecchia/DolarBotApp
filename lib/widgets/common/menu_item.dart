import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/widgets/common/pills/pro_pill.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final String? subtitle;
  final Widget leading;
  final Widget? trailing;
  final Function? onTap;
  final int depthLevel;
  final List<MenuItem>? subItems;
  final bool disableHighlight;
  final bool lockedBehindProFeature;

  const MenuItem({
    required this.text,
    this.subtitle,
    required this.leading,
    this.trailing,
    this.onTap,
    this.subItems,
    required this.depthLevel,
    this.disableHighlight = false,
    this.lockedBehindProFeature = false,
  });

  @override
  Widget build(BuildContext context) {
    final double _paddingOffset = 15;

    EdgeInsetsGeometry _calculatePaddingOffset() {
      return EdgeInsets.only(left: depthLevel * _paddingOffset, right: 20);
    }

    return (!lockedBehindProFeature && subItems != null && subItems!.length > 0)
        ? Theme(
            data: ThemeManager.getThemeForDrawerMenu(context, disableHighlight: disableHighlight),
            child: ExpansionTile(
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
                padding: const EdgeInsets.only(left: 12),
                child: leading,
              ),
              trailing: trailing,
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        color: Colors.grey,
                      ),
                    )
                  : null,
              children: [...subItems!],
            ),
          )
        : Theme(
            data: ThemeManager.getThemeForDrawerMenu(context, disableHighlight: disableHighlight),
            child: ListTile(
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
                padding: EdgeInsets.only(top: subtitle != null ? 7 : 0, left: 12),
                child: leading,
              ),
              trailing: lockedBehindProFeature ? ProPill() : trailing,
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Raleway',
                        color: Colors.grey,
                      ),
                    )
                  : null,
              onTap: () {
                if (lockedBehindProFeature) {
                  //TODO: Construir dialog de pro features
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlurDialog(
                        dialog: Dialog(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 100,
                            width: 50,
                            alignment: Alignment.center,
                            child: Placeholder(),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  if (onTap != null) {
                    onTap!();
                  }
                }
              },
            ),
          );
  }
}

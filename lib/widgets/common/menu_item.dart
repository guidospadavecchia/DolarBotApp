import '../../classes/size_config.dart';
import 'pro_features/pro_features_dialog.dart';
import 'package:flutter/material.dart';
import '../../classes/theme_manager.dart';
import 'pills/pro_pill.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final Color? textColor;
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
    this.textColor,
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
    final double leftPaddingOffset = SizeConfig.blockSizeHorizontal * 4.5;
    final double rightPaddingOffset = SizeConfig.blockSizeHorizontal * 4.5;
    final double fontSizeTitle = SizeConfig.blockSizeVertical * 2;
    final double fontSizeSubtitle = SizeConfig.blockSizeVertical * 1.4;
    final double leadingLeftPadding = SizeConfig.blockSizeHorizontal * 3;
    final double leadingTopPadding = SizeConfig.blockSizeVertical;

    EdgeInsetsGeometry _calculatePaddingOffset() {
      return EdgeInsets.only(left: depthLevel * leftPaddingOffset, right: rightPaddingOffset);
    }

    return (!lockedBehindProFeature && subItems != null && subItems!.length > 0)
        ? Theme(
            data: ThemeManager.getThemeForDrawerMenu(context, disableHighlight: disableHighlight),
            child: ExpansionTile(
              tilePadding: _calculatePaddingOffset(),
              title: Text(
                text,
                style: TextStyle(
                    fontSize: fontSizeTitle,
                    fontFamily: 'Raleway',
                    color: textColor ?? ThemeManager.getPrimaryTextColor(context),
                    fontWeight: FontWeight.w600),
              ),
              leading: Padding(
                padding: EdgeInsets.only(
                  left: leadingLeftPadding,
                ),
                child: leading,
              ),
              trailing: trailing,
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: fontSizeSubtitle,
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
                    fontSize: fontSizeTitle,
                    fontFamily: 'Raleway',
                    color: textColor ?? ThemeManager.getPrimaryTextColor(context),
                    fontWeight: FontWeight.w600),
              ),
              leading: Padding(
                padding: EdgeInsets.only(top: subtitle != null ? leadingTopPadding : 0, left: leadingLeftPadding),
                child: leading,
              ),
              trailing: lockedBehindProFeature ? ProPill() : trailing,
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: fontSizeSubtitle,
                        fontFamily: 'Raleway',
                        color: Colors.grey,
                      ),
                    )
                  : null,
              onTap: () {
                if (lockedBehindProFeature) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ProFeaturesDialog();
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

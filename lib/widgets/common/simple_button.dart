import '../../classes/theme_manager.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final String text;
  final Color? textColor;
  final double fontSize;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Function onPressed;

  const SimpleButton({
    Key? key,
    required this.icon,
    this.iconSize = 32,
    this.iconColor,
    this.text = '',
    this.textColor,
    this.fontSize = 16,
    this.backgroundColor,
    this.padding,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          padding ?? EdgeInsets.only(top: 7, right: text != '' ? 25 : 15, left: 15, bottom: 7),
        ),
        overlayColor: MaterialStateColor.resolveWith((states) => ThemeManager.getDrawerMenuItemIconColor(context).withOpacity(0.2)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return backgroundColor ?? ThemeManager.getButtonColor(context);
          },
        ),
      ),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? ThemeManager.getPrimaryAccentColor(context),
          ),
          if (text != '')
            const SizedBox(
              width: 10,
            ),
          if (text != '')
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
                color: textColor ?? ThemeManager.getPrimaryTextColor(context),
              ),
            ),
        ],
      ),
    );
  }
}

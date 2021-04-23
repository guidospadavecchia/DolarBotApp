import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Function onPressed;

  const DialogButton({
    Key key,
    this.text,
    this.icon,
    this.iconColor,
    this.textColor,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.only(top: 7, right: 25, left: 15, bottom: 7),
        ),
        overlayColor: MaterialStateColor.resolveWith(
            (states) => ThemeManager.getDrawerMenuItemIconColor(context).withOpacity(0.2)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return ThemeManager.getButtonColor(context);
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
            size: 32,
            color: iconColor ?? ThemeManager.getPrimaryAccentColor(context),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
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

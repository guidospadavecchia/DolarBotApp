import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  const DialogButton({
    Key key,
    this.text,
    this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(top: 10, right: 30, left: 20, bottom: 10),
      color: ThemeManager.getGlobalBackgroundColor(context),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: ThemeManager.getGlobalAccentColor(context),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

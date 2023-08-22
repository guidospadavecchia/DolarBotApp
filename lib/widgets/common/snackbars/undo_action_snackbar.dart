import '../../../classes/theme_manager.dart';
import 'package:flutter/material.dart';

class UndoActionSnackBarContent extends StatelessWidget {
  final Icon icon;
  final String text;
  final void Function()? onUndoAction;

  const UndoActionSnackBarContent({
    Key? key,
    required this.icon,
    required this.text,
    required this.onUndoAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: ThemeManager.getPrimaryTextColor(context),
                fontFamily: 'Raleway',
              ),
            ),
          ],
        ),
        TextButton(
          style: TextButton.styleFrom(
            side: BorderSide.none,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
          ),
          onPressed: onUndoAction,
          child: Text(
            "DESHACER",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}

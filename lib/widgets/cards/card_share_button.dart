import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/common/icon_fonts.dart';
import 'package:flutter/material.dart';

class CardShareButton extends StatelessWidget {
  final Function /*!*/ onSharePressed;

  const CardShareButton({
    Key key,
    this.onSharePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Theme(
        data: ThemeManager.getTooltipTheme(context),
        child: Tooltip(
          margin: const EdgeInsets.only(right: 50),
          verticalOffset: -45,
          message: "Compartir 📲",
          child: RawMaterialButton(
            shape: CircleBorder(),
            constraints: const BoxConstraints(minWidth: 50, minHeight: 80),
            onPressed: () => onSharePressed(),
            child: const Icon(
              IconFonts.share,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

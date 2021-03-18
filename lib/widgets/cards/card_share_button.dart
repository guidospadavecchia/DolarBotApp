import 'package:dolarbot_app/screens/common/icon_fonts.dart';
import 'package:flutter/material.dart';

class CardShareButton extends StatelessWidget {
  final Function onSharePressed;

  const CardShareButton({
    Key key,
    this.onSharePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Tooltip(
        preferBelow: false,
        message: "Compartir 📲",
        child: RawMaterialButton(
          shape: CircleBorder(),
          constraints: BoxConstraints(minWidth: 50, minHeight: 80),
          onPressed: onSharePressed,
          child: Icon(
            IconFonts.share,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

import 'package:dolarbot_app/widgets/cards/card_share.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/widgets/cards/card_share.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final bool showButtons;
  final Function onSharePressed;
  final CardShareButton shareButton;

  const CardHeader({
    Key key,
    this.title,
    this.showButtons = true,
    this.onSharePressed,
    this.shareButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 7,
                      color: Colors.black54,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          shareButton ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}

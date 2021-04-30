import 'package:dolarbot_app/widgets/cards/card_share_button.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/widgets/cards/card_share_button.dart';

class CardHeader extends StatelessWidget {
  final String /*!*/ title;
  final CardShareButton shareButton;

  const CardHeader({
    Key key,
    this.title,
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
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      blurRadius: 7,
                      color: Colors.black54,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          shareButton ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

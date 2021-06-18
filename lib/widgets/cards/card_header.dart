import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/widgets/cards/card_share_button.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/widgets/cards/card_share_button.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final double? titleFontSize;
  final CardShareButton? shareButton;

  const CardHeader({
    Key? key,
    required this.title,
    this.titleFontSize,
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
                  fontSize: titleFontSize ?? SizeConfig.blockSizeVertical * 3,
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

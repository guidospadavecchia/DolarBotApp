import 'package:flutter/material.dart';
import 'package:dolarbot_app/widgets/common/pills/pill.dart';

class CardLogo extends StatelessWidget {
  final String? iconAsset;
  final IconData? iconData;
  final String tag;

  const CardLogo({
    Key? key,
    this.iconAsset,
    this.iconData,
    required this.tag,
  })   : assert(iconAsset != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 15),
      child: Column(
        children: [
          iconAsset != null
              ? Container(
                  child: Image.asset(
                    iconAsset!,
                    width: 32,
                    height: 32,
                    filterQuality: FilterQuality.high,
                  ),
                )
              : Container(
                  child: Icon(
                    iconData,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Pill(
              text: tag,
            ),
          ),
        ],
      ),
    );
  }
}

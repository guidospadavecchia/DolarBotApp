import 'package:dolarbot_app/classes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/widgets/common/pills/pill.dart';

class CardLogo extends StatelessWidget {
  final String? iconAsset;
  final IconData? iconData;
  final bool showDragHandle;
  final String tag;

  const CardLogo({
    Key? key,
    this.iconAsset,
    this.iconData,
    this.showDragHandle = true,
    required this.tag,
  })   : assert(iconAsset != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 15),
      child: Column(
        children: [
          iconAsset != null
              ? Container(
                  child: Image.asset(
                    iconAsset!,
                    width: SizeConfig.blockSizeVertical * 4,
                    height: SizeConfig.blockSizeVertical * 4,
                    filterQuality: FilterQuality.high,
                  ),
                )
              : Container(
                  child: Icon(
                    iconData,
                    size: SizeConfig.blockSizeVertical * 4,
                    color: Colors.white,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Pill(
              text: tag,
            ),
          ),
          if (showDragHandle)
            Expanded(
              child: SizedBox.shrink(),
            ),
          if (showDragHandle)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(
                Icons.drag_handle_rounded,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
        ],
      ),
    );
  }
}

import '../../classes/size_config.dart';
import 'currency_info.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/widgets/currency_info/currency_info.dart';

class CurrencyInfoContainer extends StatelessWidget {
  final List<CurrencyInfo> items;

  const CurrencyInfoContainer({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 5),
      height: SizeConfig.screenHeight * 0.7,
      child: Wrap(
        children: [
          for (var i = 0; i < items.length; i++)
            Container(
              child: Wrap(
                children: [items[i], if (i != items.length - 1) Divider(endIndent: 100, indent: 100, color: Colors.white38, height: _getHeight())],
              ),
            ),
        ],
      ),
    );
  }

  double _getHeight() {
    if (items.length == 2) return SizeConfig.blockSizeVertical * 15;
    if (items.length == 3) return SizeConfig.blockSizeVertical * 8;

    return SizeConfig.blockSizeVertical * 5;
  }
}

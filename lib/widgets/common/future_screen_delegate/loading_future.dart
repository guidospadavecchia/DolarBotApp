import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingFuture extends StatelessWidget {
  const LoadingFuture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Center(
        child: SizedBox(
          width: 64,
          height: 64,
          child: LoadingIndicator(
            indicatorType: Indicator.ballScale,
            color: ThemeManager.getPrimaryAccentColor(context),
          ),
        ),
      ),
      padding: EdgeInsets.only(top: 30, bottom: 10),
    );
  }
}

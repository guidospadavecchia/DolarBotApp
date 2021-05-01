import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

export 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  final Indicator indicatorType;
  final double size;
  final Color? color;

  const LoadingScreen({
    Key? key,
    this.indicatorType = Indicator.ballScale,
    this.size = 64,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: size,
        height: size,
        child: LoadingIndicator(
          indicatorType: indicatorType,
          color: color != null ? color : ThemeManager.getForegroundColor(),
        ),
      ),
    );
  }
}

import 'package:adaptive_theme/adaptive_theme.dart';
import '../../../util/util.dart';
import 'package:flutter/material.dart';

class GitHub extends StatelessWidget {
  final Color? color;
  final double imageSize;
  final double fontSize;

  GitHub({
    Key? key,
    this.color,
    this.imageSize = 24,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Visitanos en GitHub",
      child: GestureDetector(
        child: Row(
          children: [
            Image.asset(
              'assets/images/general/github.png',
              width: imageSize,
              height: imageSize,
              filterQuality: FilterQuality.high,
              color: color == null ? (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.black87 : Colors.white70) : color,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "GitHub",
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Raleway',
                color: color == null ? (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? Colors.black87 : Colors.white70) : color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        onTap: () => Util.launchURL(Util.cfg.getDeepValue<String>("github:app")!),
      ),
    );
  }
}

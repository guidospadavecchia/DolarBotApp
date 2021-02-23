import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class GitHub extends StatelessWidget {
  final cfg = GlobalConfiguration();
  final Color color;
  final double imageSize;
  final double fontSize;

  GitHub({
    Key key,
    this.color,
    this.imageSize = 24,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/general/github.png',
          width: imageSize,
          height: imageSize,
          filterQuality: FilterQuality.high,
          color: color == null
              ? (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                  ? Colors.black87
                  : Colors.white70)
              : color,
        ),
        SizedBox(
          width: 10,
        ),
        Tooltip(
          message: "Visitanos en GitHub",
          child: RichText(
            text: TextSpan(
              text: "GitHub",
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Raleway',
                color: color == null
                    ? (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                        ? Colors.black87
                        : Colors.white70)
                    : color,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Util.launchURL(cfg.getDeepValue("github:app")),
            ),
          ),
        ),
      ],
    );
  }
}

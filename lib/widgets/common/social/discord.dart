import 'package:dolarbot_app/util/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class Discord extends StatelessWidget {
  final cfg = GlobalConfiguration();

  final double imageSize;
  final double fontSize;

  Discord({
    Key key,
    this.imageSize = 24,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/general/discord.png',
          width: imageSize,
          height: imageSize,
          filterQuality: FilterQuality.high,
        ),
        SizedBox(
          width: 10,
        ),
        Tooltip(
          message: "¡Unite a nuestro Discord!",
          child: RichText(
            text: TextSpan(
              text: "Discord",
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Raleway',
                color: Color.fromRGBO(114, 137, 218, 1),
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Util.launchURL(cfg.get("discordUrl")),
            ),
          ),
        ),
      ],
    );
  }
}

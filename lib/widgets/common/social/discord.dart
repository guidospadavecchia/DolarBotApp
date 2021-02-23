import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class Discord extends StatelessWidget {
  final cfg = GlobalConfiguration();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/general/discord.png',
          width: 24,
          height: 24,
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
                fontSize: 14,
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

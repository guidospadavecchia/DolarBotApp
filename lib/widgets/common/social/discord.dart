import '../../../util/util.dart';
import 'package:flutter/material.dart';

class Discord extends StatelessWidget {
  final double imageSize;
  final double fontSize;

  Discord({
    Key? key,
    this.imageSize = 24,
    this.fontSize = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "¡Unite a nuestro Discord!",
      child: GestureDetector(
        child: Row(
          children: [
            Image.asset(
              'assets/images/general/discord.png',
              width: imageSize,
              height: imageSize,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Discord",
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: 'Raleway',
                color: const Color.fromRGBO(88, 101, 242, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        onTap: () => Util.launchURL(Util.cfg.get("discordUrl").toString()),
      ),
    );
  }
}

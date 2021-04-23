import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Color color;
  final double opacity;

  const ErrorScreen({
    Key key,
    this.color,
    this.opacity = 0.6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.7,
          child: Text(
            "Ouch! Ocurrió un error\nal obtener la cotización",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Raleway",
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Opacity(
          opacity: opacity,
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                    color == null
                        ? ThemeManager.getForegroundColor().withOpacity(opacity)
                        : color.withOpacity(opacity),
                    BlendMode.srcATop),
                image: AssetImage("assets/images/general/error.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

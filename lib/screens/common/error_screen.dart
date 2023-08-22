import '../../classes/size_config.dart';
import '../../classes/theme_manager.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Color? color;
  final double opacity;
  final double textOpacity;

  const ErrorScreen({
    Key? key,
    this.color,
    this.opacity = 0.5,
    this.textOpacity = 0.7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: opacity,
          child: Container(
            height: SizeConfig.screenHeight / 5,
            decoration: BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                    color == null ? ThemeManager.getForegroundColor().withOpacity(opacity) : color!.withOpacity(opacity), BlendMode.srcATop),
                image: const AssetImage("assets/images/general/error.png"),
              ),
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        Opacity(
          opacity: textOpacity,
          child: Text(
            "Ouch! Ocurrió un error\nal obtener la cotización",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 3,
              fontFamily: "Raleway",
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

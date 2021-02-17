import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class ErrorFuture extends StatelessWidget {
  const ErrorFuture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Ocurrió un error al\nverificar la cotización",
          style: TextStyle(
              fontSize: 24,
              fontFamily: "Raleway",
              color: ThemeManager.getPrimaryTextColor(context)),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 6,
          decoration: BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                  ThemeManager.getGlobalBackgroundColor(context)
                      .withOpacity(0.8),
                  BlendMode.srcATop),
              image: AssetImage("assets/images/general/error.png"),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class EmptyFavorites extends StatelessWidget {
  final String topText;
  final String bottomText;
  final double imageOpacity;
  final double textOpacity;

  const EmptyFavorites({
    Key key,
    this.topText,
    this.bottomText,
    this.imageOpacity = 0.4,
    this.textOpacity = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Opacity(
              opacity: textOpacity,
              child: Text(
                topText ?? "¡Aquí aparecerán tus cotizaciones favoritas!",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Opacity(
              opacity: imageOpacity,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset("assets/images/general/home_bg.png"),
              ),
            ),
            SizedBox(height: 50),
            Opacity(
              opacity: textOpacity,
              child: Text(
                bottomText ??
                    "Ahora mismo no tenés ninguna. Podés dirigirte a cualquier cotización y agregarla desde allí",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

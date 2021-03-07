import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyFavorites extends StatelessWidget {
  const EmptyFavorites({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 1,
        child: Container(
          alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Text(
                "Acá aparecerán tus cotizaciones favoritas.",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Icon(
                FontAwesomeIcons.solidHandPointDown,
                size: 48,
                color: ThemeManager.getPrimaryAccentColor(context)
                    .withOpacity(0.8),
              ),
              SizedBox(height: 30),
              Opacity(
                opacity: 0.7,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Image.asset("assets/images/general/home_bg.png"),
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Ahora mismo no tenés ninguna, pero podés dirigirte a cualquier cotización y agregarla desde allí.",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}

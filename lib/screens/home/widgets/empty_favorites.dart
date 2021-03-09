import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/foundation.dart';
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
    return Container(
      margin: const EdgeInsets.only(bottom: 100),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: textOpacity,
              child: Text(
                topText ?? "Tu inicio está vacío",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.8),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            Opacity(
              opacity: imageOpacity,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset("assets/images/general/home_bg.png"),
              ),
            ),
            Opacity(
              opacity: textOpacity,
              child: Text(
                bottomText ??
                    "Podés dirigirte a cualquier cotización y agregarla como favorita desde allí.",
                style: TextStyle(
                    height: 1.3,
                    fontSize: 20,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.9)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmptyFavorites extends StatelessWidget {
  final String topText;
  final String bottomText;
  final double imageOpacity;
  final double textOpacity;

  const EmptyFavorites({
    Key? key,
    this.topText = "Tu inicio está vacío",
    this.bottomText = "Podés dirigirte a cualquier cotización y agregarla como favorita desde allí",
    this.imageOpacity = 0.4,
    this.textOpacity = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: (Scaffold.of(context).appBarMaxHeight ?? 0) / 2),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 8),
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Opacity(
              opacity: textOpacity,
              child: Text(
                topText,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 3.5,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context).withOpacity(0.8),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Opacity(
              opacity: imageOpacity,
              child: SizedBox(
                width: SizeConfig.screenWidth * 0.7,
                child: Image.asset("assets/images/general/home_bg.png"),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Opacity(
              opacity: textOpacity,
              child: Text(
                bottomText,
                style: TextStyle(
                    height: SizeConfig.blockSizeVertical * 0.18,
                    fontSize: SizeConfig.blockSizeVertical * 2.5,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context).withOpacity(0.9)),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

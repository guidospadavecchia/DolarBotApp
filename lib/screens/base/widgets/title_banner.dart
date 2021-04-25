import 'package:flutter/material.dart';

class TitleBanner extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final String iconAsset;
  final IconData iconData;
  final double iconSize;
  final bool showTimeStamp;
  final String timeStampValue;
  final TextStyle timeStampTextStyle;
  final double topPadding;
  final EdgeInsets innerPadding;

  TitleBanner({
    Key key,
    this.text,
    this.textStyle = const TextStyle(
      fontSize: 28,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.iconAsset,
    this.iconData,
    this.iconSize = 36,
    this.showTimeStamp = false,
    this.timeStampValue,
    this.timeStampTextStyle = const TextStyle(
      fontSize: 12,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
    this.topPadding = 50,
    this.innerPadding = const EdgeInsets.all(20),
  })  : assert(
          (iconAsset != null || iconData != null) && (!showTimeStamp || timeStampValue != null),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        children: [
          Container(
            color: Colors.black12,
            padding: innerPadding,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconAsset != null
                    ? Container(
                        child: Image.asset(
                          iconAsset,
                          width: iconSize,
                          height: iconSize,
                          filterQuality: FilterQuality.high,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        child: Icon(
                          iconData,
                          size: iconSize,
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(width: 20),
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  child: FittedBox(
                    fit: text.length > 10 ? BoxFit.fitWidth : BoxFit.none,
                    child: Text(
                      text,
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showTimeStamp)
            Opacity(
              opacity: 1,
              child: Container(
                alignment: Alignment.center,
                height: 22,
                width: double.infinity,
                color: Colors.black26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.alarm,
                      size: 16,
                      color: Colors.white70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: Text(
                        timeStampValue,
                        style: timeStampTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

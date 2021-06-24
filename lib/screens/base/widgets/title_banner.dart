import 'package:dolarbot_app/classes/size_config.dart';
import 'package:flutter/material.dart';

class TitleBanner extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final String? iconAsset;
  final IconData? iconData;
  final double? iconSize;
  final bool showTimeStamp;
  final String? timeStampValue;
  final TextStyle? timeStampTextStyle;
  final double? topPadding;
  final EdgeInsets? innerPadding;

  TitleBanner({
    Key? key,
    required this.text,
    this.textStyle,
    this.iconAsset,
    this.iconData,
    this.iconSize,
    this.showTimeStamp = false,
    this.timeStampValue,
    this.timeStampTextStyle,
    this.topPadding,
    this.innerPadding,
  })  : assert(
          (iconAsset != null || iconData != null) && (!showTimeStamp || timeStampValue != null),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? Scaffold.of(context).appBarMaxHeight!),
      child: Column(
        children: [
          Container(
            color: Colors.black12,
            padding: innerPadding ?? EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconAsset != null
                    ? Container(
                        child: Image.asset(
                          iconAsset!,
                          width: iconSize ?? SizeConfig.blockSizeVertical * 5,
                          height: iconSize ?? SizeConfig.blockSizeVertical * 5,
                          filterQuality: FilterQuality.high,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        child: Icon(
                          iconData,
                          size: iconSize ?? SizeConfig.blockSizeVertical * 5,
                          color: Colors.white,
                        ),
                      ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 5),
                Container(
                  constraints: BoxConstraints(maxWidth: SizeConfig.screenHeight * 0.7),
                  child: FittedBox(
                    fit: text.length > 10 ? BoxFit.fitWidth : BoxFit.none,
                    child: Text(
                      text,
                      style: textStyle ??
                          TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2.7,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                height: SizeConfig.blockSizeVertical * 3.5,
                width: double.infinity,
                color: Colors.black26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm,
                      size: SizeConfig.blockSizeVertical * 2,
                      color: Colors.white70,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                      child: Text(
                        timeStampValue!,
                        style: timeStampTextStyle ??
                            TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.normal,
                              color: Colors.white70,
                            ),
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

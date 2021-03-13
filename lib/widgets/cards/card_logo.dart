import 'package:flutter/material.dart';

class CardLogo extends StatelessWidget {
  final String iconAsset;
  final IconData iconData;
  final String tag;

  const CardLogo({
    Key key,
    this.iconAsset,
    this.iconData,
    @required this.tag,
  })  : assert(iconAsset != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 15),
      child: Column(
        children: [
          iconAsset != null
              ? Container(
                  child: Image.asset(
                    iconAsset,
                    width: 32,
                    height: 32,
                    filterQuality: FilterQuality.high,
                  ),
                )
              : Container(
                  child: Icon(
                    iconData,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              width: 45,
              padding: EdgeInsets.only(top: 3, bottom: 2),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                tag.toUpperCase(),
                style: TextStyle(
                  fontSize: 9,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color color;
  final Color foreColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double? width;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  final bool capitalizeText;

  const Pill({
    Key? key,
    required this.text,
    this.icon,
    this.color = Colors.black54,
    this.foreColor = Colors.white,
    this.fontSize = 9,
    this.fontWeight = FontWeight.bold,
    this.width,
    this.padding = const EdgeInsets.only(top: 3, bottom: 3),
    this.borderRadius,
    this.capitalizeText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? (icon != null ? 50 : 45),
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Row(
              children: [
                Icon(
                  icon!,
                  color: Colors.white,
                  size: fontSize,
                ),
                const SizedBox(
                  width: 3,
                ),
              ],
            ),
          Text(
            capitalizeText ? text.toUpperCase() : text,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'Raleway',
              fontWeight: fontWeight,
              color: foreColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

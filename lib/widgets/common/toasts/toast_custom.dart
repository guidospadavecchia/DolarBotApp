import 'package:dolarbot_app/classes/size_config.dart';
import 'package:flutter/material.dart';

class ToastCustom extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final double size;
  final Color backgroundColor;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;

  const ToastCustom({
    Key key,
    @required this.icon,
    this.iconColor = Colors.white,
    this.iconSize = 30,
    this.size = 50,
    this.backgroundColor = Colors.black87,
    this.alignment = Alignment.bottomCenter,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: SizeConfig.screenHeight / 25),
      child: Align(
        alignment: alignment,
        child: Container(
          alignment: Alignment.center,
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

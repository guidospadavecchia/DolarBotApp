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
    this.padding = const EdgeInsets.only(bottom: 30),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: alignment,
        child: Container(
          alignment: Alignment.center,
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            boxShadow: [
              BoxShadow(blurRadius: 5, color: Colors.black45, spreadRadius: 0)
            ],
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

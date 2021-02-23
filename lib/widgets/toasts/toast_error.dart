import 'package:flutter/material.dart';

class ToastError extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final double size;
  final BorderRadius borderRadius;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;

  const ToastError(
      {Key key,
      this.backgroundColor,
      this.iconColor,
      this.iconSize,
      this.size,
      this.borderRadius,
      this.alignment,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Align(
        alignment: alignment ?? FractionalOffset.bottomCenter,
        child: Padding(
          padding: padding ?? EdgeInsets.only(bottom: 30),
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(30.0),
            child: Container(
              width: size ?? 50.0,
              height: size ?? 50.0,
              color: backgroundColor ?? Colors.grey.withOpacity(0.3),
              child: Icon(
                Icons.close,
                size: iconSize ?? 30.0,
                color: iconColor ?? Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

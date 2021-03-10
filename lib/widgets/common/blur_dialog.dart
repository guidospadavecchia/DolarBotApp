import 'dart:ui';

import 'package:flutter/material.dart';

class BlurDialog extends StatelessWidget {
  final double strength;
  final Dialog dialog;

  const BlurDialog({
    Key key,
    this.strength = 5,
    @required this.dialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: strength, sigmaY: strength),
      child: dialog,
    );
  }
}

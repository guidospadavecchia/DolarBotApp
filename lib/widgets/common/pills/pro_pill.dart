import 'package:flutter/material.dart';
import 'package:dolarbot_app/widgets/common/pills/pill.dart';

class ProPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Pill(
      text: "PRO",
      icon: Icons.star,
      fontSize: 10,
      foreColor: Colors.white,
      color: Colors.deepOrange[700]!,
    );
  }
}

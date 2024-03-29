import '../../../classes/theme_manager.dart';
import 'toast_custom.dart';
import 'package:flutter/material.dart';

class ToastOk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToastCustom(
      icon: Icons.check,
      iconColor: Colors.white,
      backgroundColor: ThemeManager.getPrimaryColor(),
    );
  }
}

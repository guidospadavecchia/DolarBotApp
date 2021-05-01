import 'package:dolarbot_app/widgets/common/toasts/toast_custom.dart';
import 'package:flutter/material.dart';

class ToastError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToastCustom(
      icon: Icons.close,
      iconColor: Colors.white,
      backgroundColor: Colors.red[800]!,
    );
  }
}

import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:flutter/material.dart';

class ProFeaturesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: Desarrollar
    return BlurDialog(
      dialog: Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          height: 100,
          width: 50,
          alignment: Alignment.center,
          child: Placeholder(),
        ),
      ),
    );
  }
}

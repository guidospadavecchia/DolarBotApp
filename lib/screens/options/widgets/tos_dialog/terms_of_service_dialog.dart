import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
import 'package:dolarbot_app/widgets/common/text_dialog.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class TermsOfServiceDialog extends StatefulWidget {
  @override
  _TermsOfServiceDialogState createState() => _TermsOfServiceDialogState();
}

class _TermsOfServiceDialogState extends State<TermsOfServiceDialog> {
  String? _text;
  bool _loaded = false;

  @override
  void initState() {
    _loadToS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return LoadingScreen();
    }

    return TextDialog(
      title: "Términos de uso",
      text: _text ?? '',
      buttonText: "Acepto",
      buttonIcon: Icons.check,
      textAlign: TextAlign.justify,
    );
  }

  Future _loadToS() async {
    rootBundle.loadString(DolarBotConstants.kTermosOfServiceFile).then(
      (value) {
        Map<String, dynamic> jsonValue = json.decode(value) as Map<String, dynamic>;
        WidgetsBinding.instance!.addPostFrameCallback(
          (_) => setState(() {
            _text = AppConfig.of(context).flavor == AppFlavor.Lite
                ? jsonValue["lite"]
                : jsonValue["pro"];
            _loaded = true;
          }),
        );
      },
    );
  }
}

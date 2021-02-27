import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/base/base_calculator.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';

import 'package:flutter/material.dart';

class FabOptionCalculatorDialog extends StatefulWidget {
  final BaseCalculatorScreen calculator;
  final BaseCalculatorScreen calculatorReversed;

  const FabOptionCalculatorDialog({
    Key key,
    @required this.calculator,
    this.calculatorReversed,
  }) : super(key: key);

  @override
  _FabOptionCalculatorDialogState createState() =>
      _FabOptionCalculatorDialogState();
}

class _FabOptionCalculatorDialogState extends State<FabOptionCalculatorDialog> {
  bool isReversed = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10, width: 2),
          gradient: AdaptiveTheme.of(context).brightness == Brightness.dark
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(14, 24, 29, 1),
                    Color.fromRGBO(14, 24, 29, 0.4)
                  ],
                )
              : null,
        ),
        padding: EdgeInsets.only(top: 30, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            !isReversed ? widget.calculator : widget.calculatorReversed,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.calculatorReversed != null)
                  DialogButton(
                      onPressed: () => {
                            setState(() {
                              isReversed = widget.calculatorReversed != null &&
                                  !isReversed;
                            })
                          },
                      icon: Icons.compare_arrows,
                      text: "Invertir"),
                DialogButton(
                  text: 'Cerrar',
                  icon: Icons.close,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

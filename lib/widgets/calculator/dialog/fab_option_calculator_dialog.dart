import 'package:flutter/material.dart';

import '../../common/blur_dialog.dart';
import '../../common/simple_button.dart';
import '../base/base_calculator.dart';

class FabOptionCalculatorDialog extends StatefulWidget {
  final BaseCalculatorScreen calculator;
  final BaseCalculatorScreen? calculatorReversed;

  const FabOptionCalculatorDialog({
    Key? key,
    required this.calculator,
    this.calculatorReversed,
  }) : super(key: key);

  @override
  _FabOptionCalculatorDialogState createState() => _FabOptionCalculatorDialogState();
}

class _FabOptionCalculatorDialogState extends State<FabOptionCalculatorDialog> {
  bool isReversed = false;

  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 4,
            bottom: SizeConfig.blockSizeVertical * 3,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              !isReversed ? widget.calculator : widget.calculatorReversed!,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.calculatorReversed != null)
                    SimpleButton(
                        onPressed: () => {
                              setState(() {
                                isReversed = widget.calculatorReversed != null && !isReversed;
                              })
                            },
                        icon: Icons.compare_arrows,
                        text: "Invertir"),
                  SimpleButton(
                    text: 'Cerrar',
                    icon: Icons.close,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

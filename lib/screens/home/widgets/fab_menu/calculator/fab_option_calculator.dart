import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/screens/home/widgets/fab_menu/calculator/input_converted.dart';
import 'package:dolarbot_app/screens/home/widgets/fab_menu/calculator/input_dollar.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FabOptionCalculator extends StatefulWidget {
  final double buyValue;
  final double sellValue;
  final String decimalSeparator;
  final String thousandSeparator;

  const FabOptionCalculator({
    Key key,
    @required this.buyValue,
    @required this.sellValue,
    @required this.decimalSeparator,
    @required this.thousandSeparator,
  }) : super(key: key);

  @override
  _FabOptionCalculatorState createState() => _FabOptionCalculatorState();
}

class _FabOptionCalculatorState extends State<FabOptionCalculator> {
  MoneyMaskedTextController _textControllerUSD;
  MoneyMaskedTextController _textControllerBuyValue;
  MoneyMaskedTextController _textControllerSellValue;

  @override
  void initState() {
    createControllers();
    _textControllerUSD.addListener(() {
      setState(() {
        _setConversion();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textControllerUSD.dispose();
    _textControllerBuyValue.dispose();
    _textControllerSellValue.dispose();
    super.dispose();
  }

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
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputDollar(
              textController: _textControllerUSD,
            ),
            InputConverted(
              title: "Comprás a",
              textController: _textControllerBuyValue,
            ),
            InputConverted(
              title: "Vendés a",
              textController: _textControllerSellValue,
            ),
            DialogButton(
              text: 'Cerrar',
              icon: Icons.close,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  void createControllers() {
    _textControllerUSD = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: widget.decimalSeparator,
        thousandSeparator: widget.thousandSeparator,
        leftSymbol: "US\$ ");
    _textControllerBuyValue = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: widget.decimalSeparator,
        thousandSeparator: widget.thousandSeparator,
        leftSymbol: "\$ ");
    _textControllerSellValue = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: widget.decimalSeparator,
        thousandSeparator: widget.thousandSeparator,
        leftSymbol: "\$ ");
  }

  void _setConversion() {
    _textControllerBuyValue
        .updateValue(_textControllerUSD.numberValue * widget.buyValue);
    _textControllerSellValue
        .updateValue(_textControllerUSD.numberValue * widget.sellValue);
  }
}

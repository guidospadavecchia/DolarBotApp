import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/input_converted.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/input_dollar.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FabOptionFiatCalculator extends StatefulWidget {
  final double buyValue;
  final double sellValue;
  final String symbol;
  final String decimalSeparator;
  final String thousandSeparator;

  const FabOptionFiatCalculator({
    Key key,
    this.buyValue,
    this.sellValue,
    @required this.symbol,
    @required this.decimalSeparator,
    @required this.thousandSeparator,
  })  : assert(buyValue != null || sellValue != null),
        super(key: key);

  @override
  _FabOptionFiatCalculatorState createState() =>
      _FabOptionFiatCalculatorState();
}

class _FabOptionFiatCalculatorState extends State<FabOptionFiatCalculator> {
  MoneyMaskedTextController _textControllerInput;
  MoneyMaskedTextController _textControllerBuyValue;
  MoneyMaskedTextController _textControllerSellValue;

  @override
  void initState() {
    createControllers();
    _textControllerInput.addListener(() {
      setState(() {
        _setConversion();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textControllerInput.dispose();
    if (widget.buyValue != null) _textControllerBuyValue.dispose();
    if (widget.sellValue != null) _textControllerSellValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height *
        (widget.buyValue == null || widget.sellValue == null ? 0.35 : 0.45);
    double containerWidth = MediaQuery.of(context).size.width * 0.85;

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
        height: containerHeight,
        width: containerWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputDollar(
              textController: _textControllerInput,
            ),
            if (widget.sellValue != null)
              InputConverted(
                title: "Comprás a",
                textController: _textControllerSellValue,
              ),
            if (widget.buyValue != null)
              InputConverted(
                title: "Vendés a",
                textController: _textControllerBuyValue,
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
    _textControllerInput = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: widget.decimalSeparator,
        thousandSeparator: widget.thousandSeparator,
        leftSymbol: "${widget.symbol} ");
    if (widget.buyValue != null) {
      _textControllerBuyValue = MoneyMaskedTextController(
          precision: 2,
          decimalSeparator: widget.decimalSeparator,
          thousandSeparator: widget.thousandSeparator,
          leftSymbol: "\$ ");
    }
    if (widget.sellValue != null) {
      _textControllerSellValue = MoneyMaskedTextController(
          precision: 2,
          decimalSeparator: widget.decimalSeparator,
          thousandSeparator: widget.thousandSeparator,
          leftSymbol: "\$ ");
    }
  }

  void _setConversion() {
    if (widget.buyValue != null) {
      _textControllerBuyValue
          .updateValue(_textControllerInput.numberValue * widget.buyValue);
    }
    if (widget.sellValue != null) {
      _textControllerSellValue
          .updateValue(_textControllerInput.numberValue * widget.sellValue);
    }
  }
}

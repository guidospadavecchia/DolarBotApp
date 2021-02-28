import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_converted.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_amount.dart';
import 'package:intl/intl.dart';

class FiatCurrencyCalculatorReversed extends BaseCalculatorScreen {
  final double sellValue;
  final double sellValueWithTaxes;
  final String symbol;
  final String decimalSeparator;
  final String thousandSeparator;

  FiatCurrencyCalculatorReversed({
    Key key,
    this.sellValue,
    this.sellValueWithTaxes,
    @required this.symbol,
    @required this.decimalSeparator,
    @required this.thousandSeparator,
  })  : assert((sellValue != null) ^ (sellValueWithTaxes != null)),
        super(
            key: key,
            symbol: symbol,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator);

  @override
  _FiatCurrencyCalculatorReversedState createState() =>
      _FiatCurrencyCalculatorReversedState(
        sellValue,
        sellValueWithTaxes,
        symbol,
        decimalSeparator,
        thousandSeparator,
      );
}

class _FiatCurrencyCalculatorReversedState
    extends BaseCalculatorState<FiatCurrencyCalculatorReversed>
    with BaseCalculator {
  final double sellValue;
  final double sellValueWithTaxes;
  final String symbol;
  final String decimalSeparator;
  final String thousandSeparator;
  MoneyMaskedTextController _textControllerInput;
  TextEditingController _textControllerSellValue;
  TextEditingController _textControllerSellValueWithTaxes;

  _FiatCurrencyCalculatorReversedState(
    this.sellValue,
    this.sellValueWithTaxes,
    this.symbol,
    this.decimalSeparator,
    this.thousandSeparator,
  );

  @override
  void initState() {
    _createControllers();
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
    if (sellValue != null) _textControllerSellValue.dispose();
    if (sellValueWithTaxes != null) _textControllerSellValueWithTaxes.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputAmount(
          textController: _textControllerInput,
        ),
        SizedBox(
          height: 30,
        ),
        if (sellValue != null)
          InputConverted(
            title: "Comprás",
            textController: _textControllerSellValue,
          ),
        if (sellValueWithTaxes != null)
          InputConverted(
            title: "Comprás con impuestos",
            textController: _textControllerSellValueWithTaxes,
          ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _createControllers() {
    _textControllerInput = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
        leftSymbol: "\$ ");
    if (sellValue != null) {
      _textControllerSellValue = TextEditingController(text: "\$ 0");
    }
    if (sellValueWithTaxes != null) {
      _textControllerSellValueWithTaxes = TextEditingController(text: "\$ 0");
    }
  }

  void _setConversion() {
    NumberFormat numberFormat = getNumberFormat(context);
    if (sellValue != null) {
      String formattedSellValue = numberFormat.format(
          sellValue > 0 ? _textControllerInput.numberValue / sellValue : 0);
      _textControllerSellValue.text = "$symbol $formattedSellValue";
    }
    if (sellValueWithTaxes != null) {
      String formattedSellValueWithTaxes = numberFormat.format(
          sellValueWithTaxes > 0
              ? _textControllerInput.numberValue / sellValueWithTaxes
              : 0);
      _textControllerSellValueWithTaxes.text =
          "$symbol $formattedSellValueWithTaxes";
    }
  }
}

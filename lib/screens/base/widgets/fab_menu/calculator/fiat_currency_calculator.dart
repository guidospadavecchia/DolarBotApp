import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_converted.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_amount.dart';

class FiatCurrencyCalculator extends BaseCalculatorScreen {
  final double buyValue;
  final double sellValue;
  final double sellValueWithTaxes;
  final String symbol;
  final String decimalSeparator;
  final String thousandSeparator;

  FiatCurrencyCalculator({
    Key key,
    this.buyValue,
    this.sellValue,
    this.sellValueWithTaxes,
    @required this.symbol,
    @required this.decimalSeparator,
    @required this.thousandSeparator,
  })  : assert(buyValue != null ||
            sellValue != null ||
            sellValueWithTaxes != null),
        super(
            key: key,
            symbol: symbol,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator);

  @override
  _FiatCurrencyCalculatorState createState() => _FiatCurrencyCalculatorState(
        buyValue,
        sellValue,
        sellValueWithTaxes,
        symbol,
        decimalSeparator,
        thousandSeparator,
      );
}

class _FiatCurrencyCalculatorState
    extends BaseCalculatorState<FiatCurrencyCalculator> with BaseCalculator {
  final double buyValue;
  final double sellValue;
  final double sellValueWithTaxes;
  final String symbol;
  final String decimalSeparator;
  final String thousandSeparator;
  MoneyMaskedTextController _textControllerInput;
  MoneyMaskedTextController _textControllerBuyValue;
  MoneyMaskedTextController _textControllerSellValue;
  MoneyMaskedTextController _textControllerSellValueWithTaxes;

  _FiatCurrencyCalculatorState(
    this.buyValue,
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
    if (buyValue != null) _textControllerBuyValue.dispose();
    if (sellValue != null) _textControllerSellValue.dispose();
    if (sellValueWithTaxes != null) _textControllerSellValueWithTaxes.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InputAmount(
            textController: _textControllerInput,
            symbol: symbol,
          ),
          if (sellValue != null)
            InputConverted(
              title: "Comprás a",
              textController: _textControllerSellValue,
            ),
          if (sellValueWithTaxes != null)
            InputConverted(
              title: "(Con impuestos)",
              textController: _textControllerSellValueWithTaxes,
            ),
          Divider(
            color: Colors.black,
            indent: 80,
            endIndent: 50,
            height: 0,
          ),
          if (buyValue != null)
            InputConverted(
              title: "Vendés a",
              textController: _textControllerBuyValue,
            ),
        ],
      ),
    );
  }

  void _createControllers() {
    _textControllerInput = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
        leftSymbol: "$symbol ");
    if (buyValue != null) {
      _textControllerBuyValue = MoneyMaskedTextController(
          precision: 2,
          decimalSeparator: decimalSeparator,
          thousandSeparator: thousandSeparator,
          leftSymbol: "\$ ");
    }
    if (sellValue != null) {
      _textControllerSellValue = MoneyMaskedTextController(
          precision: 2,
          decimalSeparator: decimalSeparator,
          thousandSeparator: thousandSeparator,
          leftSymbol: "\$ ");
    }
    if (sellValueWithTaxes != null) {
      _textControllerSellValueWithTaxes = MoneyMaskedTextController(
          precision: 2,
          decimalSeparator: decimalSeparator,
          thousandSeparator: thousandSeparator,
          leftSymbol: "\$ ");
    }
  }

  void _setConversion() {
    if (buyValue != null) {
      _textControllerBuyValue
          .updateValue(_textControllerInput.numberValue * buyValue);
    }
    if (sellValue != null) {
      _textControllerSellValue
          .updateValue(_textControllerInput.numberValue * sellValue);
    }
    if (sellValueWithTaxes != null) {
      _textControllerSellValueWithTaxes
          .updateValue(_textControllerInput.numberValue * sellValueWithTaxes);
    }
  }
}

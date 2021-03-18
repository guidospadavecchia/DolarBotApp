import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class FiatCurrencyCalculatorReversed extends BaseCalculatorScreen {
  final double sellValue;
  final double sellValueWithTaxes;
  final String symbol;
  final NumberFormat numberFormat;

  FiatCurrencyCalculatorReversed({
    Key key,
    this.sellValue,
    this.sellValueWithTaxes,
    @required this.symbol,
    @required this.numberFormat,
  })  : assert((sellValue != null) ^ (sellValueWithTaxes != null)),
        super(
          key: key,
          symbol: symbol,
          numberFormat: numberFormat,
        );

  @override
  _FiatCurrencyCalculatorReversedState createState() => _FiatCurrencyCalculatorReversedState(
        sellValue,
        sellValueWithTaxes,
        symbol,
        numberFormat,
      );
}

class _FiatCurrencyCalculatorReversedState
    extends BaseCalculatorState<FiatCurrencyCalculatorReversed> with BaseCalculator {
  final double sellValue;
  final double sellValueWithTaxes;
  final String symbol;
  final NumberFormat numberFormat;
  MoneyMaskedTextController _textControllerInput;
  TextEditingController _textControllerSellValue;
  TextEditingController _textControllerSellValueWithTaxes;

  _FiatCurrencyCalculatorReversedState(
    this.sellValue,
    this.sellValueWithTaxes,
    this.symbol,
    this.numberFormat,
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
        decimalSeparator: numberFormat.symbols.DECIMAL_SEP,
        thousandSeparator: numberFormat.symbols.GROUP_SEP,
        leftSymbol: "\$ ");
    if (sellValue != null) {
      _textControllerSellValue =
          TextEditingController(text: "US\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
    }
    if (sellValueWithTaxes != null) {
      _textControllerSellValueWithTaxes =
          TextEditingController(text: "US\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
    }
  }

  void _setConversion() {
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal d100 = Decimal.parse("100.00");
    if (sellValue != null && sellValue > 0) {
      Decimal dSellValue = Decimal.parse(sellValue.toString());
      Decimal value = ((input / dSellValue) * d100).truncate() / d100;
      String formattedSellValue = numberFormat.format(DecimalAdapter(value));
      _textControllerSellValue.text = "$symbol $formattedSellValue";
    }
    if (sellValueWithTaxes != null && sellValueWithTaxes > 0) {
      Decimal dSellValueWithTaxes = Decimal.parse(sellValueWithTaxes.toString());
      Decimal value = ((input / dSellValueWithTaxes) * d100).truncate() / d100;
      String formattedSellValueWithTaxes = numberFormat.format(DecimalAdapter(value));
      _textControllerSellValueWithTaxes.text = "$symbol $formattedSellValueWithTaxes";
    }
  }
}

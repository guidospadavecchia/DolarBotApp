import '../../classes/decimal_adapter.dart';
import 'base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class FiatCurrencyCalculatorReversed extends BaseCalculatorScreen {
  final double sellValue;
  final double? sellValueWithTaxes;
  final String symbol;
  final NumberFormat numberFormat;

  FiatCurrencyCalculatorReversed({
    Key? key,
    required this.sellValue,
    this.sellValueWithTaxes,
    required this.symbol,
    required this.numberFormat,
  }) : super(
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

class _FiatCurrencyCalculatorReversedState extends BaseCalculatorState<FiatCurrencyCalculatorReversed> with BaseCalculator {
  final double sellValue;
  final double? sellValueWithTaxes;
  final String symbol;
  final NumberFormat numberFormat;
  late MoneyMaskedTextController _textControllerInput;
  late TextEditingController _textControllerSellValue;
  late TextEditingController _textControllerSellValueWithTaxes;

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
    _textControllerSellValue.dispose();
    if (sellValueWithTaxes != null) _textControllerSellValueWithTaxes.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputAmount(
          title: "Ingresá un monto en pesos:",
          textController: _textControllerInput,
          onSubmitted: onSubmitted,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        InputConverted(
          title: "Comprás",
          textController: _textControllerSellValue,
        ),
        if (sellValueWithTaxes != null)
          Column(
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              InputConverted(
                title: "Comprás con impuestos",
                textController: _textControllerSellValueWithTaxes,
              ),
            ],
          ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
      ],
    );
  }

  void _createControllers() {
    _textControllerInput = MoneyMaskedTextController(
        precision: 2, decimalSeparator: numberFormat.symbols.DECIMAL_SEP, thousandSeparator: numberFormat.symbols.GROUP_SEP, leftSymbol: "\$ ");
    _textControllerSellValue = TextEditingController();
    if (sellValueWithTaxes != null) {
      _textControllerSellValueWithTaxes = TextEditingController();
    }
  }

  void _setConversion() {
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal d100 = Decimal.parse("100.00");
    if (sellValue > 0) {
      Decimal dSellValue = Decimal.parse(sellValue.toString());
      Decimal value = ((input / dSellValue) * d100).truncate() / d100;
      String formattedSellValue = numberFormat.format(DecimalAdapter(value));
      _textControllerSellValue.text = "$symbol $formattedSellValue";
    }
    if (sellValueWithTaxes != null && sellValueWithTaxes! > 0) {
      Decimal dSellValueWithTaxes = Decimal.parse(sellValueWithTaxes.toString());
      Decimal value = ((input / dSellValueWithTaxes) * d100).truncate() / d100;
      String formattedSellValueWithTaxes = numberFormat.format(DecimalAdapter(value));
      _textControllerSellValueWithTaxes.text = "$symbol $formattedSellValueWithTaxes";
    }
  }
}

import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class MetalCalculatorReversed extends BaseCalculatorScreen {
  final double usdValue;
  final String unit;
  final NumberFormat numberFormat;

  MetalCalculatorReversed({
    Key? key,
    required this.usdValue,
    required this.unit,
    required this.numberFormat,
  }) : super(
          key: key,
          symbol: unit,
          numberFormat: numberFormat,
        );

  @override
  _MetalCalculatorReversedState createState() => _MetalCalculatorReversedState(
        usdValue,
        unit,
        numberFormat,
      );
}

class _MetalCalculatorReversedState extends BaseCalculatorState<MetalCalculatorReversed>
    with BaseCalculator {
  final double usdValue;
  final String unit;
  final NumberFormat numberFormat;
  late MoneyMaskedTextController _textControllerInput;
  late TextEditingController _textControllerValue;

  _MetalCalculatorReversedState(
    this.usdValue,
    this.unit,
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
    _textControllerValue.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputAmount(
          title: "Ingresá una cantidad en ${unit.toLowerCase()}s:",
          textController: _textControllerInput,
          maxDigits: 16,
        ),
        const SizedBox(
          height: 30,
        ),
        InputConverted(
          title: "Vendés a",
          textController: _textControllerValue,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _createControllers() {
    _textControllerInput = MoneyMaskedTextController(
      precision: getPrecision(usdValue),
      decimalSeparator: numberFormat.symbols.DECIMAL_SEP,
      thousandSeparator: numberFormat.symbols.GROUP_SEP,
    );
    _textControllerValue = TextEditingController();
  }

  void _setConversion() {
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal dUsdValue = Decimal.parse(usdValue.toString());
    String formattedUsdValue = numberFormat.format(
      DecimalAdapter(input * dUsdValue),
    );
    _textControllerValue.text = "US\$ $formattedUsdValue";
  }
}

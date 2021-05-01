import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class MetalCalculator extends BaseCalculatorScreen {
  final double usdValue;
  final String unit;
  final NumberFormat numberFormat;

  MetalCalculator({
    Key? key,
    required this.usdValue,
    required this.unit,
    required this.numberFormat,
  }) : super(key: key, symbol: unit, numberFormat: numberFormat);

  @override
  _MetalCalculatorState createState() => _MetalCalculatorState(
        usdValue,
        unit,
        numberFormat,
      );
}

class _MetalCalculatorState extends BaseCalculatorState<MetalCalculator> with BaseCalculator {
  final double usdValue;
  final String unit;
  final NumberFormat numberFormat;
  late MoneyMaskedTextController _textControllerInput;
  late TextEditingController _textControllerValue;

  _MetalCalculatorState(
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
          title: "Ingresá un monto en dólares:",
          textController: _textControllerInput,
        ),
        const SizedBox(
          height: 30,
        ),
        InputConverted(
          title: "Comprás",
          textController: _textControllerValue,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _createControllers() {
    String pluralUnit = "${unit.toLowerCase()}s";
    _textControllerInput = MoneyMaskedTextController(
      precision: 2,
      decimalSeparator: numberFormat.symbols.DECIMAL_SEP,
      thousandSeparator: numberFormat.symbols.GROUP_SEP,
      leftSymbol: "US\$ ",
    );
    _textControllerValue =
        TextEditingController(text: "0${numberFormat.symbols.DECIMAL_SEP}00 $pluralUnit");
  }

  void _setConversion() {
    if (usdValue > 0) {
      Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
      Decimal dUsdValue = Decimal.parse(usdValue.toString());
      Decimal d100 = Decimal.parse("100.00");
      Decimal d1 = Decimal.parse("1.00");
      Decimal value = ((input / dUsdValue) * d100).truncate() / d100;
      String formattedValue = numberFormat.format(
        DecimalAdapter(value),
      );
      String formattedUnit = value == d1 ? unit.toLowerCase() : "${unit.toLowerCase()}s";
      _textControllerValue.text = "$formattedValue $formattedUnit";
    }
  }
}

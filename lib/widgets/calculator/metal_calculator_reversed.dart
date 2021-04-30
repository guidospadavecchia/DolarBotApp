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
    Key key,
    @required this.usdValue,
    @required this.unit,
    @required this.numberFormat,
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
  /*late*/ MoneyMaskedTextController _textControllerInput;
  /*late*/ TextEditingController _textControllerValue;

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
          maxDigits: 9,
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
    String pluralUnit = "${unit.toLowerCase()}s";
    _textControllerInput = MoneyMaskedTextController(
      precision: 2,
      decimalSeparator: numberFormat.symbols.DECIMAL_SEP,
      thousandSeparator: numberFormat.symbols.GROUP_SEP,
      rightSymbol: " $pluralUnit",
    );
    _textControllerValue =
        TextEditingController(text: "US\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
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

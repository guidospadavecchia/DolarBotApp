import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_converted.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_amount.dart';
import 'package:intl/intl.dart';

class MetalCalculatorReversed extends BaseCalculatorScreen {
  final double usdValue;
  final String unit;
  final String decimalSeparator;
  final String thousandSeparator;

  MetalCalculatorReversed({
    Key key,
    @required this.usdValue,
    @required this.unit,
    @required this.decimalSeparator,
    @required this.thousandSeparator,
  }) : super(
            key: key,
            symbol: unit,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator);

  @override
  _MetalCalculatorReversedState createState() => _MetalCalculatorReversedState(
        usdValue,
        unit,
        decimalSeparator,
        thousandSeparator,
      );
}

class _MetalCalculatorReversedState
    extends BaseCalculatorState<MetalCalculatorReversed> with BaseCalculator {
  final double usdValue;
  final String unit;
  final String decimalSeparator;
  final String thousandSeparator;
  MoneyMaskedTextController _textControllerInput;
  TextEditingController _textControllerValue;

  _MetalCalculatorReversedState(
    this.usdValue,
    this.unit,
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
    _textControllerValue.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputAmount(
          title: "Ingresá la cantidad:",
          textController: _textControllerInput,
          maxDigits: 9,
        ),
        SizedBox(
          height: 30,
        ),
        InputConverted(
          title: "Vendés a",
          textController: _textControllerValue,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _createControllers() {
    String pluralUnit = "${unit.toLowerCase()}s";
    _textControllerInput = MoneyMaskedTextController(
      precision: 2,
      decimalSeparator: decimalSeparator,
      thousandSeparator: thousandSeparator,
      rightSymbol: " $pluralUnit",
    );
    _textControllerValue = TextEditingController(text: "US\$ 0");
  }

  void _setConversion() {
    NumberFormat numberFormat = getNumberFormat(context);
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal dUsdValue = Decimal.parse(usdValue.toString());
    String formattedUsdValue = numberFormat.format(
      DecimalAdapter(input * dUsdValue),
    );
    _textControllerValue.text = "US\$ $formattedUsdValue";
  }
}

import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_converted.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_amount.dart';
import 'package:intl/intl.dart';

class CryptoCalculatorReversed extends BaseCalculatorScreen {
  final double usdValue;
  final String cryptoCode;
  final String decimalSeparator;
  final String thousandSeparator;

  CryptoCalculatorReversed({
    Key key,
    @required this.usdValue,
    @required this.cryptoCode,
    @required this.decimalSeparator,
    @required this.thousandSeparator,
  }) : super(
            key: key,
            symbol: cryptoCode,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator);

  @override
  _CryptoCalculatorReversedState createState() =>
      _CryptoCalculatorReversedState(
        usdValue,
        cryptoCode,
        decimalSeparator,
        thousandSeparator,
      );
}

class _CryptoCalculatorReversedState
    extends BaseCalculatorState<CryptoCalculatorReversed> with BaseCalculator {
  final double usdValue;
  final String cryptoCode;
  final String decimalSeparator;
  final String thousandSeparator;
  MoneyMaskedTextController _textControllerInput;
  TextEditingController _textControllerCryptoValue;

  _CryptoCalculatorReversedState(
    this.usdValue,
    this.cryptoCode,
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
    _textControllerCryptoValue.dispose();
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
        InputConverted(
          title: "Comprás",
          textController: _textControllerCryptoValue,
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
        leftSymbol: "US\$ ");
    _textControllerCryptoValue =
        TextEditingController(text: "0.00 $cryptoCode");
  }

  void _setConversion() {
    if (usdValue > 0) {
      NumberFormat numberFormat = getNumberFormat(context);
      Decimal input =
          Decimal.parse(_textControllerInput.numberValue.toString());
      Decimal dUsdValue = Decimal.parse(usdValue.toString());
      Decimal d100 = Decimal.parse("100.00");
      Decimal value = ((input / dUsdValue) * d100).truncate() / d100;
      String formattedValue = numberFormat.format(DecimalAdapter(value));
      _textControllerCryptoValue.text = ("$formattedValue $cryptoCode");
    }
  }
}

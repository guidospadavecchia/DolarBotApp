import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class CryptoCalculatorReversed extends BaseCalculatorScreen {
  final double /*!*/ usdValue;
  final String cryptoCode;
  final NumberFormat numberFormat;

  CryptoCalculatorReversed({
    Key key,
    @required this.usdValue,
    @required this.cryptoCode,
    @required this.numberFormat,
  }) : super(
          key: key,
          symbol: cryptoCode,
          numberFormat: numberFormat,
        );

  @override
  _CryptoCalculatorReversedState createState() => _CryptoCalculatorReversedState(
        usdValue,
        cryptoCode,
        numberFormat,
      );
}

class _CryptoCalculatorReversedState extends BaseCalculatorState<CryptoCalculatorReversed>
    with BaseCalculator {
  final double /*!*/ usdValue;
  final String cryptoCode;
  final NumberFormat numberFormat;
  /*late*/ MoneyMaskedTextController _textControllerInput;
  /*late*/ TextEditingController _textControllerCryptoValue;

  _CryptoCalculatorReversedState(
    this.usdValue,
    this.cryptoCode,
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
    _textControllerCryptoValue.dispose();
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
          textController: _textControllerCryptoValue,
        ),
        const SizedBox(
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
        leftSymbol: "US\$ ");
    _textControllerCryptoValue =
        TextEditingController(text: "0${numberFormat.symbols.DECIMAL_SEP}00 $cryptoCode");
  }

  void _setConversion() {
    if (usdValue > 0) {
      Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
      Decimal dUsdValue = Decimal.parse(usdValue.toString());
      Decimal d100 = Decimal.parse("100.00");
      Decimal value = ((input / dUsdValue) * d100).truncate() / d100;
      String formattedValue = numberFormat.format(DecimalAdapter(value));
      _textControllerCryptoValue.text = ("$formattedValue $cryptoCode");
    }
  }
}

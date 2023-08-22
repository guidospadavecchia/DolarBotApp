import '../../classes/decimal_adapter.dart';
import 'base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class CryptoCalculatorReversed extends BaseCalculatorScreen {
  final double usdValue;
  final String cryptoCode;
  final NumberFormat numberFormat;

  CryptoCalculatorReversed({
    Key? key,
    required this.usdValue,
    required this.cryptoCode,
    required this.numberFormat,
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

class _CryptoCalculatorReversedState extends BaseCalculatorState<CryptoCalculatorReversed> with BaseCalculator {
  static const int _kPrecision = 2;
  static const int _kMinimumFractionDigits = 0;
  static const int _kMaximumFractionDigits = 8;

  final double usdValue;
  final String cryptoCode;
  final NumberFormat numberFormat;
  late MoneyMaskedTextController _textControllerInput;
  late TextEditingController _textControllerCryptoValue;

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
          onSubmitted: onSubmitted,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        InputConverted(
          title: "Comprás",
          textController: _textControllerCryptoValue,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
      ],
    );
  }

  void _createControllers() {
    _textControllerInput = MoneyMaskedTextController(
        precision: _kPrecision,
        decimalSeparator: numberFormat.symbols.DECIMAL_SEP,
        thousandSeparator: numberFormat.symbols.GROUP_SEP,
        leftSymbol: "US\$ ");
    _textControllerCryptoValue = TextEditingController();
    numberFormat.minimumFractionDigits = _kMinimumFractionDigits;
    numberFormat.maximumFractionDigits = _kMaximumFractionDigits;
  }

  void _setConversion() {
    if (usdValue > 0) {
      Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
      Decimal dUsdValue = Decimal.parse(usdValue.toString());
      Decimal value = input / dUsdValue;
      String formattedValue = numberFormat.format(DecimalAdapter(value));
      _textControllerCryptoValue.text = ("$formattedValue $cryptoCode");
    }
  }
}

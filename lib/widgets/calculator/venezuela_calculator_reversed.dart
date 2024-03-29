import '../../classes/decimal_adapter.dart';
import 'base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class VenezuelaCalculatorReversed extends BaseCalculatorScreen {
  final double bankValue;
  final double blackMarketValue;
  final String symbol;
  final String currencyCode;
  final NumberFormat numberFormat;

  VenezuelaCalculatorReversed({
    Key? key,
    required this.bankValue,
    required this.blackMarketValue,
    required this.symbol,
    required this.currencyCode,
    required this.numberFormat,
  }) : super(key: key, symbol: symbol, numberFormat: numberFormat);

  @override
  _VenezuelaCalculatorState createState() => _VenezuelaCalculatorState(
        bankValue,
        blackMarketValue,
        symbol,
        currencyCode,
        numberFormat,
      );
}

class _VenezuelaCalculatorState extends BaseCalculatorState<VenezuelaCalculatorReversed> with BaseCalculator {
  final double bankValue;
  final double blackMarketValue;
  final String symbol;
  final String currencyCode;
  final NumberFormat numberFormat;
  late MoneyMaskedTextController _textControllerInput;
  late TextEditingController _textControllerBankValue;
  late TextEditingController _textControllerBlackMarketValue;

  _VenezuelaCalculatorState(
    this.bankValue,
    this.blackMarketValue,
    this.symbol,
    this.currencyCode,
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
    _textControllerBankValue.dispose();
    _textControllerBlackMarketValue.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InputAmount(
          title: "Ingresá un monto en bolívares:",
          textController: _textControllerInput,
          onSubmitted: onSubmitted,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        InputConverted(
          title: "Comprás en bancos",
          textController: _textControllerBankValue,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        InputConverted(
          title: "Comprás en el paralelo",
          textController: _textControllerBlackMarketValue,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
      ],
    );
  }

  void _createControllers() {
    _textControllerInput = MoneyMaskedTextController(
        precision: 2, decimalSeparator: numberFormat.symbols.DECIMAL_SEP, thousandSeparator: numberFormat.symbols.GROUP_SEP, leftSymbol: "$symbol ");
    _textControllerBankValue = TextEditingController();
    _textControllerBlackMarketValue = TextEditingController();
  }

  void _setConversion() {
    String currencySymbol = currencyCode == 'USD' ? 'US\$' : '€';
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal d100 = Decimal.parse("100.00");
    if (bankValue > 0) {
      Decimal dBankValue = Decimal.parse(bankValue.toString());
      Decimal dValue = ((input / dBankValue) * d100).truncate() / d100;
      String formattedBuyValue = numberFormat.format(DecimalAdapter(dValue));
      _textControllerBankValue.text = "$currencySymbol $formattedBuyValue";
    }
    if (blackMarketValue > 0) {
      Decimal dBlackMarketValue = Decimal.parse(blackMarketValue.toString());
      Decimal dValue = ((input / dBlackMarketValue) * d100).truncate() / d100;
      String formattedSellValue = numberFormat.format(DecimalAdapter(dValue));
      _textControllerBlackMarketValue.text = "$currencySymbol $formattedSellValue";
    }
  }
}

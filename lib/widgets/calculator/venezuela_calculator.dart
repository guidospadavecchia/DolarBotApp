import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class VenezuelaCalculator extends BaseCalculatorScreen {
  final double bankValue;
  final double blackMarketValue;
  final String symbol;
  final String currencyCode;
  final NumberFormat numberFormat;

  VenezuelaCalculator({
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

class _VenezuelaCalculatorState extends BaseCalculatorState<VenezuelaCalculator>
    with BaseCalculator {
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
          title: "Ingresá un monto en ${currencyCode == 'USD' ? "dólares" : "euros"}:",
          textController: _textControllerInput,
          onSubmitted: onSubmitted,
          maxDigits: 10,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        InputConverted(
          title: "Vendés en bancos por",
          textController: _textControllerBankValue,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
        ),
        InputConverted(
          title: "Vendés en el paralelo por",
          textController: _textControllerBlackMarketValue,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
      ],
    );
  }

  void _createControllers() {
    String currencySymbol = currencyCode == 'USD' ? 'US\$' : '€';
    _textControllerInput = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: numberFormat.symbols.DECIMAL_SEP,
        thousandSeparator: numberFormat.symbols.GROUP_SEP,
        leftSymbol: "$currencySymbol ");
    _textControllerBankValue = TextEditingController();
    _textControllerBlackMarketValue = TextEditingController();
  }

  void _setConversion() {
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal dBankValue = Decimal.parse(bankValue.toString());
    String formattedBuyValue = numberFormat.format(DecimalAdapter(input * dBankValue));
    _textControllerBankValue.text = "$symbol $formattedBuyValue";
    Decimal dBlackMarketValue = Decimal.parse(blackMarketValue.toString());
    String formattedSellValue = numberFormat.format(DecimalAdapter(input * dBlackMarketValue));
    _textControllerBlackMarketValue.text = "$symbol $formattedSellValue";
  }
}

import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class VenezuelaCalculator extends BaseCalculatorScreen {
  final double bankValue;
  final double blackMarketValue;
  final String symbol;
  final String currencyCode;
  final String decimalSeparator;
  final String thousandSeparator;

  VenezuelaCalculator({
    Key key,
    @required this.bankValue,
    @required this.blackMarketValue,
    @required this.symbol,
    @required this.currencyCode,
    @required this.decimalSeparator,
    @required this.thousandSeparator,
  }) : super(
            key: key,
            symbol: symbol,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator);

  @override
  _VenezuelaCalculatorState createState() => _VenezuelaCalculatorState(
        bankValue,
        blackMarketValue,
        symbol,
        currencyCode,
        decimalSeparator,
        thousandSeparator,
      );
}

class _VenezuelaCalculatorState extends BaseCalculatorState<VenezuelaCalculator>
    with BaseCalculator {
  final double bankValue;
  final double blackMarketValue;
  final String symbol;
  final String currencyCode;
  final String decimalSeparator;
  final String thousandSeparator;
  MoneyMaskedTextController _textControllerInput;
  TextEditingController _textControllerBankValue;
  TextEditingController _textControllerBlackMarketValue;

  _VenezuelaCalculatorState(
    this.bankValue,
    this.blackMarketValue,
    this.symbol,
    this.currencyCode,
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
          textController: _textControllerInput,
          maxDigits: 10,
        ),
        SizedBox(
          height: 30,
        ),
        InputConverted(
          title: "Vendés en bancos por",
          textController: _textControllerBankValue,
        ),
        SizedBox(
          height: 20,
        ),
        InputConverted(
          title: "Vendés en el paralelo por",
          textController: _textControllerBlackMarketValue,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _createControllers() {
    String currencySymbol = currencyCode == 'USD' ? 'US\$' : '€';
    _textControllerInput = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
        leftSymbol: "$currencySymbol ");
    _textControllerBankValue = TextEditingController(text: "$symbol 0.00");
    _textControllerBlackMarketValue =
        TextEditingController(text: "$symbol 0.00");
  }

  void _setConversion() {
    NumberFormat numberFormat = getNumberFormat(context);
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal dBankValue = Decimal.parse(bankValue.toString());
    String formattedBuyValue =
        numberFormat.format(DecimalAdapter(input * dBankValue));
    _textControllerBankValue.text = "$symbol $formattedBuyValue";
    Decimal dBlackMarketValue = Decimal.parse(blackMarketValue.toString());
    String formattedSellValue =
        numberFormat.format(DecimalAdapter(input * dBlackMarketValue));
    _textControllerBlackMarketValue.text = "$symbol $formattedSellValue";
  }
}

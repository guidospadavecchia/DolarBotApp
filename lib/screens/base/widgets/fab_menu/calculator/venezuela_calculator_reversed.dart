import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_converted.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_amount.dart';
import 'package:intl/intl.dart';

class VenezuelaCalculatorReversed extends BaseCalculatorScreen {
  final double bankValue;
  final double blackMarketValue;
  final String symbol;
  final String currencyCode;
  final String decimalSeparator;
  final String thousandSeparator;

  VenezuelaCalculatorReversed({
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

class _VenezuelaCalculatorState
    extends BaseCalculatorState<VenezuelaCalculatorReversed>
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
        ),
        SizedBox(
          height: 30,
        ),
        InputConverted(
          title: "Comprás en bancos",
          textController: _textControllerBankValue,
        ),
        SizedBox(
          height: 20,
        ),
        InputConverted(
          title: "Comprás en el paralelo",
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
        leftSymbol: "$symbol ");
    _textControllerBankValue =
        TextEditingController(text: "$currencySymbol 0.00");
    _textControllerBlackMarketValue =
        TextEditingController(text: "$currencySymbol 0.00");
  }

  void _setConversion() {
    String currencySymbol = currencyCode == 'USD' ? 'US\$' : '€';
    NumberFormat numberFormat = getNumberFormat(context);
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
      _textControllerBlackMarketValue.text =
          "$currencySymbol $formattedSellValue";
    }
  }
}

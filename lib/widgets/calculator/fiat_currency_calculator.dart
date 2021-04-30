import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class FiatCurrencyCalculator extends BaseCalculatorScreen {
  final double buyValue;
  final double sellValue;
  final double sellValueWithTaxes;
  final String /*!*/ symbol;
  final NumberFormat numberFormat;

  FiatCurrencyCalculator({
    Key key,
    this.buyValue,
    this.sellValue,
    this.sellValueWithTaxes,
    @required this.symbol,
    @required this.numberFormat,
  })  : assert(buyValue != null || sellValue != null || sellValueWithTaxes != null),
        super(
          key: key,
          symbol: symbol,
          numberFormat: numberFormat,
        );

  @override
  _FiatCurrencyCalculatorState createState() => _FiatCurrencyCalculatorState(
        buyValue,
        sellValue,
        sellValueWithTaxes,
        symbol,
        numberFormat,
      );
}

class _FiatCurrencyCalculatorState extends BaseCalculatorState<FiatCurrencyCalculator>
    with BaseCalculator {
  final double buyValue;
  final double sellValue;
  final double sellValueWithTaxes;
  final String symbol;
  final NumberFormat numberFormat;
  /*late*/ MoneyMaskedTextController _textControllerInput;
  /*late*/ TextEditingController _textControllerBuyValue;
  /*late*/ TextEditingController _textControllerSellValue;
  /*late*/ TextEditingController _textControllerSellValueWithTaxes;

  _FiatCurrencyCalculatorState(
    this.buyValue,
    this.sellValue,
    this.sellValueWithTaxes,
    this.symbol,
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
    if (buyValue != null) _textControllerBuyValue.dispose();
    if (sellValue != null) _textControllerSellValue.dispose();
    if (sellValueWithTaxes != null) _textControllerSellValueWithTaxes.dispose();
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
        const SizedBox(
          height: 30,
        ),
        if (sellValue != null)
          Column(
            children: [
              InputConverted(
                title: "Comprás a",
                textController: _textControllerSellValue,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        if (sellValueWithTaxes != null)
          Column(
            children: [
              InputConverted(
                title: "Comprás con impuestos a",
                textController: _textControllerSellValueWithTaxes,
              ),
              SizedBox(
                height: buyValue != null ? 20 : 30,
              ),
            ],
          ),
        if (buyValue != null)
          Column(
            children: [
              const Divider(
                color: Colors.black,
                indent: 50,
                endIndent: 50,
                height: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              InputConverted(
                title: "Vendés a",
                textController: _textControllerBuyValue,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
      ],
    );
  }

  void _createControllers() {
    _textControllerInput = MoneyMaskedTextController(
        precision: 2,
        decimalSeparator: numberFormat.symbols.DECIMAL_SEP,
        thousandSeparator: numberFormat.symbols.GROUP_SEP,
        leftSymbol: "$symbol ");

    _textControllerBuyValue =
        TextEditingController(text: "\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
    _textControllerSellValue =
        TextEditingController(text: "\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
    _textControllerSellValueWithTaxes =
        TextEditingController(text: "\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
  }

  void _setConversion() {
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    if (buyValue != null) {
      Decimal dBuyValue = Decimal.parse(buyValue.toString());
      String formattedBuyValue = numberFormat.format(DecimalAdapter(input * dBuyValue));
      _textControllerBuyValue.text = "\$ $formattedBuyValue";
    }
    if (sellValue != null) {
      Decimal dSellValue = Decimal.parse(sellValue.toString());
      String formattedSellValue = numberFormat.format(DecimalAdapter(input * dSellValue));
      _textControllerSellValue.text = "\$ $formattedSellValue";
    }
    if (sellValueWithTaxes != null) {
      Decimal dSellValueWithTaxes = Decimal.parse(sellValueWithTaxes.toString());
      String formattedSellValueWithTaxes = numberFormat.format(
        DecimalAdapter(input * dSellValueWithTaxes),
      );
      _textControllerSellValueWithTaxes.text = "\$ $formattedSellValueWithTaxes";
    }
  }
}

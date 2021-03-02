import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_converted.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/inputs/input_amount.dart';
import 'package:intl/intl.dart';

class CryptoCalculator extends BaseCalculatorScreen {
  final double arsValue;
  final double arsValueWithTaxes;
  final double usdValue;
  final String cryptoCode;
  final String decimalSeparator;
  final String thousandSeparator;

  CryptoCalculator({
    Key key,
    @required this.arsValue,
    @required this.arsValueWithTaxes,
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
  _CryptoCalculatorState createState() => _CryptoCalculatorState(
        arsValue,
        arsValueWithTaxes,
        usdValue,
        cryptoCode,
        decimalSeparator,
        thousandSeparator,
      );
}

class _CryptoCalculatorState extends BaseCalculatorState<CryptoCalculator>
    with BaseCalculator {
  final double arsValue;
  final double arsValueWithTaxes;
  final double usdValue;
  final String cryptoCode;
  final String decimalSeparator;
  final String thousandSeparator;
  MoneyMaskedTextController _textControllerInput;
  TextEditingController _textControllerArsValue;
  TextEditingController _textControllerArsValueWithTaxes;
  TextEditingController _textControllerUsdValue;

  _CryptoCalculatorState(
    this.arsValue,
    this.arsValueWithTaxes,
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
    _textControllerArsValue.dispose();
    _textControllerArsValueWithTaxes.dispose();
    _textControllerUsdValue.dispose();
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
        ),
        SizedBox(
          height: 30,
        ),
        InputConverted(
          title: "Pesos",
          textController: _textControllerArsValue,
        ),
        SizedBox(
          height: 15,
        ),
        InputConverted(
          title: "Pesos con impuestos",
          textController: _textControllerArsValueWithTaxes,
        ),
        Divider(
          color: Colors.black,
          indent: 50,
          endIndent: 50,
          height: 30,
        ),
        InputConverted(
          title: "Dólares",
          textController: _textControllerUsdValue,
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
        rightSymbol: " $cryptoCode");
    _textControllerArsValue = TextEditingController(text: "\$ 0.00");
    _textControllerArsValueWithTaxes = TextEditingController(text: "\$ 0.00");
    _textControllerUsdValue = TextEditingController(text: "US\$ 0.00");
  }

  void _setConversion() {
    NumberFormat numberFormat = getNumberFormat(context);
    Decimal input = Decimal.parse(_textControllerInput.numberValue.toString());
    Decimal dArsValue = Decimal.parse(arsValue.toString());
    Decimal dArsValueWithTaxes = Decimal.parse(arsValueWithTaxes.toString());
    Decimal dUsdValue = Decimal.parse(usdValue.toString());
    String formattedArsValue = numberFormat.format(
      DecimalAdapter(input * dArsValue),
    );
    String formattedArsValueWithTaxes = numberFormat.format(
      DecimalAdapter(input * dArsValueWithTaxes),
    );
    String formattedUsdValue = numberFormat.format(
      DecimalAdapter(input * dUsdValue),
    );
    _textControllerArsValue.text = "\$ $formattedArsValue";
    _textControllerArsValueWithTaxes.text = "\$ $formattedArsValueWithTaxes";
    _textControllerUsdValue.text = "US\$ $formattedUsdValue";
  }
}

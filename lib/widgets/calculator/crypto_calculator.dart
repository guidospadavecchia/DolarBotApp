import 'package:dolarbot_app/classes/decimal_adapter.dart';
import 'package:dolarbot_app/widgets/calculator/base/base_calculator.dart';
import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:intl/intl.dart';

class CryptoCalculator extends BaseCalculatorScreen {
  final double /*!*/ arsValue;
  final double /*!*/ arsValueWithTaxes;
  final double /*!*/ usdValue;
  final String /*!*/ cryptoCode;
  final NumberFormat numberFormat;

  CryptoCalculator({
    Key key,
    @required this.arsValue,
    @required this.arsValueWithTaxes,
    @required this.usdValue,
    @required this.cryptoCode,
    @required this.numberFormat,
  }) : super(
          key: key,
          symbol: cryptoCode,
          numberFormat: numberFormat,
        );

  @override
  _CryptoCalculatorState createState() => _CryptoCalculatorState(
        arsValue,
        arsValueWithTaxes,
        usdValue,
        cryptoCode,
        numberFormat,
      );
}

class _CryptoCalculatorState extends BaseCalculatorState<CryptoCalculator> with BaseCalculator {
  final double /*!*/ arsValue;
  final double /*!*/ arsValueWithTaxes;
  final double /*!*/ usdValue;
  final String /*!*/ cryptoCode;
  final NumberFormat numberFormat;
  /*late final*/ MoneyMaskedTextController _textControllerInput;
  /*late final*/ TextEditingController _textControllerArsValue;
  /*late final*/ TextEditingController _textControllerArsValueWithTaxes;
  /*late final*/ TextEditingController _textControllerUsdValue;

  _CryptoCalculatorState(
    this.arsValue,
    this.arsValueWithTaxes,
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
          title: cryptoCode != '' ? "Ingresá la cantidad en $cryptoCode:" : "Ingresá la cantidad:",
          textController: _textControllerInput,
          maxDigits: 12,
        ),
        const SizedBox(
          height: 30,
        ),
        InputConverted(
          title: "Pesos",
          textController: _textControllerArsValue,
        ),
        const SizedBox(
          height: 15,
        ),
        InputConverted(
          title: "Pesos + Impuestos",
          textController: _textControllerArsValueWithTaxes,
        ),
        const Divider(
          color: Colors.black,
          indent: 50,
          endIndent: 50,
          height: 30,
        ),
        InputConverted(
          title: "Dólares",
          textController: _textControllerUsdValue,
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
        rightSymbol: cryptoCode != '' ? " $cryptoCode" : cryptoCode);
    _textControllerArsValue =
        TextEditingController(text: "\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
    _textControllerArsValueWithTaxes =
        TextEditingController(text: "\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
    _textControllerUsdValue =
        TextEditingController(text: "US\$ 0${numberFormat.symbols.DECIMAL_SEP}00");
  }

  void _setConversion() {
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

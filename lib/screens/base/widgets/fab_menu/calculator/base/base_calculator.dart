import 'package:flutter/material.dart';

abstract class BaseCalculatorScreen extends StatefulWidget {
  final double containerHeight;
  final String symbol;
  final String decimalSeparator;
  final String thousandSeparator;

  BaseCalculatorScreen({
    Key key,
    this.containerHeight,
    this.symbol,
    this.decimalSeparator,
    this.thousandSeparator,
  }) : super(key: key);
}

abstract class BaseCalculatorState<Page extends BaseCalculatorScreen>
    extends State<BaseCalculatorScreen> {}

mixin BaseCalculator<Page extends BaseCalculatorScreen>
    on BaseCalculatorState<Page> {
  Widget body();

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

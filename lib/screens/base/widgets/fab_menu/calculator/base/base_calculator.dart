import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
  final int kMaxDigits = 12;
  final int kMinDigits = 7;
  final int inputFactor = 7;

  Widget body();

  int getMaxDigits(List<double> values) {
    double maxValue = values.where((n) => n != null).reduce(max);
    int digits = maxValue.toString().length - 1;
    if (digits >= inputFactor) {
      return kMinDigits;
    } else {
      return kMaxDigits - kMinDigits + digits;
    }
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

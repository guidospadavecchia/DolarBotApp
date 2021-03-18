import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

export 'package:dolarbot_app/widgets/calculator/inputs/input_amount.dart';
export 'package:dolarbot_app/widgets/calculator/inputs/input_converted.dart';

abstract class BaseCalculatorScreen extends StatefulWidget {
  final double containerHeight;
  final String symbol;
  final NumberFormat numberFormat;

  BaseCalculatorScreen({
    Key key,
    this.containerHeight,
    this.symbol,
    this.numberFormat,
  }) : super(key: key);
}

abstract class BaseCalculatorState<Page extends BaseCalculatorScreen>
    extends State<BaseCalculatorScreen> {}

mixin BaseCalculator<Page extends BaseCalculatorScreen> on BaseCalculatorState<Page> {
  final int kMaxDigits = 12;
  final int kMinDigits = 7;
  final int inputFactor = 7;

  Widget body();

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

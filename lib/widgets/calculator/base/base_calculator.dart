import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

export 'package:dolarbot_app/widgets/calculator/inputs/input_amount.dart';
export 'package:dolarbot_app/widgets/calculator/inputs/input_converted.dart';

abstract class BaseCalculatorScreen extends StatefulWidget {
  final String/*!*/ symbol;
  final NumberFormat/*!*/ numberFormat;

  BaseCalculatorScreen({
    Key key,
    this.symbol,
    this.numberFormat,
  }) : super(key: key);
}

abstract class BaseCalculatorState<Page extends BaseCalculatorScreen>
    extends State<BaseCalculatorScreen> {}

mixin BaseCalculator<Page extends BaseCalculatorScreen> on BaseCalculatorState<Page> {
  static const int kMaxDigits = 12;
  static const int kMinDigits = 7;
  static const int inputFactor = 7;

  Widget body();

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

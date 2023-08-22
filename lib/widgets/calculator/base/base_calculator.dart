import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

export 'package:dolarbot_app/classes/size_config.dart';
export 'package:dolarbot_app/widgets/calculator/inputs/input_amount.dart';
export 'package:dolarbot_app/widgets/calculator/inputs/input_converted.dart';

abstract class BaseCalculatorScreen extends StatefulWidget {
  final String symbol;
  final NumberFormat numberFormat;

  BaseCalculatorScreen({
    Key? key,
    required this.symbol,
    required this.numberFormat,
  }) : super(key: key);
}

abstract class BaseCalculatorState<Page extends BaseCalculatorScreen> extends State<BaseCalculatorScreen> {}

mixin BaseCalculator<Page extends BaseCalculatorScreen> on BaseCalculatorState<Page> {
  static const int kMaxDigits = 12;
  static const int kMinDigits = 7;
  static const int inputFactor = 7;

  Widget body();
  void onSubmitted(String _) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return body();
  }

  int getPrecision(double value) {
    if (value > 100000) {
      return 8;
    } else if (value > 10000) {
      return 6;
    } else if (value > 1000) {
      return 4;
    } else {
      return 2;
    }
  }
}

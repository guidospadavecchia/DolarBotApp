import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoricalChartData {
  late List<HistoricalRateData> ratesData;

  HistoricalChartData({
    required List<HistoricalRateData> ratesData,
  }) {
    this.ratesData = ratesData;
  }
}

class HistoricalRateData {
  static const double _kIntervalPartitionsRatio = 10;

  late final String title;
  String? leftSymbol;
  String? rightSymbol;
  late final TextStyle tooltipTextStyle;
  late final double maxValue;
  late final double minValue;
  late final double interval;
  late final bool isInteger;
  late final LineChartBarData lineChartBarData;

  HistoricalRateData({
    required String title,
    String? leftSymbol,
    String? rightSymbol,
    required TextStyle tooltipTextStyle,
    double? maxValue,
    double minValue = 0,
    bool isInteger = false,
    bool extendedInterval = true,
    required LineChartBarData lineChartBarData,
  }) : assert(leftSymbol != null || rightSymbol != null) {
    this.title = title;
    this.leftSymbol = leftSymbol ?? '';
    this.rightSymbol = rightSymbol ?? '';
    this.tooltipTextStyle = tooltipTextStyle;
    this.maxValue = extendedInterval ? maxValue! * 2 : maxValue!;
    this.minValue = extendedInterval ? minValue / 2 : minValue;
    this.interval = _calculateInterval(
      maxValue: this.maxValue,
      minValue: this.minValue,
    );
    this.isInteger = isInteger;
    this.lineChartBarData = lineChartBarData;
  }

  double _calculateInterval({required double maxValue, required double minValue}) {
    var difference = maxValue - minValue;
    if (difference < _kIntervalPartitionsRatio) {
      int partitionSize = difference ~/ 2;
      return partitionSize < 1 ? 1 : partitionSize.toDouble();
    } else {
      return (difference ~/ _kIntervalPartitionsRatio).toDouble();
    }
  }
}

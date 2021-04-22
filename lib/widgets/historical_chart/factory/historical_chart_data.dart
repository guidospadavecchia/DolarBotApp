import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoricalChartData {
  List<HistoricalRateData> ratesData;

  HistoricalChartData({
    List<HistoricalRateData> ratesData,
  }) : assert(ratesData != null) {
    this.ratesData = ratesData;
  }
}

class HistoricalRateData {
  static const double _kIntervalPartitionsRatio = 10;

  String title;
  String leftSymbol;
  String rightSymbol;
  TextStyle tooltipTextStyle;
  double maxValue;
  double minValue;
  double interval;
  bool isInteger;
  LineChartBarData lineChartBarData;

  HistoricalRateData({
    String title,
    String leftSymbol,
    String rightSymbol,
    TextStyle tooltipTextStyle,
    double maxValue,
    double minValue = 0,
    bool isInteger = false,
    bool extendedInterval = true,
    LineChartBarData lineChartBarData,
  }) : assert(title != null &&
            (leftSymbol != null || rightSymbol != null) &&
            tooltipTextStyle != null &&
            maxValue != null &&
            lineChartBarData != null) {
    this.title = title;
    this.leftSymbol = leftSymbol ?? '';
    this.rightSymbol = rightSymbol ?? '';
    this.tooltipTextStyle = tooltipTextStyle;
    this.maxValue = extendedInterval ? maxValue * 2 : maxValue;
    this.minValue = extendedInterval ? minValue / 2 : minValue;
    this.interval = _calculateInterval(
        maxValue: this.maxValue,
        minValue: this.minValue,
        partitionRatio: _kIntervalPartitionsRatio);
    this.isInteger = isInteger;
    this.lineChartBarData = lineChartBarData;
  }

  double _calculateInterval({double maxValue, double minValue, double partitionRatio}) {
    var difference = maxValue - minValue;
    if (difference < partitionRatio) {
      int partitionSize = difference ~/ 2;
      return partitionSize < 1 ? 1 : partitionSize.toDouble();
    } else {
      return (difference ~/ partitionRatio).toDouble();
    }
  }
}

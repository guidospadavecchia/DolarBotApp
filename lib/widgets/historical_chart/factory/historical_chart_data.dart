import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoricalChartData {
  static const int _kIntervalPartitions = 10;

  String leftSymbol;
  String rightSymbol;
  TextStyle tooltipTextStyle;
  double maxValue;
  double minValue;
  double interval;
  bool isInteger;
  List<LineChartBarData> lineChartsData;

  HistoricalChartData({
    String leftSymbol,
    String rightSymbol,
    TextStyle tooltipTextStyle,
    double maxValue,
    double minValue = 0,
    bool isInteger = false,
    List<LineChartBarData> lineChartsData,
  }) : assert((leftSymbol != null || rightSymbol != null) &&
            tooltipTextStyle != null &&
            maxValue != null &&
            lineChartsData != null) {
    this.leftSymbol = leftSymbol ?? '';
    this.rightSymbol = rightSymbol ?? '';
    this.tooltipTextStyle = tooltipTextStyle;
    this.maxValue = maxValue * 2;
    this.minValue = minValue;
    this.interval = _calculateInterval(maxValue: this.maxValue, minValue: this.minValue);
    this.isInteger = isInteger;
    this.lineChartsData = lineChartsData;
  }

  double _calculateInterval({double maxValue, double minValue}) {
    var difference = maxValue - minValue;
    if (difference < _kIntervalPartitions) {
      int partitionSize = difference ~/ 2;
      return partitionSize < 1 ? 1 : partitionSize.toDouble();
    } else {
      return (difference ~/ _kIntervalPartitions).toDouble();
    }
  }
}

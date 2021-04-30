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

  String /*!*/ title;
  String leftSymbol;
  String rightSymbol;
  TextStyle /*!*/ tooltipTextStyle;
  double /*!*/ maxValue;
  /*late*/ double minValue;
  double /*!*/ interval;
  bool isInteger;
  LineChartBarData /*!*/ lineChartBarData;

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
  }) : assert(leftSymbol != null || rightSymbol != null) {
    this.title = title;
    this.leftSymbol = leftSymbol ?? '';
    this.rightSymbol = rightSymbol ?? '';
    this.tooltipTextStyle = tooltipTextStyle;
    this.maxValue = extendedInterval ? maxValue * 2 : maxValue;
    this.minValue = extendedInterval ? minValue / 2 : minValue;
    this.interval = _calculateInterval(
      maxValue: this.maxValue,
      minValue: this.minValue,
    );
    this.isInteger = isInteger;
    this.lineChartBarData = lineChartBarData;
  }

  double _calculateInterval({double maxValue, double minValue}) {
    var difference = maxValue - minValue;
    if (difference < _kIntervalPartitionsRatio) {
      int partitionSize = difference ~/ 2;
      return partitionSize < 1 ? 1 : partitionSize.toDouble();
    } else {
      return (difference ~/ _kIntervalPartitionsRatio).toDouble();
    }
  }
}

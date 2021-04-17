import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/historical_chart/factory/historical_chart_data.dart';
import 'package:dolarbot_app/widgets/historical_chart/factory/historical_chart_data_builder.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoricalChart extends StatefulWidget {
  final Type responseType;
  final List<HistoricalRate> values;

  const HistoricalChart({
    Key key,
    @required this.values,
    @required this.responseType,
  }) : super(key: key);

  @override
  _HistoricalChartState createState() => _HistoricalChartState();
}

class _HistoricalChartState extends State<HistoricalChart> {
  HistoricalChartData historicalChartData;
  bool _chartDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  @override
  Widget build(BuildContext context) {
    if (!_chartDataLoaded) {
      return SizedBox.shrink();
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(20),
      child: LineChart(
        LineChartData(
          gridData: _getGridData(context),
          lineTouchData: _getLineTouchData(context),
          minY: historicalChartData.minValue,
          maxY: historicalChartData.maxValue,
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: ThemeManager.getPrimaryTextColor(context),
              width: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: _getBottomTitles(context),
            leftTitles: _getLeftTitles(context),
          ),
          lineBarsData: historicalChartData.lineChartsData,
        ),
        swapAnimationDuration: Duration(milliseconds: 150),
      ),
    );
  }

  LineTouchData _getLineTouchData(BuildContext context) {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        fitInsideVertically: true,
        fitInsideHorizontally: true,
        tooltipBgColor: Colors.white,
        getTooltipItems: (touchedSpots) {
          if (touchedSpots == null) {
            return null;
          }

          NumberFormat numberFormat =
              Provider.of<Settings>(context, listen: false).getNumberFormat();
          List<LineTooltipItem> tooltipItems = [];
          for (int i = 0; i < touchedSpots.length; i++) {
            LineBarSpot touchedSpot = touchedSpots[i];
            if (touchedSpot != null) {
              DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
              if (historicalChartData.isInteger) {
                numberFormat.maximumFractionDigits = 0;
              }
              String value = numberFormat.format(touchedSpot.y);
              DateTime date = DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt());
              String formattedDate = dateFormat.format(date);
              String leftSymbol = "${historicalChartData?.leftSymbol ?? ''} ";
              String rightSymbol = " ${historicalChartData.rightSymbol ?? ''}";
              String tooltip = i + 1 < touchedSpots.length
                  ? "$leftSymbol$value$rightSymbol"
                  : "$leftSymbol$value$rightSymbol\n\n$formattedDate";
              tooltipItems.add(LineTooltipItem(tooltip, historicalChartData.tooltipTextStyle));
            }
          }
          return tooltipItems;
        },
      ),
    );
  }

  void _loadChartData() {
    historicalChartData =
        BuildHistoricalChartData(widget.responseType).fromHistoricalRates(widget.values);
    _chartDataLoaded = true;
  }

  FlGridData _getGridData(BuildContext context) {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.grey.withOpacity(0.5),
        strokeWidth: 1,
      ),
      horizontalInterval: historicalChartData.interval / 2,
      drawVerticalLine: false,
    );
  }

  SideTitles _getLeftTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      getTextStyles: (value) => TextStyle(
        color: ThemeManager.getPrimaryTextColor(context),
        fontSize: 11,
      ),
      interval: historicalChartData.interval,
      margin: 15,
      //TODO: Ajustar reservedSize dinamicamente
      reservedSize: 50,
      getTitles: (value) {
        NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
        if (historicalChartData.isInteger) {
          numberFormat.maximumFractionDigits = 0;
        }
        String leftSymbol = "${historicalChartData?.leftSymbol ?? ''} ";
        String rightSymbol = " ${historicalChartData.rightSymbol ?? ''}";

        return "$leftSymbol${numberFormat.format(value)}$rightSymbol";
      },
    );
  }

  SideTitles _getBottomTitles(BuildContext context) {
    return SideTitles(
      showTitles: true,
      getTitles: (value) {
        DateFormat dateFormat = DateFormat('dd/MM/yyyy');
        DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return dateFormat.format(date);
      },
      interval: widget.values.length > 0 ? widget.values.length.toDouble() * 10 : 1,
      margin: 20,
      reservedSize: 20,
      getTextStyles: (value) => TextStyle(
        color: ThemeManager.getPrimaryTextColor(context),
        fontSize: 9,
      ),
    );
  }
}

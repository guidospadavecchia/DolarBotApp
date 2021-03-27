import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoricalChart extends StatelessWidget {
  final List<HistoricalRate> values;

  const HistoricalChart({
    Key key,
    @required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.all(20),
      child: LineChart(
        LineChartData(
          gridData: _getGridData(context),
          lineTouchData: _getLineTouchData(context),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: _getBottomTitles(context),
            leftTitles: _getLeftTitles(context),
          ),
          lineBarsData: [
            //TODO traer valores con Factory a partir del responseType. Que cada tipo de valor del response sea un LineChartBarData distinto.
            LineChartBarData(
              spots: [
                FlSpot(2, 8),
                FlSpot(3, 2),
                FlSpot(5, 4),
                FlSpot(6, 8),
                FlSpot(7, 16),
              ],
              isCurved: false,
              colors: [
                Colors.blue,
                Colors.lightBlue,
                Colors.green,
                Colors.greenAccent,
              ],
              belowBarData: BarAreaData(
                show: true,
                colors: [
                  Colors.blue.withAlpha(70),
                  Colors.lightBlue.withAlpha(70),
                  Colors.green.withAlpha(70),
                  Colors.greenAccent.withAlpha(70),
                ],
              ),
              barWidth: 1,
            ),
          ],
        ),
        swapAnimationDuration: Duration(milliseconds: 150),
      ),
    );
  }

  LineTouchData _getLineTouchData(BuildContext context) {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.white,
        getTooltipItems: (touchedSpots) {
          if (touchedSpots == null) {
            return null;
          }

          NumberFormat numberFormat =
              Provider.of<Settings>(context, listen: false).getNumberFormat();
          return touchedSpots.map(
            (touchedSpot) {
              if (touchedSpot == null) {
                return null;
              }
              final TextStyle textStyle = TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              //TODO: Configurar simbolo en base a la factory
              return LineTooltipItem("\$ ${numberFormat.format(touchedSpot.x)}", textStyle);
            },
          ).toList();
        },
      ),
    );
  }

  FlGridData _getGridData(BuildContext context) => FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey,
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey,
          strokeWidth: 1,
        ),
      );

  SideTitles _getLeftTitles(BuildContext context) => SideTitles(
      showTitles: true,
      getTextStyles: (value) => TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
      margin: 20,
      getTitles: (value) {
        //TODO: Configurar simbolo en base a la factory
        NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
        return "\$ ${numberFormat.format(value)}";
      });

  SideTitles _getBottomTitles(BuildContext context) => SideTitles(
        showTitles: true,
        getTitles: (value) {
          DateFormat dateFormat = DateFormat('dd/MM/yyyy');
          DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
          return dateFormat.format(date);
        },
        margin: 8,
        reservedSize: 10,
        getTextStyles: (value) => TextStyle(
          color: Colors.white,
          fontSize: 9,
        ),
      );
}

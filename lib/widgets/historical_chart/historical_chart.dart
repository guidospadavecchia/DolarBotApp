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
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(20),
      child: LineChart(
        LineChartData(
          gridData: _getGridData(context),
          lineTouchData: _getLineTouchData(context),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.grey,
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
                FlSpot(2, 70),
                FlSpot(3, 72),
                FlSpot(5, 74),
                FlSpot(6, 75),
                FlSpot(7, 76),
                FlSpot(9, 79),
                FlSpot(11, 81),
                FlSpot(25, 85),
                FlSpot(32, 90),
                FlSpot(45, 93),
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
              return LineTooltipItem("\$ ${numberFormat.format(touchedSpot.y)}", textStyle);
            },
          ).toList();
        },
      ),
    );
  }

  FlGridData _getGridData(BuildContext context) => FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 1,
        ),
        horizontalInterval: values.length > 0 ? values.length / 2 : null,
        drawVerticalLine: false,
        // getDrawingVerticalLine: (value) => FlLine(
        //   color: Colors.grey,
        //   strokeWidth: 1,
        // ),
      );

  SideTitles _getLeftTitles(BuildContext context) => SideTitles(
      showTitles: true,
      getTextStyles: (value) => TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
      margin: 20,
      interval: values.length > 0 ? values.length.toDouble() : null,
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
        interval: values.length > 0 ? values.length.toDouble() : null,
        margin: 8,
        reservedSize: 10,
        getTextStyles: (value) => TextStyle(
          color: Colors.white,
          fontSize: 9,
        ),
      );
}

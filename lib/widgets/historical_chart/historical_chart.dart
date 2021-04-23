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

class _HistoricalChartState extends State<HistoricalChart> with SingleTickerProviderStateMixin {
  static const double kMaxScale = 2.5;
  static const double kMinScale = 0.5;

  HistoricalChartData historicalChartData;
  TransformationController _transformationController;
  TabController _tabController;
  bool _chartDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_chartDataLoaded || historicalChartData.ratesData.length == 0) {
      return const SizedBox.shrink();
    }

    //TODO: Agregar controles de zoom (+/- y reset)
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(border: Border.all(color: Colors.black54, width: 1)),
      child: Column(
        children: [
          Container(
            child: TabBar(
              controller: _tabController,
              tabs: historicalChartData.ratesData.map((x) => Tab(text: x.title)).toList(),
              indicatorColor: ThemeManager.getPrimaryAccentColor(context),
              labelColor: ThemeManager.getPrimaryTextColor(context),
              enableFeedback: historicalChartData.ratesData.length > 1,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway",
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: "Raleway",
              ),
              unselectedLabelColor: ThemeManager.getPrimaryTextColor(context).withOpacity(0.5),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: historicalChartData.ratesData.map((x) => _buildChart(context, x)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(BuildContext context, HistoricalRateData rateData) {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.all(10),
      child: InteractiveViewer(
        maxScale: kMaxScale,
        minScale: kMinScale,
        transformationController: _transformationController,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        boundaryMargin: const EdgeInsets.all(50),
        constrained: false,
        child: Container(
          width: MediaQuery.of(context).size.width * 3,
          height: MediaQuery.of(context).size.height,
          child: LineChart(
            LineChartData(
              gridData: _getGridData(context, rateData),
              lineTouchData: _getLineTouchData(context, rateData),
              minY: rateData.minValue,
              maxY: rateData.maxValue,
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: ThemeManager.getPrimaryTextColor(context),
                  width: 1,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(showTitles: false),
                leftTitles: _getLeftTitles(context, rateData),
              ),
              lineBarsData: [
                rateData.lineChartBarData,
              ],
            ),
            swapAnimationDuration: const Duration(milliseconds: 150),
          ),
        ),
      ),
    );
  }

  void _loadChartData() {
    historicalChartData =
        BuildHistoricalChartData(widget.responseType).fromHistoricalRates(widget.values);
    _tabController = TabController(length: historicalChartData.ratesData.length, vsync: this);
    _transformationController = TransformationController(Matrix4.identity() * 0.6);
    _chartDataLoaded = true;
  }

  LineTouchData _getLineTouchData(BuildContext context, HistoricalRateData rateData) {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        fitInsideVertically: true,
        fitInsideHorizontally: true,
        tooltipBgColor: Colors.grey[400],
        maxContentWidth: MediaQuery.of(context).size.width / 2,
        tooltipRoundedRadius: 15,
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
              if (rateData.isInteger) {
                numberFormat.maximumFractionDigits = 0;
              }
              String value = numberFormat.format(touchedSpot.y);
              DateTime date = DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt());
              String formattedDate = dateFormat.format(date);
              String leftSymbol = "${rateData?.leftSymbol ?? ''} ";
              String rightSymbol = " ${rateData.rightSymbol ?? ''}";
              String tooltip = i + 1 < touchedSpots.length
                  ? "$leftSymbol$value$rightSymbol"
                  : "$leftSymbol$value$rightSymbol\n\n$formattedDate";
              tooltipItems.add(LineTooltipItem(tooltip, rateData.tooltipTextStyle));
            }
          }
          return tooltipItems;
        },
      ),
    );
  }

  FlGridData _getGridData(BuildContext context, HistoricalRateData rateData) {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.grey.withOpacity(0.5),
        strokeWidth: 1,
      ),
      horizontalInterval: rateData.interval / 2,
      drawVerticalLine: false,
    );
  }

  SideTitles _getLeftTitles(BuildContext context, HistoricalRateData rateData) {
    return SideTitles(
      showTitles: true,
      getTextStyles: (value) => TextStyle(
        color: ThemeManager.getPrimaryTextColor(context),
        fontSize: 20,
      ),
      interval: rateData.interval,
      margin: 10,
      reservedSize: 200,
      getTitles: (value) {
        NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
        if (rateData.isInteger) {
          numberFormat.maximumFractionDigits = 0;
        }
        String leftSymbol = "${rateData?.leftSymbol ?? ''} ";
        String rightSymbol = " ${rateData.rightSymbol ?? ''}";

        return "$leftSymbol${numberFormat.format(value)}$rightSymbol";
      },
    );
  }
}

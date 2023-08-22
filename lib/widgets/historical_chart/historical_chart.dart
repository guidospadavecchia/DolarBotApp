import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../classes/hive/historical_rate.dart';
import '../../classes/size_config.dart';
import '../../screens/base/base_info_screen.dart';
import '../common/simple_button.dart';
import 'factory/historical_chart_data.dart';
import 'factory/historical_chart_data_builder.dart';
import 'historical_chart_help_dialog.dart';

class HistoricalChart extends StatefulWidget {
  final Type responseType;
  final List<HistoricalRate> values;

  const HistoricalChart({
    Key? key,
    required this.values,
    required this.responseType,
  }) : super(key: key);

  @override
  _HistoricalChartState createState() => _HistoricalChartState();
}

class _HistoricalChartState extends State<HistoricalChart> with TickerProviderStateMixin {
  static const double kMaxScale = 2.5;
  static const double kMinScale = 0.5;

  final Matrix4 defaultZoom = Matrix4.identity() * kMinScale;
  late HistoricalChartData historicalChartData;
  late TransformationController _transformationController;
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<Matrix4> _animation;
  bool _chartDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadChartData();
    _initializeControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_chartDataLoaded || historicalChartData.ratesData.length == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      height: SizeConfig.screenHeight * 0.7,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: historicalChartData.ratesData.map((x) => Tab(text: x.title)).toList(),
              indicatorColor: Colors.white.withOpacity(0.9),
              labelColor: Colors.white.withOpacity(0.9),
              enableFeedback: historicalChartData.ratesData.length > 1,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Raleway",
                fontSize: 15,
              ),
              labelPadding: EdgeInsets.zero,
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: "Raleway",
              ),
              unselectedLabelColor: Colors.white.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: historicalChartData.ratesData.map((x) => _buildChart(context, x)).toList(),
            ),
          ),
          Divider(
            height: 25,
            color: Colors.white.withOpacity(0.6),
            indent: 20,
            endIndent: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Podes aplicar zoom con los dedos directamente sobre el gráfico!",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontFamily: 'Raleway',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SimpleButton(
                  icon: FontAwesomeIcons.questionCircle,
                  iconColor: Colors.white.withOpacity(0.7),
                  iconSize: 22,
                  backgroundColor: Colors.black26.withOpacity(0.2),
                  padding: const EdgeInsets.only(top: 8, right: 20, left: 20, bottom: 8),
                  onPressed: _showHelpDialog,
                ),
                SimpleButton(
                  icon: FontAwesomeIcons.expandArrowsAlt,
                  iconColor: Colors.white.withOpacity(0.7),
                  iconSize: 22,
                  text: 'Reiniciar vista',
                  fontSize: 13,
                  textColor: Colors.white.withOpacity(0.8),
                  backgroundColor: Colors.black26.withOpacity(0.2),
                  padding: const EdgeInsets.only(top: 8, right: 20, left: 20, bottom: 8),
                  onPressed: _resetZoom,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
          width: _calculateChartWidth(context),
          height: SizeConfig.screenHeight,
          child: LineChart(
            LineChartData(
              gridData: _getGridData(context, rateData),
              lineTouchData: _getLineTouchData(context, rateData),
              minY: rateData.minValue,
              maxY: rateData.maxValue,
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
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
    historicalChartData = BuildHistoricalChartData(widget.responseType).fromHistoricalRates(widget.values);
    _chartDataLoaded = true;
  }

  void _initializeControllers() {
    _tabController = TabController(
      length: historicalChartData.ratesData.length,
      vsync: this,
    );
    _transformationController = TransformationController(defaultZoom);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        _transformationController.value = _animation.value;
      });
  }

  void _disposeControllers() {
    _transformationController.dispose();
    _animationController.dispose();
    _tabController.dispose();
  }

  double _calculateChartWidth(BuildContext context) {
    if (historicalChartData.ratesData.length <= 10) {
      return SizeConfig.screenWidth * 2;
    } else {
      return SizeConfig.screenWidth * (2 + (historicalChartData.ratesData.length * 0.02));
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const HistoricalChartHelpDialog();
      },
    );
  }

  void _resetZoom() {
    if (_transformationController.value != defaultZoom) {
      _animation = Matrix4Tween(
        begin: _transformationController.value,
        end: defaultZoom,
      ).animate(CurveTween(curve: Curves.easeOut).animate(_animationController));
      _animationController.forward(from: 0);
    }
  }

  LineTouchData _getLineTouchData(BuildContext context, HistoricalRateData rateData) {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        fitInsideVertically: true,
        fitInsideHorizontally: true,
        tooltipBgColor: Colors.black54.withOpacity(0.7),
        maxContentWidth: SizeConfig.screenWidth / 2,
        tooltipRoundedRadius: 15,
        getTooltipItems: (touchedSpots) {
          NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
          List<LineTooltipItem> tooltipItems = [];
          for (int i = 0; i < touchedSpots.length; i++) {
            LineBarSpot touchedSpot = touchedSpots[i];
            DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
            if (rateData.isInteger) {
              numberFormat.maximumFractionDigits = 0;
            }
            String value = numberFormat.format(touchedSpot.y);
            DateTime date = DateTime.fromMillisecondsSinceEpoch(touchedSpot.x.toInt());
            String formattedDate = dateFormat.format(date);
            String leftSymbol = "${rateData.leftSymbol ?? ''} ";
            String rightSymbol = " ${rateData.rightSymbol ?? ''}";
            String tooltip = i + 1 < touchedSpots.length ? "$leftSymbol$value$rightSymbol" : "$leftSymbol$value$rightSymbol\n\n$formattedDate";
            tooltipItems.add(LineTooltipItem(tooltip, rateData.tooltipTextStyle));
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
        color: Colors.white.withOpacity(0.4),
        strokeWidth: 1,
      ),
      horizontalInterval: rateData.interval / 2,
      drawVerticalLine: false,
    );
  }

  SideTitles _getLeftTitles(BuildContext context, HistoricalRateData rateData) {
    return SideTitles(
      showTitles: true,
      getTextStyles: (value, _) => TextStyle(
        color: Colors.white.withOpacity(0.7),
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      interval: rateData.interval,
      margin: 30,
      reservedSize: 200,
      getTitles: (value) {
        NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
        if (rateData.isInteger) {
          numberFormat.maximumFractionDigits = 0;
        }
        String leftSymbol = "${rateData.leftSymbol ?? ''} ";
        String rightSymbol = " ${rateData.rightSymbol ?? ''}";

        return "$leftSymbol${numberFormat.format(value)}$rightSymbol";
      },
    );
  }
}

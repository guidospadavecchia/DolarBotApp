import '../../classes/hive/historical_rate.dart';
import '../../classes/size_config.dart';
import '../base/base_info_screen.dart';
import '../base/widgets/title_banner.dart';
import '../common/image_screen.dart';
import '../../util/util.dart';
import '../../widgets/common/cool_app_bar.dart';
import '../../widgets/common/simple_button.dart';
import '../../widgets/historical_chart/historical_chart.dart';
import '../../widgets/historical_chart/historical_chart_help_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HistoricalRatesScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String endpoint;
  final Type responseType;
  final List<Color> colors;
  final String? iconAsset;
  final IconData? iconData;

  HistoricalRatesScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.endpoint,
    required this.responseType,
    required this.colors,
    this.iconAsset,
    this.iconData,
  })  : assert((iconAsset != null || iconData != null)),
        super(key: key);

  @override
  _HistoricalRatesScreenState createState() => _HistoricalRatesScreenState();
}

class _HistoricalRatesScreenState extends State<HistoricalRatesScreen> {
  late List<HistoricalRate> _historicalRates;
  String _dataTimeSpan = '';

  @override
  void initState() {
    super.initState();
    _loadHistoricalData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPopScope(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: CoolAppBar(
          title: "Evolución: ${widget.title}",
          isMainMenu: false,
          foregroundColor: Colors.white,
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.colors,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _banner(),
              Expanded(
                child: Center(
                  child: _body(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return TitleBanner(
      text: widget.subtitle,
      iconAsset: widget.iconAsset,
      iconData: widget.iconData,
      showTimeStamp: _historicalRates.length > 1,
      timeStampValue: _dataTimeSpan,
    );
  }

  Widget _body() {
    if (_historicalRates.length <= 2) {
      return _EmptyChart();
    }

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      child: HistoricalChart(
        responseType: widget.responseType,
        values: _historicalRates,
      ),
    );
  }

  Future<bool> _onWillPopScope(BuildContext context) {
    dismissAllToast();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  void _loadHistoricalData() {
    Box historicalRatesBox = Hive.box('historicalRates');
    _historicalRates = historicalRatesBox.get(widget.endpoint, defaultValue: []).cast<HistoricalRate>();

    if (_historicalRates.isEmpty) {
      return;
    }

    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    if (_historicalRates.length > 1) {
      _historicalRates.sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
      DateTime startDate = DateTime.parse(_historicalRates.first.timestamp);
      String formattedStartDate = dateFormat.format(startDate);
      DateTime endDate = DateTime.parse(_historicalRates.last.timestamp);
      String formattedEndDate = dateFormat.format(endDate);
      _dataTimeSpan = startDate.isSameDayAs(endDate) ? "$formattedStartDate" : "$formattedStartDate - $formattedEndDate";
    } else {
      DateTime date = DateTime.parse(_historicalRates.single.timestamp);
      _dataTimeSpan = dateFormat.format(date);
    }
  }
}

class _EmptyChart extends StatelessWidget {
  const _EmptyChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageScreen(
          image: const AssetImage("assets/images/general/collecting_data.png"),
          text: "Aún no hay datos suficientes para mostrar los gráficos de evolución",
          textStyle: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: SizeConfig.blockSizeVertical * 3,
            fontFamily: "Raleway",
          ),
          imageOpacity: 0.5,
          textOpacity: 0.7,
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical,
        ),
        SimpleButton(
          icon: FontAwesomeIcons.questionCircle,
          iconColor: Colors.white.withOpacity(0.7),
          iconSize: 22,
          text: '¿Qué es esto?',
          fontSize: 13,
          textColor: Colors.white.withOpacity(0.8),
          backgroundColor: Colors.black26.withOpacity(0.2),
          padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          onPressed: () => _showHelpDialog(context),
        ),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const HistoricalChartHelpDialog();
      },
    );
  }
}

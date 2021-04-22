import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:dolarbot_app/widgets/historical_chart/historical_chart.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HistoricalRatesScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String endpoint;
  final Type responseType;

  HistoricalRatesScreen({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.endpoint,
    @required this.responseType,
  }) : super(key: key);

  @override
  _HistoricalRatesScreenState createState() => _HistoricalRatesScreenState();
}

class _HistoricalRatesScreenState extends State<HistoricalRatesScreen> {
  List<HistoricalRate> historicalRates;
  String dataTimeSpan = '';

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
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: false,
        appBar: CoolAppBar(
          title: "Datos históricos de ${widget.title}",
          isMainMenu: false,
          foregroundColor: ThemeManager.getPrimaryTextColor(context),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (historicalRates.length <= 1) {
      //TODO: Cambiar por un widget que muestre una imagen centrada con texto.
      return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Aún no hay datos suficientes para mostrar la evolución"),
          ),
        ],
      );
    }

    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.subtitle,
                style: TextStyle(fontSize: 22),
              ),
              Expanded(
                child: const SizedBox.shrink(),
              ),
              Text(dataTimeSpan),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          HistoricalChart(
            responseType: widget.responseType,
            values: historicalRates,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "La información mostrada corresponde al registro histórico de tus consultas recopiladas periódicamente dentro de la app.",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 13,
            ),
          ),
        ],
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
    List<HistoricalRate> history =
        historicalRatesBox.get('historicalRates', defaultValue: []).cast<HistoricalRate>();
    historicalRates = history.where((x) => x.endpoint == widget.endpoint).toList();

    if (historicalRates.isEmpty) {
      return;
    }

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    if (historicalRates.length > 1) {
      historicalRates.sort(
        (a, b) => a.timestamp.compareTo(b.timestamp),
      );
      DateTime startDate = DateTime.parse(historicalRates.first.timestamp);
      String formattedStartDate = dateFormat.format(startDate);
      DateTime endDate = DateTime.parse(historicalRates.last.timestamp);
      String formattedEndDate = dateFormat.format(endDate);
      dataTimeSpan = startDate.isSameDayAs(endDate)
          ? "$formattedStartDate"
          : "$formattedStartDate - $formattedEndDate";
    } else {
      DateTime date = DateTime.parse(historicalRates.single.timestamp);
      dataTimeSpan = dateFormat.format(date);
    }
  }
}

import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/util/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class HistoricalChartDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  final String endpoint;
  final Type responseType;

  const HistoricalChartDialog({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.endpoint,
    @required this.responseType,
  }) : super(key: key);

  @override
  _HistoricalChartDialogState createState() => _HistoricalChartDialogState();
}

class _HistoricalChartDialogState extends State<HistoricalChartDialog> {
  List<HistoricalRate> historicalRates;
  String dataTimeSpan = '';

  @override
  void initState() {
    super.initState();
    _loadHistoricalData();
  }

  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      dialog: Dialog(
        insetPadding: const EdgeInsets.all(15),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          height: 640,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${widget.title} ${widget.subtitle}",
                      style: TextStyle(fontSize: 22),
                    ),
                    Expanded(
                      child: const SizedBox.shrink(),
                    ),
                    Text(dataTimeSpan),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              //TODO: Create Chart
              Placeholder(
                color: Colors.red,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  "La información mostrada corresponde al registro histórico de tus consultas dentro de la app.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: DialogButton(
                  text: 'Volver',
                  icon: Icons.check_outlined,
                  onPressed: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadHistoricalData() {
    Box historicalRatesBox = Hive.box('historicalRates');
    List<HistoricalRate> history =
        historicalRatesBox.get('historicalRates', defaultValue: []).cast<HistoricalRate>();
    historicalRates = history.where((x) => x.endpoint == widget.endpoint).toList();

    if (historicalRates.isEmpty) {
      dataTimeSpan = 'Sin datos';
    } else {
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
}

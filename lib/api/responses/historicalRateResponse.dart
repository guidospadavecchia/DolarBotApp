import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class HistoricalRateResponse extends ApiResponse {
  String timestamp;
  String value;
  String currency;
  List<HistoricalMonthRate> monthlyRates;

  HistoricalRateResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    value = json["valor"];
    currency = json["moneda"];
    monthlyRates = new List<HistoricalMonthRate>();

    json["meses"].forEach((key, value) =>
        {monthlyRates.add(HistoricalMonthRate.fromJson(value))});
  }
}

class HistoricalMonthRate {
  final String year;
  final String month;
  final String value;

  HistoricalMonthRate({
    this.year,
    this.month,
    this.value,
  });

  HistoricalMonthRate.fromJson(Map json)
      : year = json["anio"],
        month = json["mes"],
        value = json["valor"];
}

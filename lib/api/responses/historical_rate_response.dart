import 'dart:convert';
import 'package:dolarbot_app/api/responses/base/api_response.dart';

class HistoricalRateResponse extends ApiResponse {
  String? value;
  String? currency;
  late List<HistoricalMonthRate> monthlyRates;

  HistoricalRateResponse(Map json) : super(json);

  @override
  void map(Map json) {
    monthlyRates = [];
    timestamp = json["fecha"];
    value = json["valor"];
    currency = json["moneda"];

    json["meses"].forEach(
      (key, value) => {
        monthlyRates.add(
          HistoricalMonthRate.fromJson(value),
        ),
      },
    );
  }

  @override
  String serialize() {
    return jsonEncode({
      'fecha': timestamp,
      'valor': value,
      'moneda': currency,
      'meses': monthlyRates.map((x) => x.toJson()),
    });
  }
}

class HistoricalMonthRate {
  final String? year;
  final String? month;
  final String? value;

  HistoricalMonthRate({
    this.year,
    this.month,
    this.value,
  });

  HistoricalMonthRate.fromJson(Map json)
      : year = json["anio"],
        month = json["mes"],
        value = json["valor"];

  String toJson() {
    return jsonEncode({
      'anio': year,
      'mes': month,
      'valor': value,
    });
  }
}

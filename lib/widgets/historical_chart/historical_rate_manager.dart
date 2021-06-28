import 'package:dolarbot_app/classes/app_config.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:hive/hive.dart';

class HistoricalRateManager {
  static void saveRate(BuildContext context, String endpoint, String responseType, String timestamp,
      ApiResponse data) {
    bool shouldSave = AppConfig.isProVersion;

    if (shouldSave) {
      Box historicalRatesBox = Hive.box('historicalRates');
      List<HistoricalRate> historicalRates =
          historicalRatesBox.get(endpoint, defaultValue: []).cast<HistoricalRate>();

      int saveFreq = Util.cfg.get("historicalRateSaveFrequencyMinutes") ?? Duration.minutesPerDay;
      timestamp = timestamp.replaceAll('/', '-');

      bool rateExists = historicalRates.any((x) => (saveFreq <= 0 ||
          DateTime.parse(x.timestamp).difference(DateTime.parse(timestamp)).inMinutes.abs() <
              saveFreq));

      if (!rateExists) {
        HistoricalRate historicalRate = HistoricalRate(
          endpoint: endpoint,
          responseType: responseType,
          timestamp: timestamp,
          json: data.serialize(),
        );
        historicalRates.add(historicalRate);
        historicalRatesBox.put(endpoint, historicalRates);
      }
    }

    Future.value();
  }
}

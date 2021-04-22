import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hive/hive.dart';

class HistoricalRateManager {
  static final cfg = GlobalConfiguration();

  static Future<void> saveRate(
      String endpoint, String responseType, String timestamp, ApiResponse data) {
    Box historicalRatesBox = Hive.box('historicalRates');
    List<HistoricalRate> historicalRates =
        historicalRatesBox.get(endpoint, defaultValue: []).cast<HistoricalRate>();

    int saveFreq = cfg.get("historicalRateSaveFrequencyMinutes") ?? Duration.minutesPerDay;
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
      return historicalRatesBox.put(endpoint, historicalRates);
    }

    return Future.value();
  }
}

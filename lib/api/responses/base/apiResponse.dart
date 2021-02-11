export 'package:dolarbot_app/api/responses/dollarResponse.dart';
export 'package:dolarbot_app/api/responses/euroResponse.dart';
export 'package:dolarbot_app/api/responses/realResponse.dart';
export 'package:dolarbot_app/api/responses/historicalRateResponse.dart';
export 'package:dolarbot_app/api/responses/venezuelaResponse.dart';
export 'package:dolarbot_app/api/responses/bcraResponse.dart';
export 'package:dolarbot_app/api/responses/countryRiskResponse.dart';
export 'package:dolarbot_app/api/responses/cryptoResponse.dart';

abstract class ApiResponse {
  ApiResponse(Map json) {
    map(json);
  }

  void map(Map json);
}

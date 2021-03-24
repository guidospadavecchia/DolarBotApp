export 'package:dolarbot_app/api/responses/dollar_response.dart';
export 'package:dolarbot_app/api/responses/euro_response.dart';
export 'package:dolarbot_app/api/responses/real_response.dart';
export 'package:dolarbot_app/api/responses/historical_rate_response.dart';
export 'package:dolarbot_app/api/responses/venezuela_response.dart';
export 'package:dolarbot_app/api/responses/bcra_response.dart';
export 'package:dolarbot_app/api/responses/country_risk_response.dart';
export 'package:dolarbot_app/api/responses/crypto_response.dart';

abstract class ApiResponse {
  String timestamp;

  ApiResponse(Map json) {
    map(json);
  }

  void map(Map json);
  String serialize();
}

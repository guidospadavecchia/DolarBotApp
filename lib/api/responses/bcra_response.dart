import 'dart:convert';
import 'package:dolarbot_app/api/responses/base/api_response.dart';

class BcraResponse extends ApiResponse {
  String value;
  String currency;

  BcraResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    value = json["valor"];
    currency = json["moneda"];
  }

  @override
  String serialize() {
    return jsonEncode({
      'timestamp': timestamp,
      'value': value,
      'currency': currency,
    });
  }
}

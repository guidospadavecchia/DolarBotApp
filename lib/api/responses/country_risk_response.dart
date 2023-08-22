import 'dart:convert';
import 'base/api_response.dart';

class CountryRiskResponse extends ApiResponse {
  String? value;

  CountryRiskResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    value = json["valor"];
  }

  @override
  String serialize() {
    return jsonEncode({
      'fecha': timestamp,
      'valor': value,
    });
  }
}

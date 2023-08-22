import 'dart:convert';
import 'base/api_response.dart';

class BcraResponse extends ApiResponse {
  String? value;
  String? currency;

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
      'fecha': timestamp,
      'valor': value,
      'moneda': currency,
    });
  }
}

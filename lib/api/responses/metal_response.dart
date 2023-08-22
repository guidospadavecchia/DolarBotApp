import 'dart:convert';
import 'base/api_response.dart';

class MetalResponse extends ApiResponse {
  String? value;
  String? unit;
  String? currency;

  MetalResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    value = json["valor"];
    unit = json["unidad"];
    currency = json["moneda"];
  }

  @override
  String serialize() {
    return jsonEncode({
      'fecha': timestamp,
      'valor': value,
      'unidad': unit,
      'moneda': currency,
    });
  }
}

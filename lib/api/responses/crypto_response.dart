import 'dart:convert';
import 'base/api_response.dart';

class CryptoResponse extends ApiResponse {
  String? arsPrice;
  String? arsPriceWithTaxes;
  String? usdPrice;
  String? code;

  CryptoResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    arsPrice = json["ars"];
    arsPriceWithTaxes = json["arsTaxed"];
    usdPrice = json["usd"];
    code = json["code"];
  }

  @override
  String serialize() {
    return jsonEncode({
      'fecha': timestamp,
      'ars': arsPrice,
      'arsTaxed': arsPriceWithTaxes,
      'usd': usdPrice,
      'code': code,
    });
  }
}

import 'dart:convert';
import 'package:dolarbot_app/api/responses/base/api_response.dart';

class CryptoResponse extends ApiResponse {
  String arsPrice;
  String arsPriceWithTaxes;
  String usdPrice;
  String code;

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
      'timestamp': timestamp,
      'arsPrice': arsPrice,
      'arsPriceWithTaxes': arsPriceWithTaxes,
      'usdPrice': usdPrice,
      'code': code,
    });
  }
}

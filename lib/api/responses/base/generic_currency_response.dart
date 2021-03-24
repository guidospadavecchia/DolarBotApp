import 'dart:convert';

import 'package:dolarbot_app/api/responses/base/api_response.dart';

class GenericCurrencyResponse extends ApiResponse {
  String buyPrice;
  String sellPrice;
  String sellPriceWithTaxes;

  GenericCurrencyResponse(Map json) : super(json) {
    map(json);
  }

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    buyPrice = json["compra"];
    sellPrice = json["venta"];
    sellPriceWithTaxes = json["ventaAhorro"];
  }

  @override
  String serialize() {
    return jsonEncode({
      'timestamp': timestamp,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'sellPriceWithTaxes': sellPriceWithTaxes,
    });
  }
}

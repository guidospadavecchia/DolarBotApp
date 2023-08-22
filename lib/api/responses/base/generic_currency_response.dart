import 'dart:convert';

import 'api_response.dart';

class GenericCurrencyResponse extends ApiResponse {
  String? buyPrice;
  String? sellPrice;
  String? sellPriceWithTaxes;

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
      'fecha': timestamp,
      'compra': buyPrice,
      'venta': sellPrice,
      'ventaAhorro': sellPriceWithTaxes,
    });
  }
}

import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

abstract class GenericCurrencyResponse extends ApiResponse {
  String timestamp;
  String buyPrice;
  String sellPrice;

  GenericCurrencyResponse(Map json) : super(json) {
    map(json);
  }

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    buyPrice = json["compra"];
    sellPrice = json["venta"];
  }
}

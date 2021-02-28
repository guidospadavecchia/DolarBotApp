import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class CryptoResponse extends ApiResponse {
  String timestamp;
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
}

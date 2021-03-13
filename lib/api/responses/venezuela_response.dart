import 'package:dolarbot_app/api/responses/base/api_response.dart';

class VenezuelaResponse extends ApiResponse {
  String timestamp;
  String blackMarketPrice;
  String bankPrice;
  String cucutaPrice;
  String currencyCode;

  VenezuelaResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    blackMarketPrice = json["paralelo"];
    bankPrice = json["bancos"];
    cucutaPrice = json["cucuta"];
    currencyCode = json["moneda"];
  }
}
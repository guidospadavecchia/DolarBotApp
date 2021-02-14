import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class VenezuelaResponse extends ApiResponse {
  String timestamp;
  String blackMarketPrice;
  String bankPrice;
  String cucutaPrice;

  VenezuelaResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    blackMarketPrice = json["paralelo"];
    bankPrice = json["bancos"];
    cucutaPrice = json["cucuta"];
  }
}
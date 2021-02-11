import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class CryptoResponse extends ApiResponse {
  String timestamp;
  String arsPrice;
  String usdPrice;

  CryptoResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    arsPrice = json["ars"];
    usdPrice = json["usd"];
  }
}

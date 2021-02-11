import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class RealResponse extends ApiResponse {
  String timestamp;
  String buyPrice;
  String sellPrice;

  RealResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    buyPrice = json["compra"];
    sellPrice = json["venta"];
  }
}

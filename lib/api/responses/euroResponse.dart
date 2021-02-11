import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class EuroResponse extends ApiResponse {
  String timestamp;
  String buyPrice;
  String sellPrice;

  EuroResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    buyPrice = json["compra"];
    sellPrice = json["venta"];
  }
}

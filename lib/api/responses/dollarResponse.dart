import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class DollarResponse extends ApiResponse {
  String timestamp;
  String buyPrice;
  String sellPrice;

  DollarResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    buyPrice = json["compra"];
    sellPrice = json["venta"];
  }
}

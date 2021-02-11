import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class MetalResponse extends ApiResponse {
  String timestamp;
  String value;
  String unit;
  String currency;

  MetalResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    value = json["valor"];
    unit = json["unidad"];
    currency = json["moneda"];
  }
}

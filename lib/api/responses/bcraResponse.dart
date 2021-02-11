import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class BcraResponse extends ApiResponse {
  String timestamp;
  String value;
  String currency;

  BcraResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    value = json["valor"];
    currency = json["moneda"];
  }
}

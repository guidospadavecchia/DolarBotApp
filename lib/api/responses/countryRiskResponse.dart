import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class CountryRiskResponse extends ApiResponse {
  String timestamp;
  String value;

  CountryRiskResponse(Map json) : super(json);

  @override
  void map(Map json) {
    timestamp = json["fecha"];
    value = json["valor"];
  }
}

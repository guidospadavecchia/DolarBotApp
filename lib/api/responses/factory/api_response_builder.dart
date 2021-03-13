import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/api/responses/metal_response.dart';

class ApiResponseBuilder {
  static ApiResponse fromType(String type, Map json) {
    if (type == (DollarResponse).toString() ||
        type == (EuroResponse).toString() ||
        type == (RealResponse).toString())
      return GenericCurrencyResponse(json);
    else if (type == (CryptoResponse).toString())
      return CryptoResponse(json);
    else if (type == (MetalResponse).toString())
      return MetalResponse(json);
    else if (type == (CountryRiskResponse).toString())
      return CountryRiskResponse(json);
    else if (type == (BcraResponse).toString())
      return BcraResponse(json);
    else if (type == (VenezuelaResponse).toString()) return VenezuelaResponse(json);

    throw 'Unknown ApiResponse type';
  }
}

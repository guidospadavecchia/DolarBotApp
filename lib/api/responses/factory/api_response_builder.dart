import '../base/api_response.dart';

class ApiResponseBuilder {
  static ApiResponse fromType(Type type, Map json) {
    return fromTypeName(type.toString(), json);
  }

  static ApiResponse fromTypeName(String type, Map json) {
    if (type == (DollarResponse).toString()) return DollarResponse(json);
    if (type == (EuroResponse).toString()) return EuroResponse(json);
    if (type == (RealResponse).toString())
      return RealResponse(json);
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

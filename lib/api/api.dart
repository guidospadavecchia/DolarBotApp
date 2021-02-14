import 'dart:convert';
import 'dart:async';

import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:http/http.dart' as http;
import 'package:dolarbot_app/api/api_endpoints.dart';

export 'package:dolarbot_app/api/api_endpoints.dart';

class API {
  static var urlBase = 'https://dolarbot-api.herokuapp.com';

  static Future<T> _fetch<T extends ApiResponse>(
      String endpoint, T Function(Map json) creator) async {
    Map httpResponse;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'DOLARBOT_APIKEY': ''
    };

    await http
        .get("$urlBase$endpoint", headers: requestHeaders)
        .then((response) {
      httpResponse = json.decode(response.body);
    });

    return creator(httpResponse);
  }

  static Future<DollarResponse> getDollarRate(DollarEndpoints endpoint) async {
    return _fetch(
      endpoint.value,
      (json) => new DollarResponse(json),
    );
  }

  static Future<EuroResponse> getEuroRate(EuroEndpoints endpoint) async {
    return _fetch(
      endpoint.value,
      (json) => new EuroResponse(json),
    );
  }

  static Future<RealResponse> getRealRate(RealEndpoints endpoint) async {
    return _fetch(
      endpoint.value,
      (json) => new RealResponse(json),
    );
  }

  static Future<MetalResponse> getMetalRate(MetalEndpoints endpoint) async {
    return _fetch(
      endpoint.value,
      (json) => new MetalResponse(json),
    );
  }

  static Future<CryptoResponse> getCryptoRate(CryptoEndpoints endpoint) async {
    return _fetch(
      endpoint.value,
      (json) => new CryptoResponse(json),
    );
  }

  static Future<VenezuelaResponse> getVzlaRate(
      VenezuelaEndpoints endpoint) async {
    return _fetch(
      endpoint.value,
      (json) => new VenezuelaResponse(json),
    );
  }

  static Future<CountryRiskResponse> getCountryRisk() async {
    return _fetch(
      BcraEndpoints.riesgoPais.value,
      (json) => new CountryRiskResponse(json),
    );
  }

  static Future<BcraResponse> getBcraReserves() async {
    return _fetch(
      BcraEndpoints.reservas.value,
      (json) => new BcraResponse(json),
    );
  }

  static Future<BcraResponse> getCirculatingCurrency() async {
    return _fetch(
      BcraEndpoints.circulante.value,
      (json) => new BcraResponse(json),
    );
  }

  static Future<HistoricalRateResponse> getHistoricalRates(
      HistoricalRateEndpoints endpoint) async {
    return _fetch(
      endpoint.value,
      (json) => new HistoricalRateResponse(json),
    );
  }
}

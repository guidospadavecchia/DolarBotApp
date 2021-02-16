import 'dart:convert';
import 'dart:async';

import 'package:dolarbot_app/api/cache/cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:dolarbot_app/classes/hive/cache_entry.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:dolarbot_app/api/api_endpoints.dart';

export 'package:dolarbot_app/api/api_endpoints.dart';

class API {
  static final cfg = GlobalConfiguration();

  static Future<DollarResponse> getDollarRate(DollarEndpoints endpoint) async {
    return _getData(
      endpoint.value,
      (json) => new DollarResponse(json),
    );
  }

  static Future<EuroResponse> getEuroRate(EuroEndpoints endpoint) async {
    return _getData(
      endpoint.value,
      (json) => new EuroResponse(json),
    );
  }

  static Future<RealResponse> getRealRate(RealEndpoints endpoint) async {
    return _getData(
      endpoint.value,
      (json) => new RealResponse(json),
    );
  }

  static Future<MetalResponse> getMetalRate(MetalEndpoints endpoint) async {
    return _getData(
      endpoint.value,
      (json) => new MetalResponse(json),
    );
  }

  static Future<CryptoResponse> getCryptoRate(CryptoEndpoints endpoint) async {
    return _getData(
      endpoint.value,
      (json) => new CryptoResponse(json),
    );
  }

  static Future<VenezuelaResponse> getVzlaRate(
      VenezuelaEndpoints endpoint) async {
    return _getData(
      endpoint.value,
      (json) => new VenezuelaResponse(json),
    );
  }

  static Future<CountryRiskResponse> getCountryRisk() async {
    return _getData(
      BcraEndpoints.riesgoPais.value,
      (json) => new CountryRiskResponse(json),
    );
  }

  static Future<BcraResponse> getBcraReserves() async {
    return _getData(
      BcraEndpoints.reservas.value,
      (json) => new BcraResponse(json),
    );
  }

  static Future<BcraResponse> getCirculatingCurrency() async {
    return _getData(
      BcraEndpoints.circulante.value,
      (json) => new BcraResponse(json),
    );
  }

  static Future<HistoricalRateResponse> getHistoricalRates(
      HistoricalRateEndpoints endpoint) async {
    return _getData(
      endpoint.value,
      (json) => new HistoricalRateResponse(json),
    );
  }

  static Future<String> _fetch(String endpoint) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'DOLARBOT_APIKEY': cfg.get("apiKey"),
    };
    String urlBase = cfg.get("apiBaseUrl");
    String url = "$urlBase$endpoint";

    String data;
    await http.get(url, headers: requestHeaders).then((response) {
      data = response.body;
    });

    return data;
  }

  static Future<T> _getData<T extends ApiResponse>(
      String endpoint, T Function(Map json) creator) async {
    Map jsonMap;
    CacheEntry cachedValue = CacheManager.read(endpoint);

    if (cachedValue == null || cachedValue.isExpired()) {
      String response = await _fetch(endpoint);
      CacheManager.save(endpoint, response);
      jsonMap = json.decode(response);
    } else {
      jsonMap = json.decode(cachedValue.data);
    }

    return creator(jsonMap);
  }
}

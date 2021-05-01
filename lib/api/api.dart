import 'dart:convert';
import 'dart:async';
import 'package:dolarbot_app/api/cache/cache_manager.dart';
import 'package:dolarbot_app/classes/hive/cache_entry.dart';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/metal_response.dart';
import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/classes/connectivity_status.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

export 'package:dolarbot_app/api/api_endpoints.dart';

class API {
  static final cfg = GlobalConfiguration();

  static Future<DollarResponse?> getDollarRate(DollarEndpoints endpoint,
      {bool forceRefresh = false}) async {
    return getData(
      endpoint.value,
      (json) => new DollarResponse(json),
      forceRefresh,
    );
  }

  static Future<EuroResponse?> getEuroRate(EuroEndpoints endpoint,
      {bool forceRefresh = false}) async {
    return getData(
      endpoint.value,
      (json) => new EuroResponse(json),
      forceRefresh,
    );
  }

  static Future<RealResponse?> getRealRate(RealEndpoints endpoint,
      {bool forceRefresh = false}) async {
    return getData(
      endpoint.value,
      (json) => new RealResponse(json),
      forceRefresh,
    );
  }

  static Future<MetalResponse?> getMetalRate(MetalEndpoints endpoint,
      {bool forceRefresh = false}) async {
    return getData(
      endpoint.value,
      (json) => new MetalResponse(json),
      forceRefresh,
    );
  }

  static Future<CryptoResponse?> getCryptoRate(CryptoEndpoints endpoint,
      {bool forceRefresh = false}) async {
    return getData(
      endpoint.value,
      (json) => new CryptoResponse(json),
      forceRefresh,
    );
  }

  static Future<VenezuelaResponse?> getVzlaRate(VenezuelaEndpoints endpoint,
      {bool forceRefresh = false}) async {
    return getData(
      endpoint.value,
      (json) => new VenezuelaResponse(json),
      forceRefresh,
    );
  }

  static Future<CountryRiskResponse?> getCountryRisk({bool forceRefresh = false}) async {
    return getData(
      BcraEndpoints.riesgoPais.value,
      (json) => new CountryRiskResponse(json),
      forceRefresh,
    );
  }

  static Future<BcraResponse?> getBcraReserves({bool forceRefresh = false}) async {
    return getData(
      BcraEndpoints.reservas.value,
      (json) => new BcraResponse(json),
      forceRefresh,
    );
  }

  static Future<BcraResponse?> getCirculatingCurrency({bool forceRefresh = false}) async {
    return getData(
      BcraEndpoints.circulante.value,
      (json) => new BcraResponse(json),
      forceRefresh,
    );
  }

  static Future<HistoricalRateResponse?> getHistoricalRates(HistoricalRateEndpoints endpoint,
      {bool forceRefresh = false}) async {
    return getData(
      endpoint.value,
      (json) => new HistoricalRateResponse(json),
      forceRefresh,
    );
  }

  static Future<String> _fetch(String endpoint) async {
    Map<String, String > requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'DOLARBOT_APIKEY': cfg.get("apiKey"),
    };
    try {
      bool isConnected = await ConnectivityStatus.isConnected();
      if (isConnected) {
        String? urlBase = cfg.get("apiBaseUrl");
        int timeoutSeconds = cfg.get("apiRequestTimeoutSeconds");
        String url = "$urlBase$endpoint";

        String data = '';
        Duration timeout =
            Duration(seconds: timeoutSeconds > 0 ? timeoutSeconds : Duration.secondsPerDay);
        await http
            .get(Uri.parse(url), headers: requestHeaders)
            .timeout(timeout)
            .then((response) => data = response.body);
        return data;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  static Future<Map?> getRawData(String endpoint, bool forceRefresh) async {
    try {
      Map? jsonMap;
      CacheEntry? cachedValue = CacheManager.read(endpoint);

      if (cachedValue == null || cachedValue.isExpired() || forceRefresh) {
        String response = await _fetch(endpoint);
        if (response != '') {
          CacheManager.save(endpoint, response);
          jsonMap = json.decode(response);
        } else {
          //If fetch fails, return the cached value even if expired
          return jsonMap = cachedValue!.data != null ? json.decode(cachedValue.data) : null;
        }
      } else {
        jsonMap = json.decode(cachedValue.data);
      }

      return jsonMap;
    } catch (e) {
      return null;
    }
  }

  static Future<T?> getData<T extends ApiResponse>(
      String endpoint, T Function(Map json) creator, bool forceRefresh) async {
    try {
      Map? jsonMap = await getRawData(endpoint, forceRefresh);
      return jsonMap != null ? creator(jsonMap) : null;
    } catch (e) {
      return null;
    }
  }
}

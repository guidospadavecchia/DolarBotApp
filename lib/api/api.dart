import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:dolarbot_app/classes/endpoints/moenda_generica.dart';

class API {
  static var urlBase = 'https://dolarbot-api.herokuapp.com';
  static var endpoint = '/api/dolar/oficial';

  static Future<MonedaGenerica> getMonedaGenerica() async {
    Map mapMonedaGenerica;
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'DOLARBOT_APIKEY': ''
    };

    await http
        .get("$urlBase$endpoint", headers: requestHeaders)
        .then((response) {
      mapMonedaGenerica = json.decode(response.body);
    });

    return MonedaGenerica.fromJson(mapMonedaGenerica);
  }
}

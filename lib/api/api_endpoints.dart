enum DollarEndpoints {
  oficial,
  blue,
  ahorro,
  contadoLiqui,
  promedio,
  bolsa,
  bbva,
  piano,
  hipotecario,
  galicia,
  santander,
  ciudad,
  supervielle,
  patagonia,
  comafi,
  nacion,
  bind,
  bancor,
  chaco,
  pampa,
}

enum EuroEndpoints {
  nacion,
  galicia,
  bbva,
  pampa,
  chaco,
  hipotecario,
}

enum RealEndpoints {
  nacion,
  bbva,
  chaco,
}

enum MetalEndpoints {
  oro,
  plata,
  cobre,
}

enum CryptoEndpoints {
  bitcoin,
  bitcoincash,
  ethereum,
  monero,
  litecoin,
  ripple,
  dash,
}

enum VenezuelaEndpoints {
  dolar,
  euro,
}

enum BcraEndpoints {
  riesgoPais,
  reservas,
  circulante,
}

enum HistoricalRateEndpoints {
  dolarOficial,
  dolarBlue,
  euroOficial,
  realOficial,
}

extension DollarEndpointsExtension on DollarEndpoints {
  static const endpoints = {
    DollarEndpoints.oficial: '/api/dolar/oficial',
    DollarEndpoints.blue: '/api/dolar/blue',
    DollarEndpoints.ahorro: '/api/dolar/ahorro',
    DollarEndpoints.contadoLiqui: '/api/dolar/contadoliqui',
    DollarEndpoints.promedio: '/api/dolar/promedio',
    DollarEndpoints.bolsa: '/api/dolar/bolsa',
    DollarEndpoints.bbva: '/api/dolar/bancos/bbva',
    DollarEndpoints.piano: '/api/dolar/bancos/piano',
    DollarEndpoints.hipotecario: '/api/dolar/bancos/hipotecario',
    DollarEndpoints.galicia: '/api/dolar/bancos/galicia',
    DollarEndpoints.santander: '/api/dolar/bancos/santander',
    DollarEndpoints.ciudad: '/api/dolar/bancos/ciudad',
    DollarEndpoints.supervielle: '/api/dolar/bancos/supervielle',
    DollarEndpoints.patagonia: '/api/dolar/bancos/patagonia',
    DollarEndpoints.comafi: '/api/dolar/bancos/comafi',
    DollarEndpoints.nacion: '/api/dolar/bancos/nacion',
    DollarEndpoints.bind: '/api/dolar/bancos/bind',
    DollarEndpoints.bancor: '/api/dolar/bancos/bancor',
    DollarEndpoints.chaco: '/api/dolar/bancos/chaco',
    DollarEndpoints.pampa: '/api/dolar/bancos/pampa',
  };

  String get value => endpoints[this];
}

extension EuroEndpointsExtension on EuroEndpoints {
  static const endpoints = {
    EuroEndpoints.nacion: '/api/euro/bancos/nacion',
    EuroEndpoints.galicia: '/api/euro/bancos/galicia',
    EuroEndpoints.bbva: '/api/euro/bancos/bbva',
    EuroEndpoints.pampa: '/api/euro/bancos/pampa',
    EuroEndpoints.chaco: '/api/euro/bancos/chaco',
    EuroEndpoints.hipotecario: '/api/euro/bancos/hipotecario',
  };

  String get value => endpoints[this];
}

extension RealEndpointsExtension on RealEndpoints {
  static const endpoints = {
    RealEndpoints.nacion: '/api/real/bancos/nacion',
    RealEndpoints.bbva: '/api/real/bancos/bbva',
    RealEndpoints.chaco: '/api/real/bancos/chaco',
  };

  String get value => endpoints[this];
}

extension MetalEndpointsExtension on MetalEndpoints {
  static const endpoints = {
    MetalEndpoints.oro: '/api/metales/oro',
    MetalEndpoints.plata: '/api/metales/plata',
    MetalEndpoints.cobre: '/api/metales/cobre',
  };

  String get value => endpoints[this];
}

extension CryptoEndpointsExtension on CryptoEndpoints {
  static const endpoints = {
    CryptoEndpoints.bitcoin: '/api/crypto/bitcoin',
    CryptoEndpoints.bitcoincash: '/api/crypto/bitcoincash',
    CryptoEndpoints.ethereum: '/api/crypto/ethereum',
    CryptoEndpoints.monero: '/api/crypto/monero',
    CryptoEndpoints.litecoin: '/api/crypto/litecoin',
    CryptoEndpoints.ripple: '/api/crypto/ripple',
    CryptoEndpoints.dash: '/api/crypto/dash',
  };

  String get value => endpoints[this];
}

extension VenezuelaEndpointsExtension on VenezuelaEndpoints {
  static const endpoints = {
    VenezuelaEndpoints.dolar: '/api/vzla/dolar',
    VenezuelaEndpoints.euro: '/api/vzla/euro',
  };

  String get value => endpoints[this];
}

extension BcraEndpointsExtension on BcraEndpoints {
  static const endpoints = {
    BcraEndpoints.riesgoPais: '/api/bcra/riesgopais',
    BcraEndpoints.reservas: '/api/bcra/reservas',
    BcraEndpoints.circulante: '/api/bcra/circulante',
  };

  String get value => endpoints[this];
}

extension HistoricalRateEndpointExtension on HistoricalRateEndpoints {
  static const endpoints = {
    HistoricalRateEndpoints.dolarOficial: '/api/evolucion/dolar/oficial',
    HistoricalRateEndpoints.dolarBlue: '/api/evolucion/dolar/blue',
    HistoricalRateEndpoints.euroOficial: '/api/evolucion/euro/oficial',
    HistoricalRateEndpoints.realOficial: '/api/evolucion/real/oficial',
  };

  String get value => endpoints[this];
}

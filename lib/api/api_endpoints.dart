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
  reba,
  provincia,
  icbc,
}

enum EuroEndpoints {
  nacion,
  galicia,
  bbva,
  pampa,
  chaco,
  hipotecario,
  piano,
  santander,
  ciudad,
  supervielle,
  patagonia,
  comafi,
  reba,
}

enum RealEndpoints {
  nacion,
  bbva,
  chaco,
  piano,
  ciudad,
  supervielle,
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
  binance,
  cardano,
  tether,
  dogecoin,
  polkadot,
  chainlink,
  dai,
  stellar,
  uniswap,
  theta,
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
  dolarAhorro,
  dolarBlue,
  euroOficial,
  euroAhorro,
  realOficial,
  realAhorro,
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
    DollarEndpoints.reba: '/api/dolar/bancos/reba',
    DollarEndpoints.provincia: '/api/dolar/bancos/provincia',
    DollarEndpoints.icbc: '/api/dolar/bancos/icbc',
  };

  String get value => endpoints[this]!;
}

extension EuroEndpointsExtension on EuroEndpoints {
  static const endpoints = {
    EuroEndpoints.nacion: '/api/euro/bancos/nacion',
    EuroEndpoints.galicia: '/api/euro/bancos/galicia',
    EuroEndpoints.bbva: '/api/euro/bancos/bbva',
    EuroEndpoints.pampa: '/api/euro/bancos/pampa',
    EuroEndpoints.chaco: '/api/euro/bancos/chaco',
    EuroEndpoints.hipotecario: '/api/euro/bancos/hipotecario',
    EuroEndpoints.piano: '/api/euro/bancos/piano',
    EuroEndpoints.santander: '/api/euro/bancos/santander',
    EuroEndpoints.ciudad: '/api/euro/bancos/ciudad',
    EuroEndpoints.supervielle: '/api/euro/bancos/supervielle',
    EuroEndpoints.patagonia: '/api/euro/bancos/patagonia',
    EuroEndpoints.comafi: '/api/euro/bancos/comafi',
    EuroEndpoints.reba: '/api/euro/bancos/reba',
  };

  String get value => endpoints[this]!;
}

extension RealEndpointsExtension on RealEndpoints {
  static const endpoints = {
    RealEndpoints.nacion: '/api/real/bancos/nacion',
    RealEndpoints.bbva: '/api/real/bancos/bbva',
    RealEndpoints.chaco: '/api/real/bancos/chaco',
    RealEndpoints.piano: '/api/real/bancos/piano',
    RealEndpoints.ciudad: '/api/real/bancos/ciudad',
    RealEndpoints.supervielle: '/api/real/bancos/supervielle',
  };

  String get value => endpoints[this]!;
}

extension MetalEndpointsExtension on MetalEndpoints {
  static const endpoints = {
    MetalEndpoints.oro: '/api/metales/oro',
    MetalEndpoints.plata: '/api/metales/plata',
    MetalEndpoints.cobre: '/api/metales/cobre',
  };

  String get value => endpoints[this]!;
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
    CryptoEndpoints.binance: '/api/crypto/binancecoin',
    CryptoEndpoints.cardano: '/api/crypto/cardano',
    CryptoEndpoints.tether: '/api/crypto/tether',
    CryptoEndpoints.dogecoin: '/api/crypto/dogecoin',
    CryptoEndpoints.polkadot: '/api/crypto/polkadot',
    CryptoEndpoints.chainlink: '/api/crypto/chainlink',
    CryptoEndpoints.dai: '/api/crypto/dai',
    CryptoEndpoints.stellar: '/api/crypto/stellar',
    CryptoEndpoints.uniswap: '/api/crypto/uniswap',
    CryptoEndpoints.theta: '/api/crypto/theta-token',
  };

  String get value => endpoints[this]!;
}

extension VenezuelaEndpointsExtension on VenezuelaEndpoints {
  static const endpoints = {
    VenezuelaEndpoints.dolar: '/api/vzla/dolar',
    VenezuelaEndpoints.euro: '/api/vzla/euro',
  };

  String get value => endpoints[this]!;
}

extension BcraEndpointsExtension on BcraEndpoints {
  static const endpoints = {
    BcraEndpoints.riesgoPais: '/api/bcra/riesgopais',
    BcraEndpoints.reservas: '/api/bcra/reservas',
    BcraEndpoints.circulante: '/api/bcra/circulante',
  };

  String get value => endpoints[this]!;
}

extension HistoricalRateEndpointExtension on HistoricalRateEndpoints {
  static const endpoints = {
    HistoricalRateEndpoints.dolarOficial: '/api/evolucion/dolar/oficial',
    HistoricalRateEndpoints.dolarAhorro: '/api/evolucion/dolar/oficial',
    HistoricalRateEndpoints.dolarBlue: '/api/evolucion/dolar/blue',
    HistoricalRateEndpoints.euroOficial: '/api/evolucion/euro/oficial',
    HistoricalRateEndpoints.euroAhorro: '/api/evolucion/euro/ahorro',
    HistoricalRateEndpoints.realOficial: '/api/evolucion/real/oficial',
    HistoricalRateEndpoints.realAhorro: '/api/evolucion/real/ahorro',
  };

  String get value => endpoints[this]!;
}

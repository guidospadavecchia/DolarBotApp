import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../api/responses/base/api_response.dart';
import '../../../api/responses/base/generic_currency_response.dart';
import '../../../classes/hive/historical_rate.dart';
import '../../../util/extensions/string_extensions.dart';
import 'historical_chart_data.dart';

const double _barWidth = 3;
const List<Color> _kTabColorGradient1 = const [
  Colors.lightBlueAccent,
  Colors.lightBlue,
  Colors.cyanAccent,
  Colors.cyan,
];
const List<Color> _kTabColorGradient2 = const [
  Colors.deepOrange,
  Colors.deepOrangeAccent,
  Colors.redAccent,
  Colors.red,
];
const List<Color> _kTabColorGradient3 = const [
  Colors.purple,
  Colors.purpleAccent,
  Colors.pinkAccent,
  Colors.pink,
];
const TextStyle _kTooltipTextStyle = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 18,
  fontFamily: 'Montserrat',
);

abstract class BuildHistoricalChartData {
  factory BuildHistoricalChartData(Type responseType) {
    if (responseType == DollarResponse || responseType == EuroResponse || responseType == RealResponse) return _FiatCurrency();
    if (responseType == CryptoResponse) return _Crypto();
    if (responseType == MetalResponse) return _Metal();
    if (responseType == BcraResponse) return _Bcra();
    if (responseType == CountryRiskResponse) return _CountryRisk();
    if (responseType == VenezuelaResponse) return _Venezuela();

    throw 'Unknown ApiResponse type';
  }

  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates);
}

class _FiatCurrency implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> buyPrices = [];
    List<FlSpot> sellPrices = [];
    List<FlSpot> sellPricesWithTaxes = [];

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic>? jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        GenericCurrencyResponse data = GenericCurrencyResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.buyPrice?.isNumeric() ?? false) {
          double buyPrice = double.tryParse(data.buyPrice!) ?? 0;
          buyPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), buyPrice));
        }
        if (data.sellPrice?.isNumeric() ?? false) {
          double sellPrice = double.tryParse(data.sellPrice!) ?? 0;
          sellPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), sellPrice));
        }
        if (data.sellPriceWithTaxes?.isNumeric() ?? false) {
          double sellPriceWithTaxes = double.tryParse(data.sellPriceWithTaxes!) ?? 0;
          sellPricesWithTaxes.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), sellPriceWithTaxes));
        }
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (buyPrices.length > 0)
          HistoricalRateData(
            title: "Compra",
            leftSymbol: "\$",
            maxValue: buyPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: buyPrices,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient1),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient1.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
        if (sellPrices.length > 0)
          HistoricalRateData(
            title: "Venta",
            leftSymbol: "\$",
            maxValue: sellPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: sellPrices,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient2),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient2.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
        if (sellPricesWithTaxes.length > 0)
          HistoricalRateData(
            title: "Venta + Imp.",
            leftSymbol: "\$",
            maxValue: sellPricesWithTaxes.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: sellPricesWithTaxes,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient3),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient3.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
      ],
    );
  }
}

class _Crypto implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> usdPrices = [];
    List<FlSpot> arsPrices = [];
    List<FlSpot> arsPricesWithTaxes = [];

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic>? jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        CryptoResponse data = CryptoResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.usdPrice?.isNumeric() ?? false) {
          double usdPrice = double.tryParse(data.usdPrice!) ?? 0;
          usdPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), usdPrice));
        }
        if (data.arsPrice?.isNumeric() ?? false) {
          double arsPrice = double.tryParse(data.arsPrice!) ?? 0;
          arsPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), arsPrice));
        }
        if (data.arsPriceWithTaxes?.isNumeric() ?? false) {
          double arsPriceWithTaxes = double.tryParse(data.arsPriceWithTaxes!) ?? 0;
          arsPricesWithTaxes.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), arsPriceWithTaxes));
        }
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (usdPrices.length > 0)
          HistoricalRateData(
            title: "USD",
            leftSymbol: "US\$",
            maxValue: usdPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: usdPrices,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient3),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient3.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
        if (arsPrices.length > 0)
          HistoricalRateData(
            title: "ARS",
            leftSymbol: "\$",
            maxValue: arsPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: arsPrices,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient1),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient1.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
        if (arsPricesWithTaxes.length > 0)
          HistoricalRateData(
            title: "ARS + Impuestos",
            leftSymbol: "\$",
            maxValue: arsPricesWithTaxes.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: arsPricesWithTaxes,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient2),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient2.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
      ],
    );
  }
}

class _Metal implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> values = [];
    String? unit;

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic>? jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        MetalResponse data = MetalResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.value?.isNumeric() ?? false) {
          double value = double.tryParse(data.value!) ?? 0;
          values.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), value));
        }
        if (unit == null) unit = data.unit;
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (values.length > 0)
          HistoricalRateData(
            title: "US\$ / $unit",
            leftSymbol: 'US\$',
            maxValue: values.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: values,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient1),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient1.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
      ],
    );
  }
}

class _Bcra implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> values = [];
    String? symbol;

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic>? jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        BcraResponse data = BcraResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.value?.isNumeric() ?? false) {
          double value = double.tryParse(data.value!) ?? 0;
          values.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), value));
        }
        if (symbol == null) symbol = data.currency;
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (values.length > 0)
          HistoricalRateData(
            title: symbol!,
            leftSymbol: symbol,
            maxValue: values.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: values,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient1),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient1.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
      ],
    );
  }
}

class _CountryRisk implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> values = [];

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic>? jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        CountryRiskResponse data = CountryRiskResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.value?.isNumeric() ?? false) {
          double value = double.tryParse(data.value!) ?? 0;
          values.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), value));
        }
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (values.length > 0)
          HistoricalRateData(
            title: "Riesgo País",
            rightSymbol: "puntos",
            maxValue: values.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: values,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient1),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient1.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
      ],
    );
  }
}

class _Venezuela implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> bankPrices = [];
    List<FlSpot> blackMarketPrices = [];

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic>? jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        VenezuelaResponse data = VenezuelaResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.bankPrice?.isNumeric() ?? false) {
          double bankPrice = double.tryParse(data.bankPrice!) ?? 0;
          bankPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), bankPrice));
        }
        if (data.blackMarketPrice?.isNumeric() ?? false) {
          double blackMarketPrice = double.tryParse(data.blackMarketPrice!) ?? 0;
          blackMarketPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), blackMarketPrice));
        }
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (bankPrices.length > 0)
          HistoricalRateData(
            title: "Promedio Bancos",
            leftSymbol: "Bs.",
            maxValue: bankPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: bankPrices,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient1),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient1.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
        if (blackMarketPrices.length > 0)
          HistoricalRateData(
            title: "Paralelo",
            leftSymbol: "Bs.",
            maxValue: blackMarketPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: blackMarketPrices,
              isCurved: false,
              gradient: LinearGradient(colors: _kTabColorGradient2),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: _kTabColorGradient2.map((x) => x.withAlpha(100)).toList()),
              ),
              barWidth: _barWidth,
            ),
          ),
      ],
    );
  }
}

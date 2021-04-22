import 'dart:convert';
import 'dart:math';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:dolarbot_app/widgets/historical_chart/factory/historical_chart_data.dart';
import 'package:dolarbot_app/util/extensions/string_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const List<Color> _kTabColorGradient1 = const [
  Colors.lightBlue,
  Colors.lightBlueAccent,
  Colors.cyan,
  Colors.cyanAccent,
];
const List<Color> _kTabColorGradient2 = const [
  Colors.orange,
  Colors.orangeAccent,
  Colors.red,
  Colors.redAccent,
];
const List<Color> _kTabColorGradient3 = const [
  Colors.purple,
  Colors.purpleAccent,
  Colors.pink,
  Colors.pinkAccent,
];
const TextStyle _kTooltipTextStyle = const TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontSize: 24,
  fontFamily: 'Montserrat',
);

abstract class BuildHistoricalChartData {
  factory BuildHistoricalChartData(Type responseType) {
    if (responseType == DollarResponse ||
        responseType == EuroResponse ||
        responseType == RealResponse) return _FiatCurrency();
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
      Map<dynamic, dynamic> jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        GenericCurrencyResponse data = GenericCurrencyResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.buyPrice.isNumeric()) {
          double buyPrice = double.tryParse(data.buyPrice);
          buyPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), buyPrice));
        }
        if (data.sellPrice.isNumeric()) {
          double sellPrice = double.tryParse(data.sellPrice);
          sellPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), sellPrice));
        }
        if (data.sellPriceWithTaxes.isNumeric()) {
          double sellPriceWithTaxes = double.tryParse(data.sellPriceWithTaxes);
          sellPricesWithTaxes
              .add(FlSpot(date.millisecondsSinceEpoch.toDouble(), sellPriceWithTaxes));
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
              colors: _kTabColorGradient1,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient1.first.withAlpha(20)],
              ),
              barWidth: 1,
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
              colors: _kTabColorGradient2,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient2.first.withAlpha(20)],
              ),
              barWidth: 2,
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
              colors: _kTabColorGradient3,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient3.first.withAlpha(20)],
              ),
              barWidth: 2,
            ),
          ),
      ],
    );
  }
}

class _Crypto implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> arsPrices = [];
    List<FlSpot> arsPricesWithTaxes = [];
    List<FlSpot> usdPrices = [];

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic> jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        CryptoResponse data = CryptoResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.arsPrice.isNumeric()) {
          double arsPrice = double.tryParse(data.arsPrice);
          arsPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), arsPrice));
        }
        if (data.arsPriceWithTaxes.isNumeric()) {
          double arsPriceWithTaxes = double.tryParse(data.arsPriceWithTaxes);
          arsPricesWithTaxes.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), arsPriceWithTaxes));
        }
        if (data.usdPrice.isNumeric()) {
          double usdPrice = double.tryParse(data.usdPrice);
          usdPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), usdPrice));
        }
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (arsPrices.length > 0)
          HistoricalRateData(
            title: "\$ Pesos",
            leftSymbol: "\$",
            maxValue: arsPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: arsPrices,
              isCurved: false,
              colors: _kTabColorGradient1,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient1.first.withAlpha(20)],
              ),
              barWidth: 2,
            ),
          ),
        if (arsPricesWithTaxes.length > 0)
          HistoricalRateData(
            title: "\$ Pesos + Imp.",
            leftSymbol: "\$",
            maxValue: arsPricesWithTaxes.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: arsPricesWithTaxes,
              isCurved: false,
              colors: _kTabColorGradient2,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient2.first.withAlpha(20)],
              ),
              barWidth: 2,
            ),
          ),
        if (usdPrices.length > 0)
          HistoricalRateData(
            title: "US\$ Dólares",
            leftSymbol: "US\$",
            maxValue: usdPrices.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: usdPrices,
              isCurved: false,
              colors: _kTabColorGradient3,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient3.first.withAlpha(20)],
              ),
              barWidth: 2,
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
    String unit;

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic> jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        MetalResponse data = MetalResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.value.isNumeric()) {
          double value = double.tryParse(data.value);
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
              colors: _kTabColorGradient1,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient1.first.withAlpha(20)],
              ),
              barWidth: 2,
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
    String symbol;

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic> jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        BcraResponse data = BcraResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.value.isNumeric()) {
          double value = double.tryParse(data.value);
          values.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), value));
        }
        if (symbol == null) symbol = data.currency;
      }
    }

    return HistoricalChartData(
      ratesData: [
        if (values.length > 0)
          HistoricalRateData(
            title: symbol,
            leftSymbol: symbol,
            maxValue: values.map((spot) => spot.y).reduce(max),
            tooltipTextStyle: _kTooltipTextStyle,
            lineChartBarData: LineChartBarData(
              spots: values,
              isCurved: false,
              colors: _kTabColorGradient1,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient1.first.withAlpha(20)],
              ),
              barWidth: 2,
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
      Map<dynamic, dynamic> jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        CountryRiskResponse data = CountryRiskResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.value.isNumeric()) {
          double value = double.tryParse(data.value);
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
              colors: _kTabColorGradient1,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient1.first.withAlpha(20)],
              ),
              barWidth: 2,
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
      Map<dynamic, dynamic> jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        VenezuelaResponse data = VenezuelaResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.bankPrice.isNumeric()) {
          double bankPrice = double.tryParse(data.bankPrice);
          bankPrices.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), bankPrice));
        }
        if (data.blackMarketPrice.isNumeric()) {
          double blackMarketPrice = double.tryParse(data.blackMarketPrice);
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
              colors: _kTabColorGradient1,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient1.first.withAlpha(20)],
              ),
              barWidth: 2,
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
              colors: _kTabColorGradient2,
              belowBarData: BarAreaData(
                show: true,
                colors: [_kTabColorGradient2.first.withAlpha(20)],
              ),
              barWidth: 2,
            ),
          ),
      ],
    );
  }
}

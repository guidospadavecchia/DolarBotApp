import 'dart:convert';
import 'dart:math';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:dolarbot_app/widgets/historical_chart/factory/historical_chart_data.dart';
import 'package:dolarbot_app/util/extensions/string_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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

    double maxValue =
        buyPrices.length > 0 || sellPrices.length > 0 || sellPricesWithTaxes.length > 0
            ? [
                if (buyPrices.length > 0) buyPrices.map((spot) => spot.y).reduce(max),
                if (sellPrices.length > 0) sellPrices.map((spot) => spot.y).reduce(max),
                if (sellPricesWithTaxes.length > 0)
                  sellPricesWithTaxes.map((spot) => spot.y).reduce(max),
              ].reduce(max)
            : 1;

    return HistoricalChartData(
      leftSymbol: "\$",
      maxValue: maxValue,
      tooltipTextStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      lineChartsData: [
        if (buyPrices.length > 0)
          LineChartBarData(
            spots: buyPrices,
            isCurved: false,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.green,
              Colors.greenAccent,
            ],
            // belowBarData: BarAreaData(
            //   show: true,
            //   colors: [
            //     Colors.blue.withAlpha(70),
            //     Colors.lightBlue.withAlpha(70),
            //     Colors.green.withAlpha(70),
            //     Colors.greenAccent.withAlpha(70),
            //   ],
            // ),
            barWidth: 1,
          ),
        if (sellPrices.length > 0)
          LineChartBarData(
            spots: sellPrices,
            isCurved: false,
            colors: [
              Colors.orange,
              Colors.orangeAccent,
              Colors.red,
              Colors.redAccent,
            ],
            barWidth: 1,
          ),
        if (sellPricesWithTaxes.length > 0)
          LineChartBarData(
            spots: sellPricesWithTaxes,
            isCurved: false,
            colors: [
              Colors.purple,
              Colors.purpleAccent,
              Colors.pink,
              Colors.pinkAccent,
            ],
            barWidth: 1,
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
      }
    }

    double maxValue = arsPrices.length > 0 || arsPricesWithTaxes.length > 0
        ? [
            if (arsPrices.length > 0) arsPrices.map((spot) => spot.y).reduce(max),
            if (arsPricesWithTaxes.length > 0) arsPricesWithTaxes.map((spot) => spot.y).reduce(max),
          ].reduce(max)
        : 1;

    return HistoricalChartData(
      leftSymbol: "\$",
      maxValue: maxValue,
      tooltipTextStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      lineChartsData: [
        if (arsPrices.length > 0)
          LineChartBarData(
            spots: arsPrices,
            isCurved: false,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.green,
              Colors.greenAccent,
            ],
            barWidth: 1,
          ),
        if (arsPricesWithTaxes.length > 0)
          LineChartBarData(
            spots: arsPricesWithTaxes,
            isCurved: false,
            colors: [
              Colors.orange,
              Colors.orangeAccent,
              Colors.red,
              Colors.redAccent,
            ],
            barWidth: 1,
          ),
      ],
    );
  }
}

class _Metal implements BuildHistoricalChartData {
  @override
  HistoricalChartData fromHistoricalRates(List<HistoricalRate> historicalRates) {
    List<FlSpot> values = [];

    for (HistoricalRate historicalRate in historicalRates) {
      Map<dynamic, dynamic> jsonMap = json.decode(historicalRate.json);
      if (jsonMap != null) {
        MetalResponse data = MetalResponse(jsonMap);
        DateTime date = DateTime.parse(historicalRate.timestamp.replaceAll('/', '-'));
        if (data.value.isNumeric()) {
          double value = double.tryParse(data.value);
          values.add(FlSpot(date.millisecondsSinceEpoch.toDouble(), value));
        }
      }
    }

    double maxValue = values.length > 0 ? values.map((spot) => spot.y).reduce(max) : 1;

    return HistoricalChartData(
      leftSymbol: 'US\$',
      maxValue: maxValue,
      tooltipTextStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      lineChartsData: [
        if (values.length > 0)
          LineChartBarData(
            spots: values,
            isCurved: false,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.green,
              Colors.greenAccent,
            ],
            barWidth: 1,
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

    double maxValue = values.length > 0 ? values.map((spot) => spot.y).reduce(max) : 1;

    return HistoricalChartData(
      leftSymbol: symbol,
      maxValue: maxValue,
      tooltipTextStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      lineChartsData: [
        if (values.length > 0)
          LineChartBarData(
            spots: values,
            isCurved: false,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.green,
              Colors.greenAccent,
            ],
            barWidth: 1,
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

    double maxValue = values.length > 0 ? values.map((spot) => spot.y).reduce(max) : 1;

    return HistoricalChartData(
      rightSymbol: "puntos",
      maxValue: maxValue,
      isInteger: true,
      tooltipTextStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      lineChartsData: [
        if (values.length > 0)
          LineChartBarData(
            spots: values,
            isCurved: false,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.green,
              Colors.greenAccent,
            ],
            barWidth: 1,
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

    double maxValue = bankPrices.length > 0 || blackMarketPrices.length > 0
        ? [
            if (bankPrices.length > 0) bankPrices.map((spot) => spot.y).reduce(max),
            if (blackMarketPrices.length > 0) blackMarketPrices.map((spot) => spot.y).reduce(max),
          ].reduce(max)
        : 1;

    return HistoricalChartData(
      leftSymbol: "Bs.",
      maxValue: maxValue,
      tooltipTextStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      lineChartsData: [
        if (bankPrices.length > 0)
          LineChartBarData(
            spots: bankPrices,
            isCurved: false,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.green,
              Colors.greenAccent,
            ],
            barWidth: 1,
          ),
        if (blackMarketPrices.length > 0)
          LineChartBarData(
            spots: blackMarketPrices,
            isCurved: false,
            colors: [
              Colors.orange,
              Colors.orangeAccent,
              Colors.red,
              Colors.redAccent,
            ],
            barWidth: 1,
          ),
      ],
    );
  }
}

import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate.dart';
import 'package:flutter/material.dart';

class BcraInfoScreen extends StatelessWidget {
  final BcraEndpoints bcraEndpoint;

  const BcraInfoScreen({
    Key key,
    @required this.bcraEndpoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: _getChildScreen(),
      ),
    );
  }

  Widget _getChildScreen() {
    switch (bcraEndpoint) {
      case BcraEndpoints.riesgoPais:
        return FutureScreenDelegate<CountryRiskResponse>(
          response: API.getCountryRisk(),
          screen: (data) {
            return CurrencyInfo(
              title: 'VALOR',
              value: data.value,
              hideDecimals: true,
            );
          },
        );
      case BcraEndpoints.reservas:
        return FutureScreenDelegate<BcraResponse>(
          response: API.getBcraReserves(),
          screen: (data) {
            return CurrencyInfo(
              title: "DÓLARES ESTADOUNIDENSES",
              symbol: 'US\$',
              value: data.value,
            );
          },
        );
      case BcraEndpoints.circulante:
        return FutureScreenDelegate<BcraResponse>(
          response: API.getCirculatingCurrency(),
          screen: (data) {
            return CurrencyInfo(
              title: "PESOS ARGENTINOS",
              symbol: '\$',
              value: data.value,
            );
          },
        );
      default:
        throw ('$bcraEndpoint not implemented.');
    }
  }
}

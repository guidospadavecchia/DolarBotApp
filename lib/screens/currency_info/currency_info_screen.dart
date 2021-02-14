import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate.dart';
import 'package:flutter/material.dart';

class CurrencyInfoScreen<T extends GenericCurrencyResponse>
    extends StatelessWidget {
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  const CurrencyInfoScreen({
    Key key,
    this.dollarEndpoint,
    this.euroEndpoint,
    this.realEndpoint,
  })  : assert((dollarEndpoint != null &&
                euroEndpoint == null &&
                realEndpoint == null) ||
            (euroEndpoint != null &&
                dollarEndpoint == null &&
                realEndpoint == null) ||
            (realEndpoint != null &&
                dollarEndpoint == null &&
                euroEndpoint == null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<T>(
          response: _getResponse<T>(),
          screen: (data) {
            return CurrencyInfoContainer(
              items: [
                CurrencyInfo(
                  title: "COMPRA",
                  symbol: '\$',
                  value: data.buyPrice,
                ),
                CurrencyInfo(
                  title: "VENTA",
                  symbol: '\$',
                  value: data.sellPrice,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _getResponse<T extends GenericCurrencyResponse>() {
    if (dollarEndpoint != null) {
      return API.getDollarRate(dollarEndpoint);
    } else if (euroEndpoint != null) {
      return API.getEuroRate(euroEndpoint);
    } else if (realEndpoint != null) {
      return API.getRealRate(realEndpoint);
    }
  }
}

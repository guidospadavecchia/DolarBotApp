import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
import 'package:flutter/material.dart';

class CurrencyInfoScreen<T extends GenericCurrencyResponse>
    extends StatefulWidget {
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  const CurrencyInfoScreen(
      {Key key, this.dollarEndpoint, this.euroEndpoint, this.realEndpoint})
      : assert((dollarEndpoint != null &&
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
  CurrencyInfoScreenState<T> createState() => CurrencyInfoScreenState<T>();
}

class CurrencyInfoScreenState<T extends GenericCurrencyResponse>
    extends State<CurrencyInfoScreen<T>> {
  bool _forceRefresh = false;

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

  refresh() async {
    setState(() {
      _forceRefresh = true;
    });
  }

  _getResponse<T extends GenericCurrencyResponse>() {
    if (widget.dollarEndpoint != null) {
      return API.getDollarRate(widget.dollarEndpoint,
          forceRefresh: _forceRefresh);
    } else if (widget.euroEndpoint != null) {
      return API.getEuroRate(widget.euroEndpoint, forceRefresh: _forceRefresh);
    } else if (widget.realEndpoint != null) {
      return API.getRealRate(widget.realEndpoint, forceRefresh: _forceRefresh);
    }
  }
}

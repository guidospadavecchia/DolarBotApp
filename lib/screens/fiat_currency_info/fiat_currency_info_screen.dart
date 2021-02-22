import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/currency_info/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class FiatCurrencyInfoScreen<T extends GenericCurrencyResponse>
    extends StatefulWidget {
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  const FiatCurrencyInfoScreen(
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
  FiatCurrencyInfoScreenState<T> createState() =>
      FiatCurrencyInfoScreenState<T>();
}

class FiatCurrencyInfoScreenState<T extends GenericCurrencyResponse>
    extends State<FiatCurrencyInfoScreen<T>> implements IShareable<T> {
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
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => setActiveData(data, getShareInfo(data)));
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

  void setActiveData(ApiResponse data, String shareText) {
    ActiveScreenData activeScreenData =
        Provider.of<ActiveScreenData>(context, listen: false);
    activeScreenData.setActiveData(data, shareText);
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

  @override
  String getShareInfo(T data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';
    if (data != null) {
      final buyPrice = Util.isNumeric(data.buyPrice)
          ? numberFormat.format(double.parse(data.buyPrice))
          : 'N/A';
      final sellPrice = Util.isNumeric(data.sellPrice)
          ? numberFormat.format(double.parse(data.sellPrice))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText =
          'Compra:\t\$ $buyPrice\nVenta:\t\$ $sellPrice\nHora:\t$formattedTime';
    }

    return shareText;
  }
}

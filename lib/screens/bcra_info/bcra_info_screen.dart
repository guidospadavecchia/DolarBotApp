import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BcraInfoScreen extends StatefulWidget {
  final BcraEndpoints bcraEndpoint;

  const BcraInfoScreen({
    Key key,
    @required this.bcraEndpoint,
  }) : super(key: key);

  @override
  BcraInfoScreenState createState() => BcraInfoScreenState();
}

class BcraInfoScreenState extends State<BcraInfoScreen>
    implements IShareable<BcraResponse> {
  bool _forceRefresh = false;

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
    switch (widget.bcraEndpoint) {
      case BcraEndpoints.riesgoPais:
        return FutureScreenDelegate<CountryRiskResponse>(
          response: API.getCountryRisk(forceRefresh: _forceRefresh),
          screen: (data) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setShareInfoCountryRisk(data));
            return CurrencyInfo(
              title: 'VALOR',
              value: data.value,
              hideDecimals: true,
            );
          },
        );
      case BcraEndpoints.reservas:
        return FutureScreenDelegate<BcraResponse>(
          response: API.getBcraReserves(forceRefresh: _forceRefresh),
          screen: (data) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setShareInfo(data));
            return CurrencyInfo(
              title: "DÓLARES ESTADOUNIDENSES",
              symbol: 'US\$',
              value: data.value,
            );
          },
        );
      case BcraEndpoints.circulante:
        return FutureScreenDelegate<BcraResponse>(
          response: API.getCirculatingCurrency(forceRefresh: _forceRefresh),
          screen: (data) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setShareInfo(data));
            return CurrencyInfo(
              title: "PESOS ARGENTINOS",
              symbol: '\$',
              value: data.value,
            );
          },
        );
      default:
        throw ('${widget.bcraEndpoint} not implemented.');
    }
  }

  refresh() async {
    setState(() {
      _forceRefresh = true;
    });
  }

  @override
  void setShareInfo(BcraResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    ActiveScreenData activeScreenData =
        Provider.of<ActiveScreenData>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###", currencyFormat);

    if (data != null) {
      final value = Util.isNumeric(data.value)
          ? numberFormat.format(int.parse(data.value))
          : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      activeScreenData.setShareData('$symbol $value\nHora: $formattedTime.');
    }
  }

  void setShareInfoCountryRisk(CountryRiskResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    ActiveScreenData activeScreenData =
        Provider.of<ActiveScreenData>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###", currencyFormat);

    if (data != null) {
      final value = Util.isNumeric(data.value.split('.')[0])
          ? numberFormat.format(int.parse(data.value.split('.')[0]))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      activeScreenData.setShareData('$value puntos\nHora: $formattedTime');
    }
  }
}

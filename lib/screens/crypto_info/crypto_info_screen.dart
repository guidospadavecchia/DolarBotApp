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

class CryptoInfoScreen extends StatefulWidget {
  final CryptoEndpoints cryptoEndpoint;

  const CryptoInfoScreen({
    Key key,
    @required this.cryptoEndpoint,
  }) : super(key: key);

  @override
  CryptoInfoScreenState createState() => CryptoInfoScreenState();
}

class CryptoInfoScreenState extends State<CryptoInfoScreen>
    implements IShareable<CryptoResponse> {
  bool _forceRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<CryptoResponse>(
          response: API.getCryptoRate(widget.cryptoEndpoint,
              forceRefresh: _forceRefresh),
          screen: (data) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => setShareInfo(data));
            return CurrencyInfoContainer(
              items: [
                CurrencyInfo(
                  title: "PESOS ARGENTINOS",
                  symbol: '\$',
                  value: data.arsPrice,
                ),
                CurrencyInfo(
                  title: "DÓLARES ESTADOUNIDENSES",
                  symbol: 'US\$',
                  value: data.usdPrice,
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

  @override
  void setShareInfo(CryptoResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    ActiveScreenData activeScreenData =
        Provider.of<ActiveScreenData>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);

    if (data != null) {
      final arsPrice = Util.isNumeric(data.arsPrice)
          ? numberFormat.format(double.parse(data.arsPrice))
          : 'N/A';
      final usdPrice = Util.isNumeric(data.usdPrice)
          ? numberFormat.format(double.parse(data.usdPrice))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      activeScreenData
          .setShareData('US\$ $usdPrice\n\$ $arsPrice\nHora: $formattedTime');
    }
  }
}

import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/currency_info/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class VenezuelaInfoScreen extends StatefulWidget {
  final VenezuelaEndpoints vzlaEndpoint;

  const VenezuelaInfoScreen({
    Key key,
    @required this.vzlaEndpoint,
  }) : super(key: key);

  @override
  VenezuelaInfoScreenState createState() => VenezuelaInfoScreenState();
}

class VenezuelaInfoScreenState extends State<VenezuelaInfoScreen>
    implements IShareable<VenezuelaResponse> {
  bool _forceRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<VenezuelaResponse>(
          response:
              API.getVzlaRate(widget.vzlaEndpoint, forceRefresh: _forceRefresh),
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => setActiveData(data, getShareInfo(data)));
            return CurrencyInfoContainer(
              items: [
                CurrencyInfo(
                  title: 'PROMEDIO BANCOS',
                  symbol: 'Bs.',
                  value: data.bankPrice,
                ),
                CurrencyInfo(
                  title: "PARALELO",
                  symbol: 'Bs.',
                  value: data.blackMarketPrice,
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

  @override
  String getShareInfo(VenezuelaResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';

    if (data != null) {
      final blackMarketValue = Util.isNumeric(data.blackMarketPrice)
          ? numberFormat.format(double.parse(data.blackMarketPrice))
          : 'N/A';
      final banksValue = Util.isNumeric(data.bankPrice)
          ? numberFormat.format(double.parse(data.bankPrice))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText =
          'Bancos:\tBs. $banksValue\nParalelo:\tBs. $blackMarketValue\nHora:\t$formattedTime';
    }

    return shareText;
  }
}

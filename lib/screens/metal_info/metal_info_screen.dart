import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/currency_info/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MetalInfoScreen extends StatefulWidget {
  final MetalEndpoints metalEndpoint;

  const MetalInfoScreen({
    Key key,
    @required this.metalEndpoint,
  }) : super(key: key);

  @override
  MetalInfoScreenState createState() => MetalInfoScreenState();
}

class MetalInfoScreenState extends State<MetalInfoScreen>
    implements IShareable<MetalResponse> {
  bool _forceRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<MetalResponse>(
          response: API.getMetalRate(widget.metalEndpoint,
              forceRefresh: _forceRefresh),
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => setActiveData(data, getShareInfo(data)));
            return CurrencyInfo(
              title: '/ ${data.unit}',
              symbol: data.currency == 'USD' ? 'US\$' : '\$',
              value: data.value,
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
  String getShareInfo(MetalResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';

    if (data != null) {
      final value = Util.isNumeric(data.value)
          ? numberFormat.format(double.parse(data.value))
          : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText = '$symbol $value / ${data.unit}\nHora: $formattedTime';
    }

    return shareText;
  }
}

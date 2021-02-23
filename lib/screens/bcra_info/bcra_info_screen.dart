import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';

class BcraInfoScreen extends BaseInfoScreen {
  final String title;
  final BcraEndpoints bcraEndpoint;

  BcraInfoScreen({
    this.title,
    @required this.bcraEndpoint,
  }) : super(title: title);

  @override
  _BcraInfoScreenState createState() => _BcraInfoScreenState(bcraEndpoint);
}

class _BcraInfoScreenState extends BaseInfoScreenState<BcraInfoScreen>
    with BaseScreen
    implements IShareable<BcraResponse> {
  final BcraEndpoints bcraEndpoint;

  _BcraInfoScreenState(this.bcraEndpoint);

  @override
  bool showCalculatorButton() => false;

  @override
  Widget body() {
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
          response: API.getCountryRisk(forceRefresh: shouldForceRefresh),
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setActiveData(data, getShareInfoCountryRisk(data));
            });
            return CurrencyInfo(
              title: 'VALOR',
              value: data.value,
              hideDecimals: true,
            );
          },
        );
      case BcraEndpoints.reservas:
        return FutureScreenDelegate<BcraResponse>(
          response: API.getBcraReserves(forceRefresh: shouldForceRefresh),
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setActiveData(data, getShareInfo(data));
            });
            return CurrencyInfo(
              title: "DÓLARES ESTADOUNIDENSES",
              symbol: 'US\$',
              value: data.value,
            );
          },
        );
      case BcraEndpoints.circulante:
        return FutureScreenDelegate<BcraResponse>(
          response:
              API.getCirculatingCurrency(forceRefresh: shouldForceRefresh),
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setActiveData(data, getShareInfo(data));
            });
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

  @override
  String getShareInfo(BcraResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###", currencyFormat);
    String shareText = '';

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

      shareText = '$symbol $value\nHora: $formattedTime.';
    }

    return shareText;
  }

  String getShareInfoCountryRisk(CountryRiskResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###", currencyFormat);
    String shareText = '';

    if (data != null) {
      final value = Util.isNumeric(data.value.split('.')[0])
          ? numberFormat.format(int.parse(data.value.split('.')[0]))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText = '$value puntos\nHora: $formattedTime';
    }

    return shareText;
  }
}

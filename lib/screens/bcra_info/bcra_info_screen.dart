import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/bcra_card.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/country_risk_card.dart';
import 'package:intl/intl.dart' as intl;

class BcraInfoScreen extends BaseInfoScreen {
  final String title;
  final String bannerTitle;
  final IconData bannerIconData;
  final List<Color> gradiantColors;
  final BcraEndpoints bcraEndpoint;

  BcraInfoScreen({
    this.title,
    this.bannerTitle,
    this.bannerIconData,
    this.gradiantColors,
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: _buildChildScreen(),
    );
  }

  Widget _buildChildScreen() {
    switch (bcraEndpoint) {
      case BcraEndpoints.riesgoPais:
        return FutureScreenDelegate<CountryRiskResponse>(
          response: API.getCountryRisk(forceRefresh: shouldForceRefresh),
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setActiveData(data, getShareInfoCountryRisk(data));
            });
            return Column(
              children: [
                banner(),
                CurrencyInfoContainer(
                  items: [
                    CurrencyInfo(
                      title: 'VALOR',
                      value: data.value,
                      hideDecimals: true,
                    ),
                  ],
                ),
              ],
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
            return Column(
              children: [
                banner(),
                CurrencyInfoContainer(
                  items: [
                    CurrencyInfo(
                      title: "DÓLARES ESTADOUNIDENSES",
                      symbol: 'US\$',
                      value: data.value,
                    ),
                  ],
                ),
              ],
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
            return Column(
              children: [
                banner(),
                CurrencyInfoContainer(
                  items: [
                    CurrencyInfo(
                      title: "PESOS ARGENTINOS",
                      symbol: '\$',
                      value: data.value,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      default:
        throw ('$bcraEndpoint not implemented.');
    }
  }

  @override
  Widget card() {
    return Consumer<ActiveScreenData>(
      builder: (context, activeData, child) {
        ApiResponse data = activeData.getActiveData();

        if (data != null && data is CountryRiskResponse) {
          return CountryRiskCard(
            title: widget.bannerTitle,
            tag: widget.title,
            gradiantColors: widget.gradiantColors,
            iconAsset: widget.bannerIconAsset,
            iconData: widget.bannerIconData,
            data: data,
          );
        }

        if (data != null && data is BcraResponse) {
          String subtitle = bcraEndpoint == BcraEndpoints.circulante
              ? "Dinero en Circulación"
              : "Dólares Estadounidenses";
          String symbol =
              bcraEndpoint == BcraEndpoints.circulante ? "\$" : "US\$";

          return BcraCard(
            data: data,
            title: widget.bannerTitle,
            subtitle: subtitle,
            tag: widget.title,
            symbol: symbol,
            iconData: widget.bannerIconData,
            iconAsset: widget.bannerIconAsset,
            gradiantColors: widget.gradiantColors,
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  @override
  String getShareInfo(BcraResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new intl.NumberFormat("#,###,###", currencyFormat);
    String shareText = '';

    if (data != null) {
      final value = data.value.isNumeric()
          ? numberFormat.format(int.parse(data.value))
          : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = intl.DateFormat(
              DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText = '$symbol $value\nHora: $formattedTime';
    }

    return shareText;
  }

  String getShareInfoCountryRisk(CountryRiskResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new intl.NumberFormat("#,###,###", currencyFormat);
    String shareText = '';

    if (data != null) {
      final value = data.value.split('.')[0].isNumeric()
          ? numberFormat.format(int.parse(data.value.split('.')[0]))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = intl.DateFormat(
              DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText = '$value puntos\nHora: $formattedTime';
    }

    return shareText;
  }
}

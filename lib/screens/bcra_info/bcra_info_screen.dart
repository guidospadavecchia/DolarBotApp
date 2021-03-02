import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:intl/intl.dart';

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
          return CardFavorite(
            showPoweredBy: true,
            height: 150,
            header: CardHeader(
              title: widget.bannerTitle,
              showButtons: false,
            ),
            spaceBetweenHeader: Spacing.medium,
            spaceBetweenItems: Spacing.large,
            direction: Axis.vertical,
            rates: [
              CardValue(
                title: "Valor",
                value: data.value,
                symbol: "\$",
                valueSize: 22,
              ),
            ],
            logo: CardLogo(
              iconData: widget.bannerIconData,
              iconAsset: widget.bannerIconAsset,
              tag: widget.title,
            ),
            lastUpdated: CardLastUpdated(timestamp: data.timestamp),
            gradiantColors: widget.gradiantColors,
          );
        }

        if (data != null && data is BcraResponse) {
          return CardFavorite(
            showPoweredBy: true,
            height: 150,
            header: CardHeader(
              title: widget.bannerTitle,
              showButtons: false,
            ),
            spaceBetweenHeader: Spacing.medium,
            spaceBetweenItems: Spacing.large,
            direction: Axis.vertical,
            rates: [
              if (bcraEndpoint == BcraEndpoints.circulante)
                CardValue(
                  title: "Dinero en Circulación",
                  value: data.value,
                  symbol: "\$",
                  valueSize: 22,
                ),
              if (bcraEndpoint == BcraEndpoints.reservas)
                CardValue(
                  title: "Dólares Estadounidenses",
                  value: data.value,
                  symbol: "US\$",
                  valueSize: 22,
                ),
            ],
            logo: CardLogo(
              iconData: widget.bannerIconData,
              iconAsset: widget.bannerIconAsset,
              tag: widget.title,
            ),
            lastUpdated: CardLastUpdated(timestamp: data.timestamp),
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

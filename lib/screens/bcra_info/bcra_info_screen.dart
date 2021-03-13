import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:intl/intl.dart' as intl;

class BcraInfoScreen extends BaseInfoScreen {
  final String title;
  final CardData cardData;

  BcraInfoScreen({
    @required this.title,
    @required this.cardData,
  }) : super(cardData: cardData, title: title);

  BcraEndpoints getEndpoint() {
    return BcraEndpoints.values.firstWhere((e) => e.value == cardData.endpoint);
  }

  @override
  _BcraInfoScreenState createState() => _BcraInfoScreenState(getEndpoint());
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
        return FutureScreenDelegate(
          response: API.getCountryRisk(forceRefresh: shouldForceRefresh),
          onLoading: onLoading,
          onFailedLoad: onErrorLoad,
          onSuccessfulLoad: onSuccessfulLoad,
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setActiveData(data, "${widget.title} - ${widget.cardData.title}",
                  getShareInfoCountryRisk(data));
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
        return FutureScreenDelegate(
          response: API.getBcraReserves(forceRefresh: shouldForceRefresh),
          onLoading: onLoading,
          onFailedLoad: onErrorLoad,
          onSuccessfulLoad: onSuccessfulLoad,
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setActiveData(data, "${widget.title} - ${widget.cardData.title}", getShareInfo(data));
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
        return FutureScreenDelegate(
          response: API.getCirculatingCurrency(forceRefresh: shouldForceRefresh),
          onLoading: onLoading,
          onFailedLoad: onErrorLoad,
          onSuccessfulLoad: onSuccessfulLoad,
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setActiveData(data, "${widget.title} - ${widget.cardData.title}", getShareInfo(data));
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

        if (data != null && (data is CountryRiskResponse || data is BcraResponse)) {
          return BuildCard(data).fromCardData(context, widget.cardData);
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
      final value = data.value.isNumeric() ? numberFormat.format(int.parse(data.value)) : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          intl.DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
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
      String formattedTime =
          intl.DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      shareText = '$value puntos\nHora: $formattedTime';
    }

    return shareText;
  }

  @override
  FavoriteRate createFavorite() {
    String subtitle;
    String symbol;

    if (bcraEndpoint == BcraEndpoints.circulante) {
      subtitle = "Pesos Argentinos";
      symbol = "\$";
    }
    if (bcraEndpoint == BcraEndpoints.reservas) {
      subtitle = "Dólares Estadounidenses";
      symbol = "US\$";
    }

    return FavoriteRate(
        endpoint: widget.cardData.endpoint,
        cardResponseType: widget.cardData.response.toString(),
        cardTitle: widget.cardData.title,
        cardSubtitle: subtitle,
        cardSymbol: symbol,
        cardTag: widget.title,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: widget.cardData.iconAsset);
  }

  @override
  Type getResponseType() {
    return bcraEndpoint == BcraEndpoints.riesgoPais ? CountryRiskResponse : BcraResponse;
  }
}

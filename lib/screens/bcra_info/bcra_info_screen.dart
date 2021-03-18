import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/screens/common/error_screen.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
import 'package:intl/intl.dart';

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

class _BcraInfoScreenState extends BaseInfoScreenState<BcraInfoScreen> with BaseScreen {
  final BcraEndpoints bcraEndpoint;

  _BcraInfoScreenState(this.bcraEndpoint);

  dynamic data;

  @override
  bool showCalculatorButton() => false;

  @override
  FabOptionCalculatorDialog getCalculatorWidget() => null;

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      loadData();
    }
  }

  @override
  Widget body() {
    if (errorOnLoad) {
      return ErrorScreen();
    }
    if (!isDataLoaded) {
      return LoadingScreen();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: _buildChildScreen(),
    );
  }

  Widget _buildChildScreen() {
    switch (bcraEndpoint) {
      case BcraEndpoints.riesgoPais:
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
      case BcraEndpoints.reservas:
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
      case BcraEndpoints.circulante:
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
      default:
        throw ('$bcraEndpoint not implemented.');
    }
  }

  @override
  Future loadData() async {
    API.getData(bcraEndpoint.value, (json) {
      if (bcraEndpoint == BcraEndpoints.riesgoPais) {
        return CountryRiskResponse(json);
      }
      return BcraResponse(json);
    }, shouldForceRefresh).then((value) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => setState(() {
          data = value;
          timestamp = data.timestamp;
          isDataLoaded = true;
          errorOnLoad = value == null;
          showRefreshButton = true;
          if (!errorOnLoad) showSimpleFabMenu();
        }),
      );
    });
  }

  @override
  Widget card() {
    if (data != null && (data is CountryRiskResponse || data is BcraResponse)) {
      Settings settings = Provider.of<Settings>(context, listen: false);
      return BuildCard(data).fromCardData(context, widget.cardData, settings);
    }

    return SizedBox.shrink();
  }

  @override
  String getShareTitle() {
    if (bcraEndpoint == BcraEndpoints.riesgoPais) return widget.cardData.title.toUpperCase();
    if (bcraEndpoint == BcraEndpoints.reservas) return "RESERVAS BCRA";
    if (bcraEndpoint == BcraEndpoints.circulante) return "DINERO EN CIRCULACIÓN";
    return '';
  }

  @override
  String getShareText() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###", currencyFormat);

    if (data != null) {
      String value;
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);
      if (data is CountryRiskResponse) {
        value = data.value;
        value = value.split('.')[0].toString().isNumeric()
            ? numberFormat.format(int.parse(data.value.split('.')[0]))
            : 'N/A';
        return '$value puntos\nHora: $formattedTime';
      }
      if (data is BcraResponse) {
        value = data.value;
        final symbol = data.currency == 'USD' ? 'US\$' : '\$';
        value = value.isNumeric() ? numberFormat.format(int.parse(data.value)) : 'N/A';
        return '$symbol $value\nHora: $formattedTime';
      }
    }

    return '';
  }

  @override
  FavoriteRate createFavorite() {
    return FavoriteRate(
        endpoint: widget.cardData.endpoint,
        cardResponseType: widget.cardData.response.toString(),
        cardTitle: widget.cardData.title,
        cardSubtitle: widget.cardData.subtitle,
        cardSymbol: widget.cardData.symbol,
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

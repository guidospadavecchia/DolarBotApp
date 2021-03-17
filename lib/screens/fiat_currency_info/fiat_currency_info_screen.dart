import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/fiat_currency_card.dart';
import 'package:dolarbot_app/screens/common/error_screen.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
import 'package:intl/intl.dart';

class FiatCurrencyInfoScreen<T extends GenericCurrencyResponse> extends BaseInfoScreen {
  final String title;
  final CardData cardData;
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  FiatCurrencyInfoScreen(
      {Key key,
      this.title,
      this.cardData,
      this.dollarEndpoint,
      this.euroEndpoint,
      this.realEndpoint})
      : assert((dollarEndpoint != null && euroEndpoint == null && realEndpoint == null) ||
            (euroEndpoint != null && dollarEndpoint == null && realEndpoint == null) ||
            (realEndpoint != null && dollarEndpoint == null && euroEndpoint == null)),
        super(cardData: cardData, title: title);

  @override
  _FiatCurrencyInfoScreenState<T> createState() =>
      _FiatCurrencyInfoScreenState<T>(dollarEndpoint, euroEndpoint, realEndpoint);
}

class _FiatCurrencyInfoScreenState<T extends GenericCurrencyResponse>
    extends BaseInfoScreenState<FiatCurrencyInfoScreen<T>> with BaseScreen {
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  T data;

  _FiatCurrencyInfoScreenState(
    this.dollarEndpoint,
    this.euroEndpoint,
    this.realEndpoint,
  );

  @override
  Color setColorAppbar() => ThemeManager.getForegroundColor();

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      loadData();
    }
  }

  @override
  Future loadData() async {
    _getResponse<GenericCurrencyResponse>().then((value) {
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
      child: Column(
        children: [
          banner(),
          CurrencyInfoContainer(
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
              if (data.sellPriceWithTaxes != null)
                CurrencyInfo(
                  title: "VENTA + IMPUESTOS",
                  symbol: '\$',
                  value: data.sellPriceWithTaxes,
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget card() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    return BuildCard(data).fromCardData(context, widget.cardData, settings);
  }

  @override
  String getShareText() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    NumberFormat numberFormat = settings.getNumberFormat().item1;

    String shareText = '';
    if (data != null) {
      final buyPrice =
          data.buyPrice.isNumeric() ? numberFormat.format(double.parse(data.buyPrice)) : 'N/A';
      final sellPrice =
          data.sellPrice.isNumeric() ? numberFormat.format(double.parse(data.sellPrice)) : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      if (data.sellPriceWithTaxes != null) {
        final sellPriceWithTaxes = data.sellPriceWithTaxes.isNumeric()
            ? numberFormat.format(double.parse(data.sellPriceWithTaxes))
            : 'N/A';
        shareText =
            'Compra: \t\t\$ $buyPrice\nVenta: \t\t\$ $sellPrice\nVenta Ahorro: \t\$ $sellPriceWithTaxes\nHora: \t\t$formattedTime';
      } else {
        shareText = 'Compra: \t\t\$ $buyPrice\nVenta: \t\t\$ $sellPrice\nHora: \t\t$formattedTime';
      }
    }

    return shareText;
  }

  @override
  FabOptionCalculatorDialog getCalculatorWidget() {
    String _currencyFormat = Provider.of<Settings>(context, listen: false).getCurrencyFormat();
    String decimalSeparator = _currencyFormat == "es_AR" ? "," : ".";
    String thousandSeparator = _currencyFormat == "es_AR" ? "." : ",";
    return FabOptionCalculatorDialog(
      calculator: FiatCurrencyCalculator(
        buyValue: double.tryParse(data?.buyPrice ?? ''),
        sellValue: double.tryParse(data?.sellPrice ?? ''),
        sellValueWithTaxes: double.tryParse(data?.sellPriceWithTaxes ?? ''),
        symbol: Util.getFiatCurrencySymbol(data),
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: FiatCurrencyCalculatorReversed(
        sellValue: data?.sellPriceWithTaxes == null ? double.tryParse(data?.sellPrice ?? '') : null,
        sellValueWithTaxes: double.tryParse(data?.sellPriceWithTaxes ?? ''),
        symbol: Util.getFiatCurrencySymbol(data),
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
    );
  }

  @override
  FavoriteRate createFavorite() {
    return FavoriteRate(
        endpoint: widget.cardData.endpoint,
        cardResponseType: widget.cardData.response.toString(),
        cardTitle: widget.cardData.title,
        cardSubtitle: null,
        cardSymbol: null,
        cardTag: widget.title,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: widget.cardData.iconAsset);
  }

  Type getResponseType() {
    Type responseType;
    if (dollarEndpoint != null) responseType = DollarResponse;
    if (euroEndpoint != null) responseType = EuroResponse;
    if (realEndpoint != null) responseType = RealResponse;
    return responseType;
  }

  Future<dynamic> _getResponse<T extends GenericCurrencyResponse>() async {
    if (dollarEndpoint != null) {
      return await API.getDollarRate(dollarEndpoint, forceRefresh: shouldForceRefresh);
    } else if (euroEndpoint != null) {
      return await API.getEuroRate(euroEndpoint, forceRefresh: shouldForceRefresh);
    } else if (realEndpoint != null) {
      return await API.getRealRate(realEndpoint, forceRefresh: shouldForceRefresh);
    }
  }
}

import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/widgets/historical_chart/historical_rate_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/fiat_currency_card.dart';
import 'package:dolarbot_app/screens/common/error_screen.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
import 'package:intl/intl.dart';

class FiatCurrencyInfoScreen<T extends GenericCurrencyResponse> extends BaseInfoScreen {
  final CardData cardData;

  FiatCurrencyInfoScreen({
    Key key,
    this.cardData,
  }) : super(cardData: cardData);

  @override
  _FiatCurrencyInfoScreenState<T> createState() => _FiatCurrencyInfoScreenState<T>();
}

class _FiatCurrencyInfoScreenState<T extends GenericCurrencyResponse>
    extends BaseInfoScreenState<FiatCurrencyInfoScreen<T>> with BaseScreen {
  T data;

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      loadData();
    }
  }

  @override
  Future loadData() async {
    _getResponse().then((value) {
      HistoricalRateManager.saveRate(
        widget.cardData.endpoint,
        widget.cardData.responseType.toString(),
        value.timestamp,
        value,
      );
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
      child: CurrencyInfoContainer(
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
    );
  }

  @override
  Widget card() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    return BuildCard(data).fromCardData(context, widget.cardData, settings);
  }

  @override
  String getShareTitle() {
    return "${widget.cardData.title} ${widget.cardData.bannerTitle.toUpperCase()}";
  }

  @override
  String getShareText() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    NumberFormat numberFormat = settings.getNumberFormat();

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
    NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
    return FabOptionCalculatorDialog(
      calculator: FiatCurrencyCalculator(
        buyValue: double.tryParse(data?.buyPrice ?? ''),
        sellValue: double.tryParse(data?.sellPrice ?? ''),
        sellValueWithTaxes: double.tryParse(data?.sellPriceWithTaxes ?? ''),
        symbol: Util.getFiatCurrencySymbol(data),
        numberFormat: numberFormat,
      ),
      calculatorReversed: FiatCurrencyCalculatorReversed(
        sellValue: data?.sellPriceWithTaxes == null ? double.tryParse(data?.sellPrice ?? '') : null,
        sellValueWithTaxes: double.tryParse(data?.sellPriceWithTaxes ?? ''),
        symbol: Util.getFiatCurrencySymbol(data),
        numberFormat: numberFormat,
      ),
    );
  }

  @override
  FavoriteRate createFavorite() {
    return FavoriteRate(
        endpoint: widget.cardData.endpoint,
        cardResponseType: widget.cardData.responseType.toString(),
        cardTitle: widget.cardData.bannerTitle,
        cardSubtitle: null,
        cardSymbol: null,
        cardTag: widget.cardData.tag,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: widget.cardData.iconAsset);
  }

  Future<GenericCurrencyResponse> _getResponse() async {
    switch (widget.cardData.responseType) {
      case DollarResponse:
        DollarEndpoints endpoint =
            DollarEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);
        return await API.getDollarRate(endpoint, forceRefresh: shouldForceRefresh);
        break;
      case EuroResponse:
        EuroEndpoints endpoint =
            EuroEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);
        return await API.getEuroRate(endpoint, forceRefresh: shouldForceRefresh);

      case RealResponse:
        RealEndpoints endpoint =
            RealEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);
        return await API.getRealRate(endpoint, forceRefresh: shouldForceRefresh);
      default:
        return throw 'Error endpoint';
    }
  }
}

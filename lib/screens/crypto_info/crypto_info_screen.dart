import 'package:dolarbot_app/widgets/historical_chart/historical_rate_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:dolarbot_app/screens/common/error_screen.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
import 'package:intl/intl.dart';

class CryptoInfoScreen extends BaseInfoScreen {
  final CardData cardData;

  CryptoInfoScreen({
    @required this.cardData,
  }) : super(cardData: cardData);

  @override
  _CryptoInfoScreenState createState() => _CryptoInfoScreenState();
}

class _CryptoInfoScreenState extends BaseInfoScreenState<CryptoInfoScreen> with BaseScreen {
  CryptoResponse data;

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
      child: CurrencyInfoContainer(
        items: [
          CurrencyInfo(
            title: "PESOS ARGENTINOS",
            symbol: '\$',
            value: data.arsPrice,
          ),
          CurrencyInfo(
            title: "PESOS ARGENTINOS + IMPUESTOS",
            symbol: '\$',
            value: data.arsPriceWithTaxes,
          ),
          CurrencyInfo(
            title: "DÓLARES ESTADOUNIDENSES",
            symbol: 'US\$',
            value: data.usdPrice,
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
  Future loadData() async {
    CryptoEndpoints cryptoEndpoint =
        CryptoEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);

    API.getCryptoRate(cryptoEndpoint, forceRefresh: shouldForceRefresh).then(
      (value) {
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
      },
    );
  }

  @override
  String getShareTitle() {
    return widget.cardData.bannerTitle.toUpperCase();
  }

  @override
  String getShareText() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    NumberFormat numberFormat = settings.getNumberFormat();

    String shareText = '';

    if (data != null) {
      final arsPrice =
          data.arsPrice.isNumeric() ? numberFormat.format(double.parse(data.arsPrice)) : 'N/A';
      final arsPriceWithTaxes = data.arsPriceWithTaxes.isNumeric()
          ? numberFormat.format(double.parse(data.arsPriceWithTaxes))
          : 'N/A';
      final usdPrice =
          data.usdPrice.isNumeric() ? numberFormat.format(double.parse(data.usdPrice)) : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      shareText =
          'Dólares: \t\tUS\$ $usdPrice\nPesos: \t\t\$ $arsPrice\nPesos + Imp.: \t\$ $arsPriceWithTaxes\nHora: \t\t$formattedTime';
    }

    return shareText;
  }

  @override
  FabOptionCalculatorDialog getCalculatorWidget() {
    NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
    return FabOptionCalculatorDialog(
      calculator: CryptoCalculator(
        arsValue: double.tryParse(data?.arsPrice),
        arsValueWithTaxes: double.tryParse(data?.arsPriceWithTaxes),
        usdValue: double.tryParse(data?.usdPrice),
        cryptoCode: data.code,
        numberFormat: numberFormat,
      ),
      calculatorReversed: CryptoCalculatorReversed(
        usdValue: double.tryParse(data?.usdPrice ?? ''),
        cryptoCode: data.code,
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
}

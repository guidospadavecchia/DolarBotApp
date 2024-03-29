import '../../widgets/historical_chart/historical_rate_manager.dart';
import '../base/base_info_screen.dart';
import '../../widgets/cards/factory/factory_card.dart';
import '../../widgets/cards/templates/base/base_card.dart';
import '../common/error_screen.dart';
import '../common/loading_screen.dart';
import 'package:intl/intl.dart';

class CryptoInfoScreen extends BaseInfoScreen {
  final CardData cardData;

  CryptoInfoScreen({
    required this.cardData,
  }) : super(cardData: cardData);

  @override
  _CryptoInfoScreenState createState() => _CryptoInfoScreenState();
}

class _CryptoInfoScreenState extends BaseInfoScreenState<CryptoInfoScreen> with BaseScreen {
  late CryptoResponse? data;

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

    return addRefreshIndicator(
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: CurrencyInfoContainer(
          items: [
            if (data?.usdPrice != null)
              CurrencyInfo(
                title: "DÓLARES ESTADOUNIDENSES",
                symbol: 'US\$',
                value: data!.usdPrice!,
              ),
            if (data?.arsPrice != null)
              CurrencyInfo(
                title: "PESOS ARGENTINOS",
                symbol: '\$',
                value: data!.arsPrice!,
              ),
            if (data?.arsPriceWithTaxes != null)
              CurrencyInfo(
                title: "PESOS ARGENTINOS + IMPUESTOS",
                symbol: '\$',
                value: data!.arsPriceWithTaxes!,
              ),
          ],
        ),
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
    CryptoEndpoints cryptoEndpoint = CryptoEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);

    API.getCryptoRate(cryptoEndpoint, forceRefresh: shouldForceRefresh).then(
      (value) {
        if (value != null && value.timestamp != null) {
          HistoricalRateManager.saveRate(
            context,
            widget.cardData.endpoint,
            widget.cardData.responseType.toString(),
            value.timestamp!,
            value,
          );
        }
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => setState(() {
            data = value;
            timestamp = data?.timestamp;
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

    if (data != null && data!.timestamp != null) {
      final arsPrice = data!.arsPrice?.isNumeric() ?? false ? numberFormat.format(double.parse(data!.arsPrice!)) : 'N/A';
      final arsPriceWithTaxes = data!.arsPriceWithTaxes?.isNumeric() ?? false ? numberFormat.format(double.parse(data!.arsPriceWithTaxes!)) : 'N/A';
      final usdPrice = data!.usdPrice?.isNumeric() ?? false ? numberFormat.format(double.parse(data!.usdPrice!)) : 'N/A';
      DateTime date = DateTime.parse(data!.timestamp!.replaceAll('/', '-'));
      String formattedTime = DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy').format(date);

      shareText = 'Dólares: \t\tUS\$ $usdPrice\nPesos: \t\t\$ $arsPrice\nPesos + Imp.: \t\$ $arsPriceWithTaxes\nHora: \t\t$formattedTime';
    }

    return shareText;
  }

  @override
  FabOptionCalculatorDialog getCalculatorWidget() {
    NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
    return FabOptionCalculatorDialog(
      calculator: CryptoCalculator(
        arsValue: double.tryParse(data?.arsPrice ?? '') ?? 0,
        arsValueWithTaxes: double.tryParse(data?.arsPriceWithTaxes ?? '') ?? 0,
        usdValue: double.tryParse(data?.usdPrice ?? '') ?? 0,
        cryptoCode: data?.code ?? '',
        numberFormat: numberFormat,
      ),
      calculatorReversed: CryptoCalculatorReversed(
        usdValue: double.tryParse(data?.usdPrice ?? '') ?? 0,
        cryptoCode: data?.code ?? '',
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

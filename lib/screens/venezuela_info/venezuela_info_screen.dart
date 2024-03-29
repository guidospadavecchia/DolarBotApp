import '../../classes/dolarbot_icons.dart';
import '../../widgets/historical_chart/historical_rate_manager.dart';
import '../base/base_info_screen.dart';
import '../../util/util.dart';
import '../../widgets/cards/factory/factory_card.dart';
import '../common/error_screen.dart';
import '../common/loading_screen.dart';
import 'package:intl/intl.dart';

class VenezuelaInfoScreen extends BaseInfoScreen {
  final CardData cardData;

  VenezuelaInfoScreen({
    required this.cardData,
  }) : super(cardData: cardData);

  @override
  _VenezuelaInfoScreenState createState() => _VenezuelaInfoScreenState();
}

class _VenezuelaInfoScreenState extends BaseInfoScreenState<VenezuelaInfoScreen> with BaseScreen {
  VenezuelaResponse? data;

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
            if (data?.bankPrice != null)
              CurrencyInfo(
                title: 'PROMEDIO BANCOS',
                symbol: 'Bs.',
                value: data!.bankPrice!,
              ),
            if (data?.blackMarketPrice != null)
              CurrencyInfo(
                title: "PARALELO",
                symbol: 'Bs.',
                value: data!.blackMarketPrice!,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget card() {
    CardData newCardData = widget.cardData.clone(bannerTitle: "Venezuela", iconAsset: DolarBotIcons.general.venezuela);
    Settings settings = Provider.of<Settings>(context, listen: false);
    return BuildCard(data).fromCardData(context, newCardData, settings);
  }

  @override
  Future loadData() async {
    VenezuelaEndpoints venezuelaEndpoint = VenezuelaEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);
    API.getVzlaRate(venezuelaEndpoint, forceRefresh: shouldForceRefresh).then(
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
    return "${widget.cardData.title} - ${widget.cardData.bannerTitle.toUpperCase()}";
  }

  @override
  String getShareText() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    NumberFormat numberFormat = settings.getNumberFormat();

    String shareText = '';

    if (data != null && data!.timestamp != null) {
      final blackMarketValue = data!.blackMarketPrice?.isNumeric() ?? false ? numberFormat.format(double.parse(data!.blackMarketPrice!)) : 'N/A';
      final banksValue = data!.bankPrice?.isNumeric() ?? false ? numberFormat.format(double.parse(data!.bankPrice!)) : 'N/A';
      DateTime date = DateTime.parse(data!.timestamp!.replaceAll('/', '-'));
      String formattedTime = DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy').format(date);

      shareText = 'Bancos: \t Bs. $banksValue\nParalelo: \t Bs. $blackMarketValue\nHora: \t $formattedTime';
    }

    return shareText;
  }

  @override
  FabOptionCalculatorDialog getCalculatorWidget() {
    NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
    return FabOptionCalculatorDialog(
      calculator: VenezuelaCalculator(
        bankValue: double.tryParse(data?.bankPrice ?? '') ?? 0,
        blackMarketValue: double.tryParse(data?.blackMarketPrice ?? '') ?? 0,
        symbol: Util.getFiatCurrencySymbol(data) ?? '',
        currencyCode: data?.currencyCode ?? '',
        numberFormat: numberFormat,
      ),
      calculatorReversed: VenezuelaCalculatorReversed(
        bankValue: double.tryParse(data?.bankPrice ?? '') ?? 0,
        blackMarketValue: double.tryParse(data?.blackMarketPrice ?? '') ?? 0,
        symbol: Util.getFiatCurrencySymbol(data) ?? '',
        currencyCode: data?.currencyCode ?? '',
        numberFormat: numberFormat,
      ),
    );
  }

  @override
  FavoriteRate createFavorite() {
    return FavoriteRate(
        endpoint: widget.cardData.endpoint,
        cardResponseType: widget.cardData.responseType.toString(),
        cardTitle: widget.cardData.title,
        cardSubtitle: null,
        cardSymbol: null,
        cardTag: widget.cardData.tag,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: DolarBotIcons.general.venezuela);
  }
}

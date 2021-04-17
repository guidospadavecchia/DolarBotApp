import 'package:dolarbot_app/api/responses/metal_response.dart';
import 'package:dolarbot_app/widgets/historical_chart/historical_rate_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/screens/common/error_screen.dart';
import 'package:dolarbot_app/screens/common/loading_screen.dart';
import 'package:intl/intl.dart';

class MetalInfoScreen extends BaseInfoScreen {
  final CardData cardData;

  MetalInfoScreen({
    @required this.cardData,
  }) : super(cardData: cardData);

  @override
  _MetalInfoScreenState createState() => _MetalInfoScreenState();
}

class _MetalInfoScreenState extends BaseInfoScreenState<MetalInfoScreen> with BaseScreen {
  MetalResponse data;

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
      child: Column(
        children: [
          banner(),
          CurrencyInfoContainer(
            items: [
              CurrencyInfo(
                title: '/ ${data.unit}',
                symbol: data.currency == 'USD' ? 'US\$' : '\$',
                value: data.value,
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
  Future loadData() async {
    MetalEndpoints metalEndpoint =
        MetalEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);
    API.getMetalRate(metalEndpoint, forceRefresh: shouldForceRefresh).then(
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
      final value = data.value.isNumeric() ? numberFormat.format(double.parse(data.value)) : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      shareText = '$symbol $value / ${data.unit}\nHora: $formattedTime';
    }

    return shareText;
  }

  @override
  FabOptionCalculatorDialog getCalculatorWidget() {
    NumberFormat numberFormat = Provider.of<Settings>(context, listen: false).getNumberFormat();
    return FabOptionCalculatorDialog(
      calculator: MetalCalculator(
        usdValue: double.tryParse(data?.value),
        unit: data?.unit,
        numberFormat: numberFormat,
      ),
      calculatorReversed: MetalCalculatorReversed(
        usdValue: double.tryParse(data?.value),
        unit: data?.unit,
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

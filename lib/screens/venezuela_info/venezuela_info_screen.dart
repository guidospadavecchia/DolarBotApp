import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
import 'package:intl/intl.dart';

class VenezuelaInfoScreen extends BaseInfoScreen {
  final String title;
  final CardData cardData;

  VenezuelaInfoScreen({
    @required this.title,
    @required this.cardData,
  }) : super(cardData: cardData, title: title);

  @override
  _VenezuelaInfoScreenState createState() => _VenezuelaInfoScreenState();
}

class _VenezuelaInfoScreenState extends BaseInfoScreenState<VenezuelaInfoScreen> with BaseScreen {
  bool isDataLoaded = false;
  VenezuelaResponse data;

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      loadData();
    }
  }

  @override
  Widget body() {
    if (!isDataLoaded) {
      return LoadingFuture();
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
                title: 'PROMEDIO BANCOS',
                symbol: 'Bs.',
                value: data.bankPrice,
              ),
              CurrencyInfo(
                title: "PARALELO",
                symbol: 'Bs.',
                value: data.blackMarketPrice,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget card() {
    CardData newCardData =
        widget.cardData.clone(title: "Venezuela", iconAsset: DolarBotIcons.general.venezuela);
    Settings settings = Provider.of<Settings>(context, listen: false);
    return BuildCard(data).fromCardData(context, newCardData, settings);
  }

  @override
  Future loadData() async {
    VenezuelaEndpoints venezuelaEndpoint =
        VenezuelaEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);
    API.getVzlaRate(venezuelaEndpoint, forceRefresh: shouldForceRefresh).then(
      (value) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => setState(() {
            data = value;
            isDataLoaded = true;
            showRefreshButton = true;
            showSimpleFabMenu();
          }),
        );
      },
    );
  }

  @override
  String getShareText() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    NumberFormat numberFormat = settings.getNumberFormat().item1;

    String shareText = '';

    if (data != null) {
      final blackMarketValue = data.blackMarketPrice.isNumeric()
          ? numberFormat.format(double.parse(data.blackMarketPrice))
          : 'N/A';
      final banksValue =
          data.bankPrice.isNumeric() ? numberFormat.format(double.parse(data.bankPrice)) : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      shareText =
          'Bancos: \t Bs. $banksValue\nParalelo: \t Bs. $blackMarketValue\nHora: \t $formattedTime';
    }

    return shareText;
  }

  @override
  FabOptionCalculatorDialog getCalculatorWidget() {
    String _currencyFormat = Provider.of<Settings>(context, listen: false).getCurrencyFormat();
    String decimalSeparator = _currencyFormat == "es_AR" ? "," : ".";
    String thousandSeparator = _currencyFormat == "es_AR" ? "." : ",";
    return FabOptionCalculatorDialog(
      calculator: VenezuelaCalculator(
        bankValue: double.tryParse(data?.bankPrice),
        blackMarketValue: double.tryParse(data?.blackMarketPrice),
        symbol: Util.getFiatCurrencySymbol(data),
        currencyCode: data?.currencyCode,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: VenezuelaCalculatorReversed(
        bankValue: double.tryParse(data?.bankPrice),
        blackMarketValue: double.tryParse(data?.blackMarketPrice),
        symbol: Util.getFiatCurrencySymbol(data),
        currencyCode: data?.currencyCode,
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
        cardTitle: widget.title,
        cardSubtitle: null,
        cardSymbol: null,
        cardTag: widget.cardData.tag,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: DolarBotIcons.general.venezuela);
  }

  @override
  Type getResponseType() => VenezuelaResponse;
}

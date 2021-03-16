import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
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

class _VenezuelaInfoScreenState extends BaseInfoScreenState<VenezuelaInfoScreen>
    with BaseScreen
    implements IShareable<VenezuelaResponse> {
  @override
  Widget body() {
    VenezuelaEndpoints venezuelaEndpoint =
        VenezuelaEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: FutureScreenDelegate(
        response: API.getVzlaRate(
          venezuelaEndpoint,
          forceRefresh: shouldForceRefresh,
        ),
        onLoading: onLoading,
        onFailedLoad: onErrorLoad,
        onSuccessfulLoad: onSuccessfulLoad,
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback((_) => setActiveData(
              data, "${widget.title} - ${widget.cardData.title}", getShareInfo(data)));

          return Column(
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
          );
        },
      ),
    );
  }

  @override
  Widget card() {
    return Consumer<ActiveScreenData>(
      builder: (context, activeData, child) {
        ApiResponse data = activeData.getActiveData();

        CardData newCardData = widget.cardData.clone(title: "Venezuela");
        return BuildCard(data).fromCardData(context, newCardData);
      },
    );
  }

  @override
  String getShareInfo(VenezuelaResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final numberFormat = new NumberFormat(
      settings.getCurrencyPattern(),
      settings.getCurrencyFormat(),
    );
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

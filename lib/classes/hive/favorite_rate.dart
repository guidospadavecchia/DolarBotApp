import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class FavoriteRate extends HiveObject {
  @HiveField(0)
  final String endpoint;
  @HiveField(1)
  final String cardResponseType;
  @HiveField(2)
  final String cardTitle;
  @HiveField(3)
  final String cardSubtitle;
  @HiveField(4)
  final String cardSymbol;
  @HiveField(5)
  final String cardTag;
  @HiveField(6)
  final List<int> cardColors;
  @HiveField(7)
  final int cardIconData;
  @HiveField(8)
  final String cardIconAsset;

  FavoriteRate({
    this.endpoint,
    this.cardResponseType,
    this.cardTitle,
    this.cardSubtitle,
    this.cardSymbol,
    this.cardTag,
    this.cardColors,
    this.cardIconData,
    this.cardIconAsset,
  });
}

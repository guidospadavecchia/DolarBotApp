import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:hive/hive.dart';

class FavoriteRateAdapter extends TypeAdapter<FavoriteRate> {
  @override
  final int typeId = 1;

  @override
  FavoriteRate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteRate(
      endpoint: fields[0] as String,
      cardResponseType: fields[1] as String,
      cardTitle: fields[2] as String,
      cardSubtitle: fields[3] as String?,
      cardSymbol: fields[4] as String?,
      cardTag: fields[5] as String,
      cardColors: (fields[6] as List).cast<int>(),
      cardIconData: fields[7] as int?,
      cardIconAsset: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteRate obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.endpoint)
      ..writeByte(1)
      ..write(obj.cardResponseType)
      ..writeByte(2)
      ..write(obj.cardTitle)
      ..writeByte(3)
      ..write(obj.cardSubtitle)
      ..writeByte(4)
      ..write(obj.cardSymbol)
      ..writeByte(5)
      ..write(obj.cardTag)
      ..writeByte(6)
      ..write(obj.cardColors)
      ..writeByte(7)
      ..write(obj.cardIconData)
      ..writeByte(8)
      ..write(obj.cardIconAsset);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteRateAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

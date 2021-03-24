import 'package:dolarbot_app/classes/hive/historical_rate.dart';
import 'package:hive/hive.dart';

class HistoricalRateAdapter extends TypeAdapter<HistoricalRate> {
  @override
  final int typeId = 2;

  @override
  HistoricalRate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoricalRate(
      endpoint: fields[0] as String,
      responseType: fields[1] as String,
      json: fields[2] as String,
      timestamp: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HistoricalRate obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.endpoint)
      ..writeByte(1)
      ..write(obj.responseType)
      ..writeByte(2)
      ..write(obj.json)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoricalRateAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

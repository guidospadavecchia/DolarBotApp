import '../cache_entry.dart';
import 'package:hive/hive.dart';

class CacheEntryAdapter extends TypeAdapter<CacheEntry> {
  @override
  final int typeId = 0;

  @override
  CacheEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheEntry(
      fields[0] as DateTime,
      fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, CacheEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.expiration)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CacheEntryAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

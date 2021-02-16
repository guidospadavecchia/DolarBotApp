import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CacheEntry extends HiveObject {
  @HiveField(0)
  final DateTime expiration;
  @HiveField(1)
  final dynamic data;

  CacheEntry(
    this.expiration,
    this.data,
  );

  bool isExpired() {
    return expiration.isBefore(DateTime.now());
  }
}

import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class HistoricalRate extends HiveObject {
  @HiveField(0)
  final String endpoint;
  @HiveField(1)
  final String responseType;
  @HiveField(2)
  final String json;
  @HiveField(3)
  final String timestamp;

  HistoricalRate({
    required this.endpoint,
    required this.responseType,
    required this.json,
    required this.timestamp,
  });
}

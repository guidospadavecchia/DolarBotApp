import 'package:dolarbot_app/classes/hive/cache_entry.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:hive/hive.dart';

class CacheManager {
  static final cache = Hive.box('cache');

  static CacheEntry? read(String key) {
    return cache.get(key);
  }

  static void save(String key, dynamic data) {
    CacheEntry cachedObject = CacheEntry(_getNewExpiration(), data);
    cache.put(key, cachedObject);
  }

  static DateTime _getNewExpiration() {
    int expirationMinutes =
        int.tryParse(Util.cfg.get("apiRequestCacheMinutes").toString()) ?? Duration.minutesPerHour;
    return DateTime.now().add(Duration(minutes: expirationMinutes));
  }
}

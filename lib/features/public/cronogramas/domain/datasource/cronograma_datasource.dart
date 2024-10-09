import '../domains.dart';

abstract class CronogramaDatasource {
  Future<List<Cronograma>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''});
}

import '../domains.dart';

abstract class CronogramasRepository {
  Future<List<Cronograma>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''});
}

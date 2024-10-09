import '../../domain/domains.dart';

class CronogramasRepositoryImpl extends CronogramasRepository {
  CronogramaDatasource datasource;
  CronogramasRepositoryImpl(this.datasource);

  @override
  Future<List<Cronograma>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) {
    return datasource.getEvenntosByPage(
        limit: limit, offset: offset, apikey: apikey);
  }
}

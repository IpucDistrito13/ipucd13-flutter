import '../../domain/domains.dart';

class EventosRepositoryImpl extends EventosRepository {
  EventosDatasource datasource;
  EventosRepositoryImpl(this.datasource);

  @override
  Future<List<Evento>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) {
    return datasource.getEvenntosByPage(
        limit: limit, offset: offset, apikey: apikey);
  }
}

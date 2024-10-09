import '../domains.dart';

abstract class EventosDatasource {
  Future<List<Evento>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''});
}

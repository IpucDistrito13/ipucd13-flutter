import '../domains.dart';

abstract class EventosRepository {
  Future<List<Evento>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''});
}

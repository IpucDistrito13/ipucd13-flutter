import '../../domain/domains.dart';
import '../infrastructure.dart';

class CronogramaMapper {
  static Cronograma cronogramaToEntity(CronogramaServer evento) => Cronograma(
        id: evento.id,
        nombre: evento.nombre,
        start: evento.start,
        end: evento.end,
        lugar: evento.lugar ?? '',
        descripcion: evento.descripcion ?? '',
        url: evento.url ?? '',
      );
}

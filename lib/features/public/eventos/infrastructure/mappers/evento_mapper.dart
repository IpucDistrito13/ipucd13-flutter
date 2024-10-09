import '/features/public/eventos/domain/domains.dart';

import '../infrastructure.dart';

class EventoMapper {
  static Evento eventoToEntity(EventoServer evento) => Evento(
        id: evento.id,
        nombre: evento.nombre,
        start: evento.start,
        end: evento.end,
        lugar: evento.lugar ?? '',
        descripcion: evento.descripcion ?? '',
        url: evento.url ?? '',
      );
}

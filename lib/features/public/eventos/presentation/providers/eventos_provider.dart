//3
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/public/eventos/domain/domains.dart';

import 'providers.dart';

final eventosProvider =
    StateNotifierProvider<EventosNotifier, EventosState>((ref) {
  final eventosRepository = ref.watch(eventosRepositoryProvider);
  return EventosNotifier(eventosRepository: eventosRepository);
});
//3.

//2
class EventosNotifier extends StateNotifier<EventosState> {
  final EventosRepository eventosRepository;

  EventosNotifier({required this.eventosRepository}) : super(EventosState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    //print('Petición eventos ');
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final eventos = await eventosRepository.getEvenntosByPage(
        limit: state.limit, offset: state.offset);

    if (eventos.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      eventos: [...state.eventos, ...eventos],
    );
  }
} //2.

//1.
class EventosState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Evento> eventos;

  EventosState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.eventos = const [],
  });

  EventosState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Evento>? eventos,
  }) =>
      EventosState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        eventos: eventos ?? this.eventos,
      );
}
//1.
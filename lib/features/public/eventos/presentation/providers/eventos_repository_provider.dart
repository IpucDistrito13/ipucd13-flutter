import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructure.dart';

final eventosRepositoryProvider = Provider<EventosRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final eventoRepository =
      EventosRepositoryImpl(EventosDatasourceImpl(accessToken: accessToken));

  return eventoRepository;
});
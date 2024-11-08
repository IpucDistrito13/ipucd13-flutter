import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructure.dart';

final cronogramasRepositoryProvider = Provider<CronogramasRepository>((ref) {
  //PERMITE REALIZAR PETICIONES A APIS PUBLICAS, EXECPTO
  //REQUIERE TOKEN PARA TURAS PROTEGIDAS
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final eventoRepository = CronogramasRepositoryImpl(
      CronogramasDatasourceImpl(accessToken: accessToken));

  return eventoRepository;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructure.dart';

final congregacionesRepositoryProvider =
    Provider<CongregacionesRepository>((ref) {
  //Permite relizar peticiones a a pis publicas
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final congregacionesRepository = CongregacionesRepositoriesImpl(
      CongregacionesDatasourceImpl(accessToken: accessToken));

  return congregacionesRepository;
});

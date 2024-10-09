import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../admin/auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructure.dart';

final lideresRepositoryProvider = Provider<LideresRepository>((ref) {
  //Permite relizar peticiones a a pis publicas
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final liderRepository =
      LideresRepositoriesImpl(LideresDatasourceImpl(accessToken: accessToken));

  return liderRepository;
});

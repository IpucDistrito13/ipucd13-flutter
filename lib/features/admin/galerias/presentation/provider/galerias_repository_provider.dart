import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/presentation/providers/auth_provider.dart';
import '/features/admin/galerias/domain/repositories/galerias_repository.dart';
import '/features/admin/galerias/infrastructure/infrastructure.dart';
import '/features/admin/galerias/infrastructure/repositories/galerias_repository_impl.dart';

final galeriasRepositoryProvider = Provider<GaleriasRepository>((ref) {
  //Permite relizar peticiones a a pis publicas
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final episodioRepository = GaleriasRepositoriesImpl(
      GaleriasDatasourceImpl(accessToken: accessToken));

  return episodioRepository;
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/datasources/galerias_datasource_impl.dart';
import '/features/admin/auth/presentation/providers/auth_provider.dart';
import '/features/admin/galerias/domain/repositories/galerias_repository.dart';
import '/features/admin/galerias/infrastructure/repositories/galerias_repository_impl.dart';

final galeriasRepositoryProvider = Provider<GaleriasRepository>((ref) {
  //PERMITE REALIZAR PETICIONES A APIS PUBLICAS, EXECPTO
  //REQUIERE TOKEN PARA TURAS PROTEGIDAS
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final episodioRepository = GaleriasRepositoriesImpl(
      GaleriasDatasourceImpl(accessToken: accessToken));

  return episodioRepository;
});

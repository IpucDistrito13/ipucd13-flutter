import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/presentation/providers/auth_provider.dart';
import '/features/public/comites/domain/repositories/comites_repository.dart';
import '/features/public/comites/infrastructure/datasources/comites_datasource_imp.dart';
import '/features/public/comites/infrastructure/repositories/comites_repository_impl.dart';

final comitesRepositoryProvider = Provider<ComitesRepository>((ref) {
  //PERMITE REALIZAR PETICIONES A APIS PUBLICAS, EXECPTO
  //REQUIERE TOKEN PARA TURAS PROTEGIDAS
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final comitesRepository =
      ComitesRepositoryImpl(ComitesDatasourceImp(accessToken: accessToken));

  return comitesRepository;
});

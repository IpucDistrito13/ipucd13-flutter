import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/presentation/providers/auth_provider.dart';
import '/features/public/comites/domain/repositories/comites_repository.dart';
import '/features/public/comites/infrastructure/datasources/comites_datasource_imp.dart';
import '/features/public/comites/infrastructure/repositories/comites_repository_impl.dart';

final comitesRepositoryProvider = Provider<ComitesRepository>((ref) {
  //Al ser watch, cuando el authProvider cambie si se logueo usuario se deslogueo
  //atambien actualiza todo lo que hay

  //Cuando un usuario se desloguea continua con token vacio
  //los endponts publicos continua funcionado execto los protegidos
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final comitesRepository =
      ComitesRepositoryImpl(ComitesDatasourceImp(accessToken: accessToken));

  return comitesRepository;
});

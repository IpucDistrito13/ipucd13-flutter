import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/presentation/providers/auth_provider.dart';
import '/features/admin/solicitudes/archivos_descargable/domain/repositories/archivos_descargable_repository.dart';
import '/features/admin/solicitudes/archivos_descargable/infrastructure/datasources/archivos_descargable_impl.dart';
import '/features/admin/solicitudes/archivos_descargable/infrastructure/repositories/archivos_descargable_repository_impl.dart';

final archivosDescargableRepositoryProvider =
    Provider<ArchivosDescargableRepository>((ref) {
  //Permite relizar peticiones a a pis publicas
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final congregacionesRepository = ArchivosDescargableRepositoryImpl(
      ArchivosDescargableImpl(accessToken: accessToken));

  return congregacionesRepository;
});
